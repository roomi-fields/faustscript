/**
 * The reference outputs of FaustX: for each entry, the text a new transpiler applies, what apply
 * returns for each line, and the Faust that write() returns once the whole text is applied. The
 * entries are each piece of examples/ and each `faustx` block of docs/LANGUAGE.md; the reference of
 * an entry lives under tests/references/, at a path that mirrors its source.
 *
 * A reference says what FaustX does, defects included: a known defect stays engraved as it is, and
 * the commit that fixes it engraves the new output.
 */

import { existsSync, readdirSync, readFileSync } from 'node:fs'
import { createTranspiler } from '../../src/transpiler.js'
import { LANGUAGE, read } from './language-examples.js'

const ROOT = new URL('../../', import.meta.url)
export const REFERENCES = new URL('../references/', import.meta.url)

const text = path => readFileSync(new URL(path, ROOT), 'utf8')
const CATALOGUE = text('lib/faust.fx')
const TEMPLATES = text('lib/translation.fx')

const pieces = readdirSync(new URL('examples/', ROOT))
  .filter(f => f.endsWith('.fx'))
  .sort()
  .map(f => ({
    source: 'examples/',
    reference: `examples/${f}.txt`,
    title: `examples/${f}`,
    text: text(`examples/${f}`),
  }))

const blocks = read(LANGUAGE).blocks.map((block, k) => {
  const rank = String(k + 1).padStart(2, '0')
  return {
    source: 'docs/LANGUAGE.md',
    reference: `docs/LANGUAGE.md/block-${rank}.txt`,
    title: `the faustx block ${k + 1} of docs/LANGUAGE.md, which opens with ${block.examples[0].text}`,
    text: block.text,
  }
})

/**
 * Every entry: its source, the path of its reference under tests/references/, the title its
 * reference opens with, and the FaustX text it applies.
 */
export const ENTRIES = [...pieces, ...blocks]

/** A value of a line's result as one line of text: a string as it is, anything else in JSON. */
const value = v => (typeof v === 'string' ? v : JSON.stringify(v))

/**
 * The reference of `entry`, as FaustX writes it now: its title, then for each result of apply its
 * line number and text followed by each other field of the result in the order apply gives them,
 * then the Faust of write(). A string that holds a newline continues on lines indented under it.
 */
export function engrave(entry) {
  const transpiler = createTranspiler(CATALOGUE, TEMPLATES)
  const out = [
    `FaustX reference output of ${entry.title}.`,
    'Engraved by `npm run references -- --update`, in a commit that names the gap.',
    '',
    '--- apply',
  ]
  for (const result of transpiler.apply(entry.text)) {
    out.push('', `${result.line}  ${result.text}`)
    for (const [key, v] of Object.entries(result)) {
      if (key !== 'line' && key !== 'text') {
        out.push(`    ${key}: ${value(v).replaceAll('\n', '\n      ')}`)
      }
    }
  }
  out.push('', '--- write', '', transpiler.write())
  return `${out.join('\n').trimEnd()}\n`
}

/** The reference engraved for `entry`, or null when none is. */
export function engraved(entry) {
  const file = new URL(entry.reference, REFERENCES)
  return existsSync(file) ? readFileSync(file, 'utf8') : null
}

/** The path of every reference engraved under tests/references/ that no entry has. */
export function orphans() {
  const wanted = new Set(ENTRIES.map(e => e.reference))
  return onDisk().filter(f => !wanted.has(f))
}

/** The path of every reference engraved under tests/references/, relative to that folder. */
function onDisk() {
  if (!existsSync(REFERENCES)) {
    return []
  }
  return readdirSync(REFERENCES, { recursive: true, encoding: 'utf8' })
    .filter(f => f.endsWith('.txt'))
    .sort()
}
