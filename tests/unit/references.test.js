/**
 * The engraved reference outputs: what FaustX writes today for each entry, compared to the reference
 * under tests/references/. A gap is a regression, fixed before the commit, or a change, engraved by
 * `npm run references -- --update` in a commit that names it.
 */

import { describe, expect, it } from 'vitest'
import { ENTRIES, engrave, engraved, orphans } from './references.js'

describe('the engraved reference outputs', () => {
  it('engrave every piece of examples/ and every faustx block of docs/LANGUAGE.md', () => {
    const sources = new Set(ENTRIES.map(e => e.source))
    expect(sources).toEqual(new Set(['examples/', 'docs/LANGUAGE.md']))
    expect(ENTRIES.filter(e => e.source === 'examples/').length).toBeGreaterThan(0)
    expect(ENTRIES.filter(e => e.source === 'docs/LANGUAGE.md').length).toBeGreaterThan(0)
  })

  it('keep one reference per entry, and none for an entry that no longer exists', () => {
    expect(orphans()).toEqual([])
  })

  for (const entry of ENTRIES) {
    it(`${entry.reference} holds what FaustX writes today`, () => {
      expect(engrave(entry), 'npm run references -- --update engraves it').toBe(engraved(entry))
    })
  }
})
