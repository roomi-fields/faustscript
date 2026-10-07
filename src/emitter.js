import { parser } from './parser.js'
import { callsByName } from './catalogue.js'

// The emitter: it writes the Faust the graph describes.
//
// It knows neither FaustScript's signs nor Faust's — the first live in the
// grammar, the second in `lib/translation.fsc`. All it does is choose which
// template to fill.

/** The Faust body of an instance, without the definition around it. */
export function corpsDe(instance, catalogue, templates) {
  const line = writeInstance(instance, catalogue, templates)
  return line.slice(line.indexOf('=') + 1, line.lastIndexOf(';')).trim()
}

/** Writes the Faust definition of an instance that has been placed. */
export function writeInstance(instance, catalogue, templates, graph = null) {
  const module = catalogue.get(instance.module)

  // a body that is not a plain module is an expression: every module it
  // recognises is translated, and the rest passes as it stands — it is Faust
  if (!module) {
    let body = translateExpression(instance.module, instance.name, catalogue, templates)
    if (instance.multiplicity > 1) {
      body = templates.fill('template.Multiple', {
        i: templates.reserved('index'),
        n: instance.multiplicity,
        body,
      })
    }
    if (carriesAControl(body)) {
      body = templates.fill('template.Group', { name: instance.name, body })
    }
    return templates.fill('template.Instance', { name: instance.name, body })
  }

  const arguments_ = module.parameters.map(parameter =>
    writeArgument(instance, module, parameter, templates, graph)
  )

  let body = arguments_.length
    ? templates.fill('template.Call', {
        module: module.body ? headOfBody(module) : module.name,
        arguments: arguments_.join(', '),
      })
    : (module.body ?? module.name)

  if (instance.multiplicity > 1) {
    body = templates.fill('template.Multiple', {
      i: templates.reserved('index'),
      n: instance.multiplicity,
      body,
    })
  }
  if (arguments_.some(carriesAControl)) {
    body = templates.fill('template.Group', { name: instance.name, body })
  }
  return templates.fill('template.Instance', { name: instance.name, body })
}

/** Has a control been written here?
 *
 * A control is the only thing that carries a label, so the only thing that
 * needs the instance's name in front of its path. Whoever hosts FaustScript reaches
 * a setting at `/<program>/<instance>/<port>`, and that only holds if every
 * instance that carries one is grouped — including those whose body is a free
 * expression. Two instances each holding a `gain` would otherwise collide, and
 * Faust would refuse the program.
 */
function carriesAControl(faust) {
  return faust.includes('"')
}

/** What is passed to a parameter: a fixed value, or a named setting.
 *
 * Only what is driven gets a name: a parameter becomes a port only if the
 * musician wrote it. The others stay constants, which lets Faust precompute
 * them — and above all, which avoids offering a slider where the module
 * accepts none: a filter's order fixes its structure, it cannot move while
 * the sound is playing.
 */
function writeArgument(instance, module, parameter, templates, graph) {
  // a signal wired to this port drives it: it replaces any value
  const module_ = driver(instance, module, parameter, templates, graph)
  if (module_) {
    return module_
  }

  const pose = instance.settings.get(parameter.name)
  const start = pose ?? parameter.fallback
  if (start === null || start === undefined) {
    return parameter.name
  }
  // a value given in a Faust definition is a constant: no instance carries it
  if (pose === undefined || instance.constant) {
    return start
  }

  // a parameter that is not a setting never becomes a port
  if (module.attribute(parameter.name, 'nature')) {
    return start
  }

  const min = module.attribute(parameter.name, 'min')
  const max = module.attribute(parameter.name, 'max')
  const bounded = min !== undefined && max !== undefined

  // the rule lives in the templates, not here: does a port require bounds?
  if (!bounded && templates.value('rule.port.requiresBounds') === 'yes') {
    return start
  }

  return templates.fill(templates.value(bounded ? 'rule.port.bounded' : 'rule.port.free'), {
    label: writeLabel(module, parameter.name, templates),
    default: start,
    min: min ?? templates.fallback('min'),
    max: max ?? templates.fallback('max'),
    step: templates.fallback('step'),
  })
}

