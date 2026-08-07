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

  /** Applies a text to the graph and returns what was refused. */
  apply(text) {
    return apply(text, this.graph).filter(r => !r.outcome.done)
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
