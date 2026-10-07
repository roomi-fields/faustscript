#!/usr/bin/env node
// The reference outputs of FaustScript, against what it writes now (tests/unit/references.js).
//
//   npm run references               lists each reference that differs from what FaustScript writes
//   npm run references -- --update   engraves what FaustScript writes as the references, and removes
//                                    the reference of an entry that no longer exists
//
// --update goes only in a commit that names the gap: a regression is fixed before the commit, a
// change is engraved and named. Exit code 0: identical, or engraved; 1: a gap.

import { mkdirSync, rmSync, writeFileSync } from 'node:fs'
import { ENTRIES, REFERENCES, engrave, engraved, orphans } from '../tests/unit/references.js'

const stale = orphans()

if (process.argv.includes('--update')) {
  for (const f of stale) {
    rmSync(new URL(f, REFERENCES))
  }
  for (const entry of ENTRIES) {
    const file = new URL(entry.reference, REFERENCES)
    mkdirSync(new URL('.', file), { recursive: true })
    writeFileSync(file, engrave(entry))
  }
  console.log(`${ENTRIES.length} references engraved, ${stale.length} removed.`)
  process.exit(0)
}

const gaps = [
  ...ENTRIES.filter(e => engrave(e) !== engraved(e)).map(e => `differs: ${e.reference}`),
  ...stale.map(f => `no entry: ${f}`),
]
console.log(`${ENTRIES.length} entries, ${gaps.length} gaps.`)
for (const gap of gaps) {
  console.log(`  ${gap}`)
}
process.exit(gaps.length === 0 ? 0 : 1)
