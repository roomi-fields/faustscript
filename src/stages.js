// Writing a graph in Faust, when signals are shared inside it.
//
// Faust duplicates any name it meets twice: writing `output` in two places
// would build two amplifiers with two memories. For an instance to stay a
// single circuit, it has to be written once and the signals routed around it.
//
// The method: arrange the modules in stages, stack those of the same stage,
// and place between two stages the routing that sends each channel where it
// goes. What will still be needed later crosses the stage on a carry wire.
//
// A channel the routing does not mention is worth zero — that is what gives,
// without writing anything, the language's rule: cutting a wire puts silence
// there.

/** Arranges the instances in stages: nobody depends on a later stage. */
export function stage(graph) {
  const left = new Map()
  const boucles = loopsOf(graph)
  const modulateurs = modulatorsOf(graph)
  for (const [name, instance] of graph.instances) {
    // the return of a loop does not live alone: it is written with its source;
    // a signal that only drives a setting is written inside the module it
    // drives, and has no business in the flow
    if (!instance.removed && !boucles.has(name) && !modulateurs.has(name)) {
      left.set(name, instance)
    }
  }

  const sourcesDe = name => graph.incomingTo(name)
    .filter(c => !c.to.member && !c.loop && left.has(c.from.name))
    .map(c => c.from.name)

  const stages = []
  const placed = new Set()
  while (left.size) {
    const stage = [...left.keys()]
      .filter(name => sourcesDe(name).every(source => placed.has(source)))
    if (!stage.length) break              // a cycle: we stop there
    for (const name of stage) { placed.add(name); left.delete(name) }
    stages.push(stage)
  }
  return { stages, left: [...left.keys()], boucles }
}

/** The instances that do nothing but drive settings.
 *
 * They are written inside the definition of the module they drive; putting
 * them back into the flow would duplicate them — and Faust would make two
 * circuits out of them.
 */
function modulatorsOf(graph) {
  const modulateurs = new Set(citedInABody(graph))
  let change = true
  while (change) {
    change = false
    for (const name of graph.instances.keys()) {
      if (modulateurs.has(name)) continue
      const sortants = graph.wires.filter(c => c.from.name === name)
      if (!sortants.length) continue
      // are all its destinations settings, or other modulators?
      const queDesReglages = sortants.every(c =>
        c.to.member || modulateurs.has(c.to.name))
      if (queDesReglages) { modulateurs.add(name); change = true }
    }
  }
  return modulateurs
}

/** The instances another one cites in its body.
 *
 * `let computation1 pedale * 3800` writes `pedale` in its own text: putting
 * it back into the flow would make it exist twice.
 */
function citedInABody(graph) {
  const cites = new Set()
  for (const instance of graph.instances.values()) {
    const body = String(instance.module ?? '')
    for (const autre of graph.instances.keys()) {
      if (autre === instance.name) continue
      if (new RegExp(`\\b${autre}\\b`).test(body)) cites.add(autre)
    }
  }
  return cites
}

/** Returns {return -> source} for each feedback loop that has been placed. */
export function loopsOf(graph) {
  const boucles = new Map()
  for (const wire of graph.wires) {
    if (wire.loop) boucles.set(wire.to.name, wire.from.name)
  }
  return boucles
}

/** Writes the whole graph as one Faust expression, without duplicating a name. */
export function writeInStages(graph, catalogue, templates) {
  const { stages, boucles } = stage(graph)
  if (!stages.length) return null

  const retours = new Map()               // source -> return, the other way round
  for (const [retour, source] of boucles) retours.set(source, retour)

  const block = name => {
    const instance = graph.instance(name)
    if (instance?.bypassed) {
      return templates.fill('template.Bypass', { module: name })
    }
    if (!retours.has(name)) return name
    // does it also receive a signal from outside? then sum it with the return
    const dehors = graph.incomingTo(name).some(c => !c.to.member && !c.loop)
    const patron = dehors ? 'template.FedFeedback' : 'template.Feedback'
    return '(' + templates.fill(patron, { a: name, b: retours.get(name) }) + ')'
  }

  let bus = []                            // the live channels, in order
  const pieces = []

  stages.forEach((stage, rank) => {
    const attendus = neededAfter(stages, rank, graph)

    if (bus.length) {
      const needs = stage.flatMap(name => wantedInputs(name, graph, catalogue, templates))
      const carried = bus.filter(channel => attendus.has(channel.name))
      const routage = route(bus, [...needs, ...carried])
      if (routage) pieces.push(routage)

      const blocks = stage.map(block)
      if (carried.length) blocks.push(`si.bus(${carried.length})`)
      pieces.push(inParallel(blocks))

      bus = [...stage.flatMap(name => outputsOf(name, graph, catalogue)), ...carried]
    } else {
      pieces.push(inParallel(stage.map(block)))
      bus = stage.flatMap(name => outputsOf(name, graph, catalogue))
    }
  })

  // keep only what really goes out: what goes to the sink
  const versLePuits = graph.incomingTo(graph.sink).map(c => c.from.name)
  const gardees = bus
    .map((channel, slot) => ({ channel, slot }))
    .filter(({ channel }) => versLePuits.includes(channel.name))
  if (gardees.length && gardees.length < bus.length) {
    pieces.push(`route(${bus.length}, ${gardees.length}, ` +
      gardees.map(({ slot }, rank) => `${slot + 1},${rank + 1}`).join(', ') + ')')
  }
  return pieces.join(' : ')
}

