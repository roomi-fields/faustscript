/**
 * The examples of docs/LANGUAGE.md, run. Each `faustx` block is applied to a new transpiler: each
 * example it applies gives results that are all applied; each example marked `// refused: CODE`
 * gives results that are all refused with that code; no line outside an example is applied;
 * and the Faust that write() returns for the block compiles with faustwasm.
 *
 * A check the transpiler does not hold yet is listed in KNOWN_DEFECTS with the ticket of the defect
 * that fixes it and what the check observes today. The test asserts that observation exactly, so
 * that any other failure stays red, and turns red once the defect is fixed, so that the entry leaves
 * the list. A block that is not a whole program is listed in NOT_PROGRAMS with its reason, and is
 * not compiled.
 */

import { describe, expect, it } from 'vitest'
import { readFileSync } from 'node:fs'
import { createTranspiler } from '../../src/transpiler.js'
import { compile } from './faust.js'
import { LANGUAGE, read } from './language-examples.js'

const applied = { done: true, code: null, reason: null }
const refused = (code, reason) => ({ done: false, code, reason })

/** The checks the transpiler does not hold yet: the ticket of the defect, and what is seen today. */
const KNOWN_DEFECTS = new Map([
  [
    'refuses with ALREADY_PLACED: let lpf1 fi.lowpass',
    { ticket: 'faustx-zj5.9', now: [refused(null, 'lpf1 is already placed')] },
  ],
  [
    'refuses with UNKNOWN_NAME: let lpf1 lowpass',
    { ticket: 'faustx-zj5.9', now: [refused(null, 'lowpass is not a module; fi.lowpass is')] },
  ],
  [
    'refuses with SETTING_FROM_INPUT: micro : lpf1.fc',
    {
      ticket: 'faustx-zj5.9',
      now: [
        refused(
          null,
          "micro carries one of the program's inputs: a setting can only be driven by a signal"
        ),
      ],
    },
  ],
  [
    'applies: lpfs:16 fi.lowpass',
    { ticket: 'faustx-zj5.22', now: [refused(null, 'a setting targets a port'), applied] },
  ],
  [
    'applies: fi.lowpass(N:4, fc:2000)  fi.lowpass(N, fc)',
    {
      ticket: 'faustx-zj5.21',
      now: [
        refused(null, 'fi.lowpass is not a placed instance'),
        ...Array(4).fill(refused(null, 'fc does not exist')),
      ],
    },
  ],
  [
    'applies: voix(freq:110, fc:800)  os.sawtooth(freq:freq) : fi.lowpass(fc:fc)',
    { ticket: 'faustx-zj5.21', now: [refused(null, 'voix is not a placed instance'), applied] },
  ],
  [
    'applies: import("mes-modules.fx")',
    { ticket: 'faustx-zj5.21', now: [refused(null, 'unknown form: Import')] },
  ],
  [
    'compiles: the block that opens with let basse os.sawtooth(freq:55)',
    { ticket: 'faustx-zj5.15', now: 'ERROR : sequential composition nappe:vcab' },
  ],
  [
    'applies: lfo1 : it.remap(-1, 1, 140, 900) : lpf1.fc',
    { ticket: 'faustx-zj5.17', now: [refused(null, 'it does not exist')] },
  ],
  [
    'applies: _ : lpf1 : process',
    { ticket: 'faustx-zj5.17', now: [refused(null, '_ does not exist')] },
  ],
])

/** The blocks that are not a whole program, by their first example, with the reason. */
const NOT_PROGRAMS = new Map([
  ['import("mes-modules.fx")', 'it imports a file the document does not give'],
])

const libraryFile = f => readFileSync(new URL(f, import.meta.url), 'utf8')
const CATALOGUE = libraryFile('../../lib/faust.fx')
const TEMPLATES = libraryFile('../../lib/translation.fx')

const runs = new Map()

/** The block applied once to a new transpiler, which its checks share: the transpiler, its results. */
function run(block) {
  if (!runs.has(block)) {
    const transpiler = createTranspiler(CATALOGUE, TEMPLATES)
    runs.set(block, { transpiler, results: transpiler.apply(block.text) })
  }
  return runs.get(block)
}

/** What the results from `first` to `last` say: applied, or refused with a code and a sentence. */
function outcomes(block, first, last) {
  return run(block)
    .results.filter(r => r.line >= first && r.line <= last)
    .map(r => ({
      done: r.outcome.done,
      code: r.outcome.code ?? null,
      reason: r.outcome.reason ?? null,
    }))
}

/**
 * Every check the examples make: its title, what it observes, and whether that observation holds.
 * An example of n lines gives n results, as apply gives one result per line.
 */
