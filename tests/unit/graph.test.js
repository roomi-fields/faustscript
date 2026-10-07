// Le graph refused ce qui n'a pas de sens, et ne bouge pas quand il refused :
// c'est ce qui garantit qu'une line fautive n'interrompt pas le son.
import { test } from 'vitest'
import assert from 'node:assert'
import { readFileSync } from 'node:fs'
import { readCatalogue } from '../../src/catalogue.js'
import { Graph } from '../../src/graph.js'

const catalogue = readCatalogue(
  readFileSync(new URL('../../lib/faust.fx', import.meta.url), 'utf8')
)

const neuf = () => {
  const g = new Graph(catalogue)
  g.sink = 'process'
  return g
}

test('the catalogue carries the 998 Faust modules', () => {
  assert.equal(catalogue.size, 998)
  assert.equal(catalogue.get('lowpass').parameters.length, 2)
  assert.equal(catalogue.get('resonlp').attribute('fc', 'unit'), 'Hz')
})

test("un name ne se pose qu'une fois", () => {
  const g = neuf()
  assert.ok(g.place('saw1', 'sawtooth').done)
  assert.ok(!g.place('saw1', 'sawtooth').done)
})

test('connect exige que les deux bouts existent', () => {
  const g = neuf()
  g.place('lpf1', 'lowpass')
  assert.ok(!g.connect({ name: 'zorg' }, { name: 'lpf1' }).done)
  assert.equal(g.wires.length, 0, 'a refusal leaves no trace')
})

test('releasing a name takes its wires with it', () => {
  const g = neuf()
  g.place('saw1', 'sawtooth')
  g.place('lpf1', 'lowpass')
  g.connect({ name: 'saw1' }, { name: 'lpf1' })
  g.release('lpf1')
  assert.equal(g.wires.length, 0)
  assert.ok(!g.set('lpf1', 'cutoff', '400').done)
})

test('bypass, then put back', () => {
  const g = neuf()
  g.place('lpf1', 'lowpass')
  g.bypass('lpf1')
  assert.ok(g.instance('lpf1').bypassed)
  g.bypass('lpf1', false)
  assert.ok(!g.instance('lpf1').bypassed)
})
