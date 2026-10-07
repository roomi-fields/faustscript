// The graph: what exists at this instant.
//
// It holds the instances that have been placed, their settings, and the wires
// between them. It is the transpiler's only state, and it is what separates a
// line that describes from a line that modifies.
//
// No sign of the language is written here: the graph handles names — the ones
// the musician chose — and relations between them.

/** An instance that has been placed: a module, a name, and what was done to it. */
class Instance {
  constructor(name, module, multiplicity = 1) {
    this.name = name
    this.module = module // the module's name, or an expression
    this.multiplicity = multiplicity
    this.settings = new Map() // "cutoff" -> "400"
    this.bypassed = false
    this.removed = false
  }
}

/** A wire between two points, each a name and possibly a channel. */
class Wire {
  constructor(from, to, width = null, loop = false) {
    this.from = from // {name, member}
    this.to = to
    this.width = width // how many instances, if the wire places any
    this.loop = loop // feedback: the output comes back to the input
  }

  sameAs(other) {
    return same(this.from, other.from) && same(this.to, other.to)
  }
}

function same(a, b) {
  return a.name === b.name && (a.member ?? null) === (b.member ?? null)
}

/** What a gesture returns: it happened, or it was refused and nothing moved. */
export class Outcome {
  constructor(done, reason = null) {
    this.done = done
    this.reason = reason
  }
  static ok() {
    return new Outcome(true)
  }
  static refused(reason) {
    return new Outcome(false, reason)
  }
}

export class Graph {
  constructor(catalogue) {
    this.catalogue = catalogue
    this.instances = new Map()
    this.wires = []
  }

  // --- what exists -----------------------------------------------------------

  instance(name) {
    return this.instances.get(name)
  }
  module(name) {
    return this.catalogue.get(name)
  }

  /** The modules whose Faust name ends with this member: `lowpass` gives
   *  `fi.lowpass`, `SR` gives `ma.SR` and `pl.SR`. */
  modulesEndingWith(member) {
    if (!this.members) {
      this.members = new Map()
      for (const name of this.catalogue.keys()) {
        const last = name.slice(name.lastIndexOf('.') + 1)
        this.members.set(last, [...(this.members.get(last) ?? []), name])
      }
    }
    return this.members.get(member) ?? []
  }

  /** What a name of one member that no instance bears is, when it ends the
   *  name of catalogue modules: the sentence that names them; otherwise null. */
  shortName(name) {
    const modules = this.instances.has(name) ? [] : this.modulesEndingWith(name)
    if (!modules.length || modules.includes(name)) {
      return null
    }
    return `${name} is not a module; ${modules.join(', ')} ${modules.length > 1 ? 'are' : 'is'}`
  }

  /** A name is free if it designates neither an instance nor a module. */
  free(name) {
    return !this.instances.has(name) && !this.catalogue.has(name)
  }

  // --- placing and releasing --------------------------------------------------

  place(name, module, multiplicity = 1, settings = new Map()) {
    if (this.instances.has(name)) {
      return Outcome.refused(`${name} is already placed`)
    }
    const instance = new Instance(name, module, multiplicity)
    instance.settings = settings
    this.instances.set(name, instance)
    return Outcome.ok()
  }

  /** The name is given back; whatever was ringing inside drains elsewhere. */
  release(name) {
    if (!this.instances.has(name)) {
      return Outcome.refused(`${name} does not exist`)
    }
    this.instances.delete(name)
    this.wires = this.wires.filter(w => w.from.name !== name && w.to.name !== name)
    return Outcome.ok()
  }

  /** The body changes, the memory stays: it is the same instance. */
  replace(name, module, settings = new Map()) {
    const instance = this.instances.get(name)
    if (!instance) {
      return Outcome.refused(`${name} does not exist`)
    }
    instance.module = module
    for (const [port, value] of settings) {
      instance.settings.set(port, value)
    }
    return Outcome.ok()
  }

  // --- gestures on an instance ------------------------------------------------

  bypass(name, bypassed = true) {
    const instance = this.instances.get(name)
    if (!instance) {
      return Outcome.refused(`${name} does not exist`)
    }
    instance.bypassed = bypassed
    return Outcome.ok()
  }

  /** Take an instance out of the flow: it and its wires, but its name stays taken. */
  remove(name) {
    const instance = this.instances.get(name)
    if (!instance) {
      return Outcome.refused(`${name} does not exist`)
    }
    instance.removed = true
    this.wires = this.wires.filter(w => w.from.name !== name && w.to.name !== name)
    return Outcome.ok()
  }

  // --- wiring -----------------------------------------------------------------

  connect(from, to, width = null, loop = false) {
    for (const end of [from, to]) {
      if (!this.known(end.name)) {
        return Outcome.refused(this.shortName(end.name) ?? `${end.name} does not exist`)
      }
    }
    // a setting is driven by a signal, not by what travels through the program
    if (to.member && this.carriesAnInput(from.name)) {
      return Outcome.refused(
        `${from.name} carries one of the program's inputs: ` +
          `a setting can only be driven by a signal`
      )
    }
    const wire = new Wire(from, to, width, loop)
    if (this.wires.some(w => w.sameAs(wire))) {
      return Outcome.ok()
    }
    this.wires.push(wire)
    return Outcome.ok()
  }

  /** Cutting does not take the input away: it receives silence. */
  cut(from, to) {
    const before = this.wires.length
    this.wires = this.wires.filter(w => !w.sameAs(new Wire(from, to)))
    return before === this.wires.length
      ? Outcome.refused('no wire between these two points')
      : Outcome.ok()
  }

  known(name) {
    return this.instances.has(name) || name === this.sinkName
  }

  /** Does this name carry one of the program's inputs, directly or in its body?
   *
   * Faust refuses a parameter that consumes an input: `fi.lowpass(3, calc)`
   * where `calc` has one does not compile. Better say so here, plainly.
   */
  carriesAnInput(name, seen = new Set()) {
    if (seen.has(name)) {
      return false
    }
    seen.add(name)
    const instance = this.instances.get(name)
    if (!instance) {
      return false
    }
    const body = String(instance.module ?? '').trim()
    if (body === this.inputSign) {
      return true
    }
    for (const other of this.instances.keys()) {
      if (other === name) {
        continue
      }
      if (new RegExp(`\\b${other}\\b`).test(body) && this.carriesAnInput(other, seen)) {
        return true
      }
    }
    return this.wires.some(
      w => w.to.name === name && !w.to.member && this.carriesAnInput(w.from.name, seen)
    )
  }

  // --- setting -----------------------------------------------------------------

  set(name, port, value) {
    const instance = this.instances.get(name)
    if (!instance) {
      return Outcome.refused(`${name} does not exist`)
    }
    instance.settings.set(port, value)
    return Outcome.ok()
  }

  /** The sink bears the name the language gives it; the graph does not choose it. */
  set sink(name) {
    this.sinkName = name
  }
  get sink() {
    return this.sinkName
  }

  /** What arrives at a given point, in the order it was wired. */
  incomingTo(name, member = null) {
    return this.wires.filter(w => w.to.name === name && (member === null || w.to.member === member))
  }
}
