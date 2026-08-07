// The guard: no sign of the language may be written in the code.
//
// Les signs vivent dans la grammaire et dans les templates. Une occurrence ici
// means a decision of the language has leaked into the engine — an
// architectural defect, not a matter of style.
import { test } from 'node:test'
import assert from 'node:assert'
import { readFileSync, readdirSync } from 'node:fs'

const dossier = new URL('../src/', import.meta.url)

// generated from the grammar: it IS the language, it does not copy it
const ENGENDRES = ['parser.js', 'parser.terms.js']

/** The signs only the language knows, as they would be written in code. */
const SIGNES = [
  /"let"|'let'/,           // the declaration word
  /"process"|'process'/,   // the sink's name
  /"!:"|'!:'|"!~"|'!~'/,   // the cuts
  /":8"|':8'/,             // a width written in place
  /"_"(?!\s*\+)|'_'/,      // the identity
]

for (const name of readdirSync(dossier).filter(f => f.endsWith('.js'))) {
  if (ENGENDRES.includes(name)) continue

  test(`${name} writes no sign of the language`, () => {
    const code = readFileSync(new URL(name, dossier), 'utf8')
      .split('\n')
      .filter(l => !l.trim().startsWith('//') && !l.trim().startsWith('*'))
      .join('\n')

    const fautes = SIGNES.filter(sign => sign.test(code)).map(String)
    assert.deepEqual(fautes, [],
      `${name} carries a sign of the language: it should come from the templates`)
  })
}
