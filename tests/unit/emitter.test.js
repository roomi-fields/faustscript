// The emitter is only right if Faust accepts what it writes. These tests
// actually compile the result: that is the only judge.
import { test } from 'vitest'
import assert from 'node:assert'
import { readFileSync } from 'node:fs'
import { readCatalogue } from '../../src/catalogue.js'
import { readTemplates } from '../../src/templates.js'
import { Graph } from '../../src/graph.js'
import { writeInstance } from '../../src/emitter.js'
import { compile } from './faust.js'

const lire = f => readFileSync(new URL(f, import.meta.url), 'utf8')
const catalogue = readCatalogue(lire('../../lib/faust.fx'))
const templates = readTemplates(lire('../../lib/translation.fx'))

function emettre(poses, expression) {
  const g = new Graph(catalogue)
  g.sink = templates.reserved('sink')
  for (const [name, module, multiplicity, settings] of poses) {
    g.place(name, module, multiplicity, new Map(settings))
  }
  const lines = [templates.value('template.Header')]
  for (const e of g.instances.values()) {
    lines.push(writeInstance(e, catalogue, templates))
  }
  lines.push(templates.fill('template.Sink', { expression }))
  return lines.join('\n')
}

test('a generator and an adjustable filter', async () => {
  const faust = emettre(
    [
      ['osc1', 'os.sawtooth', 1, [['freq', '110']]],
      ['lpf1', 'fi.lowpass', 1, [['fc', '800']]],
    ],
    'osc1 : lpf1'
  )
  assert.equal(await compile(faust), null, faust)
})

test('a structural parameter stays constant', async () => {
  // a filter's order cannot be a slider: Faust loops forever
  const faust = emettre([['lpf1', 'fi.lowpass', 1, [['fc', '800']]]], '_ : lpf1')
  assert.ok(!faust.includes('nentry("N"'), 'N must not become a port')
  assert.equal(await compile(faust), null, faust)
})

test('a bank of eight', async () => {
  const faust = emettre([['lpfs', 'fi.lowpass', 8, [['fc', '1200']]]], 'lpfs')
  assert.equal(await compile(faust), null, faust)
})

test('a reverb and its bounded settings', async () => {
  const faust = emettre(
    [
      [
        'rev1',
        're.mono_freeverb',
        1,
        [
          ['fb1', '0.92'],
          ['damp', '0.45'],
        ],
      ],
    ],
    '_ : rev1'
  )
  assert.ok(faust.includes('hslider'), 'a bounded setting gives a slider')
  assert.equal(await compile(faust), null, faust)
})

test('two free expressions carrying the same setting do not collide', async () => {
  // whoever hosts FaustX reaches a setting at `/<program>/<instance>/<port>`;
  // an instance written as a free expression must therefore be grouped too,
  // or Faust answers `path '/…/gain' is already used`
  const faust = emettre(
    [
      ['vol1', '*(gain:0.35)', 1, []],
      ['vol2', '*(gain:0.5)', 1, []],
    ],
    'vol1 : vol2'
  )
  assert.ok(faust.includes('vgroup("vol1"'), 'the instance names its own setting')
  assert.equal(await compile(faust), null, faust)
})
