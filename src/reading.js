// Reading: what an analysed line does to the graph.
//
// It knows nothing but the names of the grammar's nodes. What each gesture
// means lives in the graph; what each form becomes in Faust lives in the
// templates. Here we only join the two.

import { parser } from './parser.js'
import { Outcome } from './graph.js'

/** Applies a FaustX text to a graph, line by line.
 *
 * Each line comes back with what it did — which gesture, on which instance.
 * That is what lets a host recompile only the module a gesture touched instead
 * of the whole program.
 */
export function apply(text, graph, alsoNote = () => ({})) {
  const arbre = parser.parse(text)
  const resultats = []
  for (const line of childrenOf(arbre.topNode, 'Line')) {
    const form = line.firstChild
    const result = {
      line: lineNumber(text, line.from),
      text: contenu(text, line),
      outcome: applyLine(text, line, graph),
      ...gestureOf(text, form),
    }
    // noted here and not once the text is over: a later line may release the
    // very instance this one laid down, and the gesture must say what it did
    // at the moment it did it
    resultats.push({ ...result, ...alsoNote(result) })
  }
  return resultats
}

/** Which gesture a line is, and on which instance.
 *
 * The gesture names are the graph's own — place, replace, release, remove,
 * bypass, set, wire — because that is what a gesture does, and a host acts on
 * that, not on the shape of the line that expressed it.
 */
const GESTURES = {
  Declaration: 'place', Definition: 'replace', Release: 'release',
  Removal: 'remove', Bypass: 'bypass', Setting: 'set', Expression: 'wire',
}

function gestureOf(text, form) {
  const gesture = form ? GESTURES[form.name] ?? null : null
  return { gesture, name: gesture ? targetOf(text, form, gesture) : null }
}

/** The instance a gesture acts on. A wiring acts on no single one. */
function targetOf(text, form, gesture) {
  if (gesture === 'wire') return null
  if (gesture === 'place') return declaredName(text, form)
  if (gesture === 'set') {
    const prefix = form.getChild('Prefix')
    const key = form.getChild('Key')
    if (!key) return null
    return ((prefix ? contenu(text, prefix) : '') +
            contenu(text, key).slice(0, -1)).split('.').filter(Boolean)[0] ?? null
  }
  return nameOf(text, form)
}

function applyLine(text, line, graph) {
  const form = line.firstChild
  if (!form) return Outcome.refused('empty line')

  switch (form.name) {
    case 'Declaration':   return slot(text, form, graph)
    case 'Release':       return graph.release(nameOf(text, form))
    case 'Removal':   return graph.remove(nameOf(text, form))
    case 'Bypass': return bypass(text, form, graph)
    case 'Setting':       return set(text, form, graph)
    case 'Definition':    return definir(text, form, graph)
    case 'Expression':    return wire(text, form, graph)
    default:              return Outcome.refused(`unknown form: ${form.name}`)
  }
}

// --- placing -----------------------------------------------------------------

/** The name a declaration lays down, whether single or a bank of several. */
function declaredName(text, form) {
  const multiple = form.getChild('MultipleName')
  return multiple
    ? contenu(text, multiple.getChild('Key')).slice(0, -1)
    : contenu(text, form.getChild('Name'))
}

function slot(text, form, graph) {
  const multiple = form.getChild('MultipleName')
  const name = declaredName(text, form)
  const multiplicity = multiple
    ? Number(contenu(text, multiple.getChild('Number')))
    : 1

  const body = form.getChild('FreeBody')
  const { module, settings } = readBody(text, body, graph)
  return graph.place(name, module, multiplicity, settings)
}

/** A body is either a module being called, or a Faust expression as it stands. */
function readBody(text, body, graph = null) {
  const appel = firstOf(body, 'NamedCall')
  if (appel && contenu(text, body) === contenu(text, appel)) {
    const name = contenu(text, appel.getChild('Path'))
    // a module the catalogue does not know keeps its text: its arguments are
    // positional, and reducing them to their name would lose them
    if (graph && !graph.catalogue.has(name)) {
      return { module: contenu(text, body), settings: new Map() }
    }
    return {
      module: name,
      settings: readArguments(text, appel.getChild('Arguments')),
    }
  }
  const chemin = firstOf(body, 'Path')
  if (chemin && contenu(text, body) === contenu(text, chemin)) {
    return { module: contenu(text, chemin), settings: new Map() }
  }
  return { module: contenu(text, body), settings: new Map() }
}

function readArguments(text, node) {
  const settings = new Map()
  if (!node) return settings
  for (const argument of childrenOf(node, 'Argument')) {
    const key = argument.getChild('Key')
    if (key) {
      settings.set(contenu(text, key).slice(0, -1),
                   contenu(text, argument.getChild('Value')))
    }
  }
  return settings
}

// --- the other gestures ------------------------------------------------------

function bypass(text, form, graph) {
  const remet = form.firstChild?.name === 'bang'
  return graph.bypass(nameOf(text, form), !remet)
}

