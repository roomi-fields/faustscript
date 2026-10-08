/**
 * The English translations of the reference documents: each tracked `<name>.en.md` stands next to its
 * French `<name>.md`, which decides, and carries the same numbered sections and the same rule numbers
 * (`R1`…), in the same order, and the same fenced blocks in the same order: a diagram (a `mermaid`
 * block) is text in the document's language, and every other block is identical byte for byte.
 */

import { execFileSync } from 'node:child_process'
import { existsSync, readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import { fences } from './language-examples.js'

const ROOT = new URL('../../', import.meta.url)

const REFERENCE_DOCUMENTS = [
  'CONTEXT.md',
  'docs/PRINCIPES.md',
  'docs/LANGUAGE.md',
  'docs/ARCHITECTURE.md',
  'packages/040-faustscript/docs/CADRE.md',
  'packages/040-faustscript/docs/INTERFACE.md',
]

const TRANSLATIONS = execFileSync('git', ['ls-files', '*.en.md'], { cwd: ROOT, encoding: 'utf8' })
  .split('\n')
  .filter(f => f !== '')

/** The fenced blocks of `doc`, each as its fence line and body, and whether it is a diagram. */
const blocksOf = doc =>
  fences(doc).map(f => ({ text: [f.fence, ...f.body].join('\n'), diagram: f.info === 'mermaid' }))

/** The lines of `doc` outside its fenced blocks, in order. */
function proseOf(doc) {
  const fenced = new Set(
    fences(doc).flatMap(f => [...Array(f.body.length + 2).keys()].map(k => f.at + k))
  )
  return doc.split('\n').filter((_, k) => !fenced.has(k + 1))
}

/** The numbers of the numbered headings of `doc`, in order: `3.4` for `### 3.4 …`. */
const sectionsOf = doc =>
  proseOf(doc)
    .map(line => /^#{1,6}\s+(\d+(?:\.\d+)*)\.?\s/.exec(line)?.[1])
    .filter(n => n !== undefined)

/** The numbers of the rules of `doc`, in order: `R10` for `- **R10.** …`. */
const rulesOf = doc =>
  proseOf(doc)
    .flatMap(line => line.match(/\*\*R\d+\.\*\*/g) ?? [])
    .map(r => r.slice(2, -3))

/** The differences between a French document and its translation, one sentence each. */
function gaps(french, english) {
  const out = []
  const [fs, es] = [sectionsOf(french), sectionsOf(english)]
  if (fs.join(' ') !== es.join(' ')) {
    out.push(`sections differ: ${fs.join(' ')} | ${es.join(' ')}`)
  }
  const [fr, er] = [rulesOf(french), rulesOf(english)]
  if (fr.join(' ') !== er.join(' ')) {
    out.push(`rules differ: ${fr.join(' ')} | ${er.join(' ')}`)
  }
  const [fb, eb] = [blocksOf(french), blocksOf(english)]
  if (fb.length !== eb.length) {
    out.push(`${fb.length} fenced blocks in French, ${eb.length} in English`)
  }
  fb.forEach((block, k) => {
    const other = eb[k]
    if (other === undefined) {
      return
    }
    if (block.diagram !== other.diagram) {
      out.push(`fenced block ${k + 1} is a diagram in one language only`)
    } else if (!block.diagram && other.text !== block.text) {
      out.push(`fenced block ${k + 1} differs`)
    }
  })
  return out
}

const read = path => readFileSync(new URL(path, ROOT), 'utf8')

describe('the English translations of the reference documents', () => {
  it('cover every reference document', () => {
    for (const doc of REFERENCE_DOCUMENTS) {
      expect(TRANSLATIONS).toContain(doc.replace(/\.md$/, '.en.md'))
    }
  })

  it.each(TRANSLATIONS)('%s agrees with its French text', translation => {
    const french = translation.replace(/\.en\.md$/, '.md')
    expect(existsSync(new URL(french, ROOT)), `${french} is missing`).toBe(true)
    const [fr, en] = [read(french), read(translation)]
    expect(sectionsOf(fr).length + blocksOf(fr).length).toBeGreaterThan(0)
    expect(gaps(fr, en)).toEqual([])
  })

  it('name a moved section, a changed block and a misplaced diagram', () => {
    const french = '# T\n\n## 1. A\n\n```ts\nx\n```\n\n## 2. B\n'
    expect(gaps(french, french)).toEqual([])
    expect(gaps(french, '# T\n\n## 2. B\n\n```ts\nx\n```\n\n## 1. A\n')).toEqual([
      'sections differ: 1 2 | 2 1',
    ])
    expect(gaps(french, '# T\n\n## 1. A\n\n```ts\ny\n```\n\n## 2. B\n')).toEqual([
      'fenced block 1 differs',
    ])
    expect(gaps(french, french + '\n## 3. C\n')).toEqual(['sections differ: 1 2 | 1 2 3'])
    expect(gaps('- **R1.** a\n- **R2.** b\n', '- **R1.** a\n- **R3.** b\n')).toEqual([
      'rules differ: R1 R2 | R1 R3',
    ])
    expect(gaps(french, '# T\n\n## 1. A\n\n## 2. B\n')).toEqual([
      '1 fenced blocks in French, 0 in English',
    ])
    const diagram = label => '```mermaid\nflowchart LR\n  a[' + label + ']\n```\n'
    expect(gaps(diagram('analyseur') + french, diagram('parser') + french)).toEqual([])
    expect(gaps(diagram('analyseur') + french, french + diagram('parser'))).toEqual([
      'fenced block 1 is a diagram in one language only',
      'fenced block 2 is a diagram in one language only',
    ])
    expect(gaps(diagram('analyseur') + french, french)).toEqual([
      '2 fenced blocks in French, 1 in English',
      'fenced block 1 is a diagram in one language only',
    ])
  })
})