/** The signal that drives this port, rescaled to its bounds.
 *
 * The module that emits has a measured range, the port has bounds: between
 * the two, Faust knows how to rescale. If either one is missing, the signal
 * passes as it stands — nothing is guessed.
 */
function driver(instance, module, parameter, templates, graph) {
  if (!graph) {
    return null
  }
  const wires = graph.incomingTo(instance.name, parameter.name)
  if (!wires.length) {
    return null
  }

  const signal = wires.map(c => c.from.name).join(', ')
  const source = graph.catalogue.get(graph.instance(wires[0].from.name)?.module)

  const fromStart = source?.attribute('output', 'min')
  const fromEnd = source?.attribute('output', 'max')
  const toStart = module.attribute(parameter.name, 'min')
  const toEnd = module.attribute(parameter.name, 'max')

  if ([fromStart, fromEnd, toStart, toEnd].some(x => x === undefined)) {
    return signal
  }
  if (fromStart === fromEnd) {
    return signal
  }

  return templates.fill('template.Rescale', {
    signal,
    fromStart,
    fromEnd,
    toStart,
    toEnd,
  })
}

/** A port's label carries its metadata between brackets. */
function writeLabel(module, nomDuPort, templates) {
  const metadata = []
  for (const [key, value] of module.attributes) {
    const [port, attribute] = key.split('.')
    if (port !== nomDuPort) {
      continue
    }
    if (attribute === 'min' || attribute === 'max' || attribute === 'nature') {
      continue
    }
    if (attribute === 'example' || attribute === 'measure') {
      continue
    }
    metadata.push(templates.fill('template.Metadatum', { key: attribute, value }))
  }
  return templates.fill('template.Label', {
    name: nomDuPort,
    metadata: metadata.join(''),
  })
}

/** Writes the expression the sink receives, by climbing back up the wires.
 *
 * A wire aimed at a port — `lfo1 : lpf1.cutoff` — does not count here: it
 * modulates a setting, it does not enter the flow.
 */
export function writeExpression(graph, catalogue, templates, seen = new Set()) {
  return remonter(graph.sink, graph, catalogue, templates, seen)
}

function remonter(name, graph, catalogue, templates, seen) {
  const entrants = graph.incomingTo(name).filter(c => !c.to.member)
  const instance = graph.instance(name)

  // a bypassed instance lets the signal through; removed, it returns nothing
  const soi = instance?.removed
    ? templates.fill('template.Removal', { module: name })
    : instance?.bypassed
      ? templates.fill('template.Bypass', { module: name })
      : name

  if (!entrants.length) {
    return name === graph.sink ? null : soi
  }
  if (seen.has(name)) {
    return soi
  } // a cycle: we climb it only once
  seen.add(name)

  const sources = entrants.map(
    c => remonter(c.from.name, graph, catalogue, templates, seen) ?? c.from.name
  )

  const amont = sources.length === 1 ? sources[0] : `(${sources.join(', ')})`

  if (name === graph.sink) {
    return amont
  }

  // what several sources become is a rule of the language: we read it, we do
  // not decide it here
  const inputs = catalogue.get(instance?.module)?.inputs
  const patron =
    sources.length > 1 && inputs === 1
      ? templates.value('rule.multipleSources.singleInput')
      : templates.value('rule.multipleSources.severalInputs')
  return templates.fill(patron, { a: amont, b: soi })
}

/** `fi.lowpass(N, fc)` → `fi.lowpass`: what is called, without its arguments. */
function headOfBody(module) {
  const parenthese = module.body.indexOf('(')
  return parenthese < 0 ? module.body : module.body.slice(0, parenthese)
}

/** Writes a Faust statement — a definition, an import, a declaration — as Faust.
 *
 * It keeps its Faust meaning: a module's name alone stays the Faust function,
 * and only a call that gives its parameters by name is written in Faust's
 * order, `os.sawtooth(freq=f)` as `os.sawtooth(f)`. The values it gives stay
 * constants: a definition is no instance, and carries no port.
 */