function inParallel(blocks) {
  return blocks.length === 1 ? blocks[0] : `(${blocks.join(', ')})`
}

/** The channels a module puts on the bus. */
function outputsOf(name, graph, catalogue) {
  const instance = graph.instance(name)
  const module = catalogue.get(instance?.module)
  const count = (module?.outputs ?? 1) * (instance?.multiplicity ?? 1)
  return Array.from({ length: count }, (_, rank) => ({ name, rank }))
}

/** How many inputs an instance expects.
 *
 * The catalogue says so for a known module. For a body written by hand —
 * `vcab = *` — it can only be deduced from what arrives at it: a `*` fed by
 * two wires has two, fed by one wire and a setting, one.
 */
function howManyInputs(name, graph, catalogue, templates) {
  const instance = graph.instance(name)
  const module = catalogue.get(instance?.module)
  const parLesReglages = inputsFromModulators(name, graph, templates)
  if (module) {
    return (module.inputs ?? 0) * (instance?.multiplicity ?? 1) + parLesReglages
  }

  // ⚠️ A body written by hand: we read it, for want of better. The compiler
  // would say it exactly — that is what will have to be done — but it would
  // have to be called here, which the emitter does not do.
  const body = (instance?.module ?? '').trim()
  const wires = graph.incomingTo(name).filter(c => !c.to.member).length

  if (/^[*+\-\/^%]$/.test(body)) return 2 + parLesReglages
  if (/^[*+\-\/^%]\s*\(/.test(body)) return 1 + parLesReglages
  if (body === templates.reserved('input')) return 1  // a named input
  return (wires ? 1 : 0) + parLesReglages
}

/** The inputs a module gains from the signals that drive its settings.
 *
 * An LFO wired to a port brings nothing; but if what drives it comes through
 * one of the program's inputs — a pedal — that input becomes the module's
 * too, since it is written inside its definition.
 */
function inputsFromModulators(name, graph, templates) {
  const input = templates.reserved('input')
  let count = 0
  for (const wire of graph.wires) {
    if (wire.to.name !== name || !wire.to.member) continue
    const source = graph.instance(wire.from.name)
    if (!source) continue
    const body = String(source.module ?? '')
    for (const autre of graph.instances.values()) {
      if (String(autre.module ?? '').trim() !== input) continue
      if (new RegExp(`\\b${autre.name}\\b`).test(body)) count++
    }
    if (body.trim() === input) count++
  }
  return count
}

/** The channels a module expects, filled by its wires in order.
 *
 * What no wire fills stays without a source, and is therefore zero.
 */
function wantedInputs(name, graph, catalogue, templates) {
  const count = howManyInputs(name, graph, catalogue, templates)
  const wires = graph.incomingTo(name).filter(c => !c.to.member)

  return Array.from({ length: count }, (_, slot) => {
    const wire = wires[slot % Math.max(wires.length, 1)]
    if (!wire) return null
    const source = wire.from.name
    const channels = outputsOf(source, graph, catalogue).length

    // as many channels on both sides: they are paired one to one.
    // more channels than slots: they sum onto the ones that remain.
    // fewer: the channel is spread, every slot receives the same one.
    if (channels === count) return { name: source, rank: slot }
    if (channels > count) return { name: source, rank: null }
    return { name: source, rank: slot % channels }
  })
}

/** The names that will still be needed after this stage. */
function neededAfter(stages, rank, graph) {
  const attendus = new Set()
  for (const name of stages.slice(rank + 1).flat()) {
    for (const wire of graph.incomingTo(name)) {
      if (!wire.to.member) attendus.add(wire.from.name)
    }
  }
  for (const wire of graph.incomingTo(graph.sink)) attendus.add(wire.from.name)
  return attendus
}

/** Faust's routing: each wanted slot receives the channel that is due to it. */
function route(bus, wanted) {
  if (!wanted.length) return null
  const pairs = []
  wanted.forEach((wanted, slot) => {
    if (!wanted) return                   // nothing here: the channel will be zero
    // a missing rank means "every channel of this name": Faust adds up what
    // arrives on the same slot
    bus.forEach((channel, source) => {
      if (channel.name !== wanted.name) return
      if (wanted.rank !== null && channel.rank !== wanted.rank) return
      pairs.push(`${source + 1},${slot + 1}`)
    })
  })
  if (!pairs.length) return null
  return `route(${bus.length}, ${wanted.length}, ${pairs.join(', ')})`
}