function checks(blocks) {
  const out = []
  for (const block of blocks) {
    const opening = block.examples[0].text
    for (const example of block.examples) {
      const span = example.last - example.first + 1
      const all = (seen, wanted) =>
        seen.length === span && seen.every(o => o.done === wanted.done && o.code === wanted.code)
      const observe = () => outcomes(block, example.first, example.last)
      if (example.refused === null) {
        out.push({
          block,
          title: `applies: ${example.text}`,
          observe,
          holds: seen => all(seen, applied),
        })
      } else {
        const wanted = { done: false, code: example.refused }
        out.push({
          block,
          title: `refuses with ${example.refused}: ${example.text}`,
          observe,
          holds: seen => all(seen, wanted),
        })
      }
    }
    out.push({
      block,
      title: `applies nothing outside its examples: the block that opens with ${opening}`,
      observe: () =>
        run(block).results.filter(
          r => !block.examples.some(e => r.line >= e.first && r.line <= e.last)
        ),
      holds: seen => seen.every(r => !r.outcome.done),
    })
    if (!NOT_PROGRAMS.has(opening)) {
      out.push({
        block,
        title: `compiles: the block that opens with ${opening}`,
        // the first line of a refusal names the fault; the lines after it print the circuit
        observe: async () => (await compile(run(block).transpiler.write()))?.split('\n')[0] ?? null,
        holds: seen => seen === null,
      })
    }
  }
  return out
}

const { blocks: BLOCKS, problems: PROBLEMS } = read(LANGUAGE)
const CHECKS = checks(BLOCKS)

describe('the reading of a document', () => {
  const fence = '```'
  const doc = lines => [...lines].join('\n')

  it('cuts a comment only outside a string, and joins indented lines to their example', () => {
    const { blocks, problems } = read(
      doc([
        `${fence}faustx`,
        'import("http://a.fx")   // refused: UNKNOWN_FORM',
        '',
        '// a comment',
        'm(a:1)  _',
        '  a.min:0',
        '  a.max:2',
        fence,
      ])
    )
    expect(problems).toEqual([])
    expect(blocks[0].examples).toEqual([
      { text: 'import("http://a.fx")', first: 1, last: 1, refused: 'UNKNOWN_FORM' },
      { text: 'm(a:1)  _', first: 4, last: 6, refused: null },
    ])
  })

  it('reports every writing it cannot read as an example', () => {
    const { blocks, problems } = read(
      doc([
        `${fence}faustx`,
        '  a.min:0',
        'let a b   // refused: unknown',
        'let c d',
        '  e.f:1   // refused: UNKNOWN_PORT',
        fence,
        ` ${fence}faustx`,
        fence,
        `${fence}faustx`,
        '// only a comment',
        fence,
        `${fence}faustx`,
      ])
    )
    expect(blocks.map(b => b.at)).toEqual([1])
    expect(problems.map(p => p.at)).toEqual([2, 3, 5, 7, 9, 12])
  })
})

describe('the examples of docs/LANGUAGE.md', () => {
  it('reads every faustx block, and holds examples the transpiler refuses', () => {
    expect(PROBLEMS).toEqual([])
    expect(BLOCKS.length).toBeGreaterThan(0)
    expect(BLOCKS.flatMap(b => b.examples).filter(e => e.refused !== null).length).toBeGreaterThan(
      0
    )
  })

  it('lists only defects that name one check failing today, and only blocks that exist', () => {
    const named = key => CHECKS.filter(c => c.title === key)
    const opens = first => BLOCKS.filter(b => b.examples[0].text === first).length
    expect([...KNOWN_DEFECTS.keys()].filter(key => named(key).length !== 1)).toEqual([])
    expect([...KNOWN_DEFECTS].filter(([key, { now }]) => named(key)[0]?.holds(now))).toEqual([])
    expect([...NOT_PROGRAMS.keys()].filter(first => opens(first) !== 1)).toEqual([])
  })

  for (const block of BLOCKS) {
    describe(`the block at line ${block.at}`, () => {
      for (const check of CHECKS.filter(c => c.block === block)) {
        const defect = KNOWN_DEFECTS.get(check.title)
        if (defect === undefined) {
          it(check.title, async () => {
            const seen = await check.observe()
            expect(check.holds(seen), JSON.stringify(seen)).toBe(true)
          })
        } else {
          it(`${check.title} (known defect, ${defect.ticket})`, async () => {
            expect(
              await check.observe(),
              `if ${defect.ticket} is fixed, the entry leaves KNOWN_DEFECTS`
            ).toEqual(defect.now)
          })
        }
      }
    })
  }
})
