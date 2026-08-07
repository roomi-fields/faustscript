// The transpiler: from a FaustX text, it returns Faust.
//
// All it does is chain the four pieces — the catalogue says what a module is,
// reading applies the lines to the graph, the emitter writes the Faust, and
// the templates say what it looks like.

import { readCatalogue } from './catalogue.js'
import { readTemplates } from './templates.js'
import { Graph } from './graph.js'
import { apply } from './reading.js'
import { writeInstance, writeExpression, corpsDe } from './emitter.js'
import { writeInStages } from './stages.js'

/** The gestures that change an instance's circuit, and so cost a compilation.
 *
 * The others cost none: wiring is the host's business, a setting is written on
 * the running circuit through its control path, and giving a name back removes
 * a circuit rather than building one.
 */
const RECOMPILES = new Set(['place', 'replace', 'bypass', 'remove'])

export function createTranspiler(texteDuCatalogue, texteDesPatrons) {
  const catalogue = readCatalogue(texteDuCatalogue)
  const templates = readTemplates(texteDesPatrons)
  return new Transpiler(catalogue, templates)
}

export class Transpiler {
  constructor(catalogue, templates) {
    this.catalogue = catalogue
    this.templates = templates
    this.graph = new Graph(catalogue)
    this.graph.sink = templates.reserved('sink')
    this.graph.inputSign = templates.reserved('input')
  }

  /** Applies a text to the graph and returns, line by line, what it did.
   *
   * Each line comes back with its gesture, the instance it touched, and — when
   * that instance's circuit changed — the Faust for that instance alone. A
   * host recompiles that, not the program: some 32 ms instead of 620 for a
   * fifty-module program, which is the whole reason the language exists.
   *
   * A line that was refused carries the reason and changed nothing.
   */
  apply(text) {
    return apply(text, this.graph, result => {
      if (!result.outcome.done || !RECOMPILES.has(result.gesture)) return {}
      const instance = this.graph.instance(result.name)
      if (!instance) return {}
      const faust = writeInstance(instance, this.catalogue, this.templates, this.graph)
      return { faust, needs: this.citedIn(faust, instance.name) }
    })
  }

  /** The other instances a piece of Faust names.
   *
   * A module whose settings are all its own compiles on its own; one whose
   * setting is driven by another instance — `lfo1 : lpf1.fc` — does not, and a
   * host has to know which before it sends the text to the compiler.
   */
  citedIn(faust, itself) {
    const cited = []
    for (const name of this.graph.instances.keys()) {
      if (name === itself) continue
      if (new RegExp(`\\b${name}\\b`).test(faust)) cited.push(name)
    }
    return cited
  }

  /** Writes the Faust program the graph describes at this instant.
   *
   * An instance that feeds several destinations cannot be written twice —
   * Faust would make two circuits out of it. As soon as a signal is shared,
   * the graph is therefore written in stages, with the routing that goes with
   * it.
   */
  write() {
    const lines = [this.templates.value('template.Header')]
    for (const instance of this.graph.instances.values()) {
      if (instance.removed) continue
      lines.push(writeInstance(instance, this.catalogue, this.templates, this.graph))
    }
    const expression = this.shares()
      ? writeInStages(this.graph, this.catalogue, this.templates)
      : writeExpression(this.graph, this.catalogue, this.templates)
    lines.push(this.templates.fill('template.Sink', {
      expression: expression ?? this.templates.value('template.Silence'),
    }))
    return lines.join('\n') + '\n'
  }

  /** Does one instance feed more than one destination? */
  shares() {
    const destinations = new Map()
    for (const wire of this.graph.wires) {
      destinations.set(wire.from.name, (destinations.get(wire.from.name) ?? 0) + 1)
    }
    return [...destinations.values()].some(count => count > 1)
  }
}