function definir(text, form, graph) {
  const name = contenu(text, form.getChild('Path'))
  const body = form.getChild('NamedBody')
  const { module, settings } = readBody(text, body, graph)
  // does the name designate a placed instance? then its body is replaced
  if (graph.instance(name)) return graph.replace(name, module, settings)
  return Outcome.refused(`${name} is not a placed instance`)
}

function set(text, form, graph) {
  const prefix = form.getChild('Prefix')
  const key = form.getChild('Key')
  const value = form.getChild('Value')
  if (!key || !value) return Outcome.refused('incomplete setting')

  const membres = ((prefix ? contenu(text, prefix) : '') +
                   contenu(text, key).slice(0, -1)).split('.').filter(Boolean)
  if (membres.length < 2) return Outcome.refused('a setting targets a port')
  return graph.set(membres[0], membres.slice(1).join('.'),
                       contenu(text, value))
}

// --- wiring ------------------------------------------------------------------

/** `a : b : c` places two wires; `(a, b) : c` places two as well.
 *
 * What is not a connection — `pedale * 3800 + 400` — is a computed signal: it
 * is placed as an instance without a name, and that one gets wired.
 */
function wire(text, expression, graph) {
  const pieces = gatherComputations(text, expression, graph)

  let left = null
  let cutting = false
  let width = null
  let loop = false

  for (const piece of pieces) {
    if (piece.name === 'Link') {
      const sign = piece.firstChild
      cutting = sign?.name === 'CutSeries' || sign?.name === 'CutFeedback'
      loop = sign?.name === 'Feedback' || sign?.name === 'WideFeedback'
      width = sign?.name === 'WideSeries'
        ? Number(contenu(text, sign).slice(1)) : null
      continue
    }
    const right = pointsOf(text, piece)
    if (left) {
      for (const from of left) {
        for (const to of right) {
          const r = cutting ? graph.cut(from, to)
                          : graph.connect(from, to, width, loop)
          if (!r.done) return r
        }
      }
    }
    left = right
  }
  return left ? Outcome.ok() : Outcome.refused('empty expression')
}

/** Gathers into a single term what is joined by computation rather than by a
 *  connection. The result is an instance without a name, placed in the graph. */
function gatherComputations(text, expression, graph) {
  const bruts = []
  for (let e = expression.firstChild; e; e = e.nextSibling) bruts.push(e)

  const out = []
  let computation = null

  for (let i = 0; i < bruts.length; i++) {
    const piece = bruts[i]
    const suivant = bruts[i + 1]
    const estCalcul = m => m?.name === 'Link' && m.firstChild?.name === 'Operator'

    if (estCalcul(piece)) { computation.push(piece); continue }
    if (computation) { computation.push(piece); }
    else if (estCalcul(suivant)) { computation = [piece]; continue }
    else { out.push(piece); continue }

    if (!estCalcul(bruts[i + 1])) {
      out.push(placeComputation(text, computation, graph))
      computation = null
    }
  }
  if (computation) out.push(placeComputation(text, computation, graph))
  return out
}

/** Places a computed signal under a name nobody will ever write. */
let computationCount = 0
function placeComputation(text, pieces, graph) {
  const body = pieces.map(m => contenu(text, m)).join(' ')
  const name = `computation${++computationCount}`
  graph.place(name, body)
  return { computed: name }
}

/** The points of a term: one name, or several if it is a group. */
function pointsOf(text, terme) {
  if (terme.computed) return [{ name: terme.computed }]
  const groupe = firstOf(terme, 'Group')
  if (groupe) {
    const inside = groupe.getChild('Expression')
    const points = []
    for (let e = inside?.firstChild; e; e = e.nextSibling) {
      if (e.name !== 'Link') points.push(...pointsOf(text, e))
    }
    return points
  }
  const chemin = firstOf(terme, 'Path')
  if (!chemin) return [{ name: contenu(text, terme) }]
  const membres = contenu(text, chemin).split('.')
  return [{ name: membres[0], member: membres[1] ?? null }]
}

// --- reading the tree --------------------------------------------------------

function nameOf(text, form) {
  return contenu(text, form.getChild('Name') ?? form.getChild('Path'))
}

function contenu(text, node) {
  return node ? text.slice(node.from, node.to).trim() : null
}

function childrenOf(node, type) {
  const out = []
  for (let e = node.firstChild; e; e = e.nextSibling) if (e.name === type) out.push(e)
  return out
}

/** The first node of this type, going down. The forms the grammar nests —
 *  FreeBody > Expression > Term > Call — are traversed this way. */
function firstOf(node, type) {
  if (!node) return null
  if (node.name === type) return node
  for (let e = node.firstChild; e; e = e.nextSibling) {
    const trouve = firstOf(e, type)
    if (trouve) return trouve
  }
  return null
}

function lineNumber(text, position) {
  return text.slice(0, position).split('\n').length
}
