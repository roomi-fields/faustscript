// The examples are the grammar's test bench: if they do not parse, it is
// wrong.
import { test } from 'vitest'
import assert from 'node:assert'
import { readFileSync, readdirSync } from 'node:fs'
import { parser } from '../../src/parser.js'

const dossier = new URL('../../examples/', import.meta.url)

for (const name of readdirSync(dossier).filter(f => f.endsWith('.fx'))) {
  test(`${name} parses without error`, () => {
    const text = readFileSync(new URL(name, dossier), 'utf8')
    const erreurs = []
    parser.parse(text).iterate({
      enter: n => {
        if (n.type.isError) {
          erreurs.push(lineNumber(text, n.from))
        }
      },
    })
    assert.deepEqual(erreurs, [], `errors at lines ${erreurs.join(', ')}`)
  })
}

function lineNumber(text, position) {
  return text.slice(0, position).split('\n').length
}

test('the catalogue parses in full', () => {
  // it is written in FaustX: our own parser must read it without a single fault
  const text = readFileSync(new URL('../../lib/faust.fx', import.meta.url), 'utf8')
  const erreurs = []
  parser.parse(text).iterate({
    enter: n => {
      if (n.type.isError) {
        erreurs.push(lineNumber(text, n.from))
      }
    },
  })
  assert.deepEqual(
    [...new Set(erreurs)],
    [],
    'the catalogue carries forms the grammar does not recognise'
  )
})