export function writeDefinition(text, catalogue, templates) {
  return translateExpression(text, null, catalogue, templates, true)
}

/** Translates the modules recognised inside an expression written by hand.
 *
 * `os.osc(freq=0.15) * 900 + 1100` becomes Faust: every known module takes its
 * body and its settings, the rest — operators, numbers, whatever is already
 * Faust — passes as it stands. In a Faust statement (`inFaust`), a module's
 * name alone stays as written and a call by name takes constants.
 *
 * The text is read again by our own parser: it is the tree that says where
 * the calls are, not a search for parentheses.
 */
function translateExpression(text, instanceName, catalogue, templates, inFaust = false) {
  const arbre = parser.parse(text)
  const remplacements = []

  arbre.iterate({
    enter(node) {
      if (node.name === 'NamedCall' || node.name === 'OperatorCall') {
        const rendered = translateCall(text, node.node, instanceName, catalogue, templates, inFaust)
        if (rendered !== null) {
          remplacements.push({ de: node.from, a: node.to, rendered })
          return false // do not go down: the call is already rendered
        }
      }
      // the head of a call is the call's: a module alone is its body
      if (!inFaust && node.name === 'Path' && node.node.parent?.name !== 'NamedCall') {
        const name = text.slice(node.from, node.to)
        if (catalogue.has(name)) {
          remplacements.push({
            de: node.from,
            a: node.to,
            rendered: bodyOnly(instanceName, name, new Map(), catalogue, templates),
          })
        }
      }
    },
  })

  // from the end back to the start, so the positions stay right
  let rendered = text
  for (const { de, a, rendered: quoi } of remplacements.sort((x, y) => y.de - x.de)) {
    rendered = rendered.slice(0, de) + quoi + rendered.slice(a)
  }
  return rendered
}

/** A call: `fi.lowpass(fc=800)` if it reaches a module by its parameters'
 *  names, otherwise its arguments in their order, each named one a free port. */
function translateCall(text, node, instanceName, catalogue, templates, inFaust) {
  const head = node.getChild('Path') ?? node.getChild('Operator')
  const name = head ? text.slice(head.from, head.to) : null
  const listeDArguments = node.getChild('Arguments')

  const arguments_ = []
  for (let e = listeDArguments?.firstChild; e; e = e.nextSibling) {
    if (e.name !== 'Argument') {
      continue
    }
    const key = e.node.getChild('Key')
    const value = e.node.getChild('Value')
    arguments_.push({
      key: key ? text.slice(key.from, key.to) : null,
      value: value ? text.slice(value.from, value.to) : text.slice(e.from, e.to),
    })
  }

  if (catalogue.has(name) && callsByName(listeDArguments)) {
    const settings = new Map(arguments_.map(({ key, value }) => [key, value]))
    return bodyOnly(instanceName, name, settings, catalogue, templates, inFaust)
  }

  // an operator, a call in Faust's order, or a function the catalogue does
  // not declare: what is named becomes a free port, the rest stays in place
  if (!arguments_.some(({ key }) => key)) {
    return null
  }
  const rendus = arguments_.map(({ key, value }) =>
    key
      ? templates.fill('template.FreePort', {
          label: key,
          default: value,
          min: templates.fallback('min'),
          max: templates.fallback('max'),
          step: templates.fallback('step'),
        })
      : value
  )
  return templates.fill('template.Call', { module: name, arguments: rendus.join(', ') })
}

/** The Faust body of a module, without the definition around it. */
function bodyOnly(instanceName, nomDuModule, settings, catalogue, templates, constant = false) {
  const faux = { name: instanceName, module: nomDuModule, settings, multiplicity: 1, constant }
  const line = writeInstance(faux, catalogue, templates)
  return line.slice(line.indexOf('=') + 1, line.lastIndexOf(';')).trim()
}
