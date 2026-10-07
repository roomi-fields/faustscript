// The catalogue: what the transpiler knows about modules.
//
// It knows nothing else. The names, the parameters, the starting values, the
// bounds and the output ranges all come from `lib/faust.fsc`, which is itself
// written in FaustScript and read by our own parser.
//
// This file contains no sign of the language: it only knows the names of the
// grammar's nodes, which are the interface between grammar and code.

import { parser } from './parser.js'

/** A declared module: its name, its parameters, its body, its attributes. */
class Module {
  constructor(name) {
    this.name = name
    this.parameters = [] // [{name, fallback}]
    this.body = null // the body's text, as written
    this.attributes = new Map() // "cutoff.min" -> "20"
  }

  /** The parameter of that name, or undefined. */
  parameter(name) {
    return this.parameters.find(p => p.name === name)
  }

  /** What an attribute is worth, or undefined. */
  attribute(parameter, name) {
    return this.attributes.get(`${parameter}.${name}`)
  }
}

/** Reads a catalogue written in FaustScript and returns a name -> Module table. */
export function readCatalogue(text) {
  const arbre = parser.parse(text)
  const modules = new Map()
  let courant = null

  for (let line = arbre.topNode.firstChild; line; line = line.nextSibling) {
    if (line.name === 'Comment' && courant) {
      readWidths(contenu(text, line), courant)
      continue
    }
    const definition = line.getChild('Definition')
    if (definition) {
      courant = readDefinition(text, definition)
      modules.set(courant.name, courant)
      continue
    }
    const setting = line.getChild('Setting')
    if (setting && courant) {
      readAttribute(text, setting, courant)
    }
  }
  inferMissingWidths(modules)
  return modules
}

/** What the range measurement says about inputs, when the width line is missing.
 *
 * A module measured under "silence and noise" was fed something: it therefore
 * has an input. Measured with no input, it has none. Less precise than the
 * exact count, but measured — which beats guessing.
 */
function inferMissingWidths(modules) {
  for (const module of modules.values()) {
    if (module.inputs !== undefined) {
      continue
    }
    const measure = module.attribute('output', 'measure')
    if (measure === 'silence-and-noise') {
      module.inputs = 1
      module.outputs ??= 1
    } else if (measure === 'no-input') {
      module.inputs = 0
      module.outputs ??= 1
    }
  }
}

/** The input and output counts, which generation writes as a comment of the
 * module's entry, from its definition to the next one. An entry without that
 * comment leaves the module without counts.
 *
 * ⚠️ A stopgap: this information is measured by the compiler, so it is sound,
 * but it travels in a comment rather than in an attribute.
 */
function readWidths(comment, module) {
  const counts = comment.match(/^\/\/ (\d+) inputs?, (\d+) outputs?$/)
  if (counts) {
    module.inputs = Number(counts[1])
    module.outputs = Number(counts[2])
  }
}

function readDefinition(text, node) {
  const module = new Module(contenu(text, node.getChild('Path')))
  const arguments_ = node.getChild('Arguments')
  if (arguments_) {
    for (const argument of childrenOf(arguments_, 'Argument')) {
      const key = argument.getChild('Key')
      module.parameters.push({
        name: key ? contenu(text, key).slice(0, -1) : contenu(text, argument),
        fallback: key ? contenu(text, argument.getChild('Value')) : null,
      })
    }
  }
  const body = node.getChild('NamedBody')
  if (body) {
    module.body = contenu(text, body)
  }
  return module
}

/** `cutoff.min:20` on the line after a module sets an attribute on it. */
function readAttribute(text, node, module) {
  const prefix = node.getChild('Prefix')
  const key = node.getChild('Key')
  const value = node.getChild('Value')
  if (!key || !value) {
    return
  }

  const chemin = prefix ? contenu(text, prefix) : ''
  const membres = (chemin + contenu(text, key).slice(0, -1)).split('.').filter(Boolean)

  // the last member names the attribute, what precedes it names the parameter
  if (membres.length < 2) {
    return
  }
  const nomAttribut = membres.at(-1)
  const nomParametre = membres.at(-2)
  module.attributes.set(`${nomParametre}.${nomAttribut}`, contenu(text, value))
}

/** Does a call reach a module by the names of its parameters?
 *
 * `fi.lowpass(fc:800)` does: its arguments are named, in any order. A call
 * that passes one argument without its name — `fi.lowpass(3, 800)`,
 * `fi.lowpass(3, cutoff:800)` — is written in Faust's order, and stays Faust.
 */
export function callsByName(arguments_) {
  return !arguments_ || childrenOf(arguments_, 'Argument').every(a => a.getChild('Key'))
}

// --- reading the tree ------------------------------------------------------

function contenu(text, node) {
  return node ? text.slice(node.from, node.to).trim() : null
}

function childrenOf(node, type) {
  const out = []
  for (let e = node.firstChild; e; e = e.nextSibling) {
    if (e.name === type) {
      out.push(e)
    }
  }
  return out
}
