// The two kinds of line (docs/LANGUAGE.md §1): a Faust statement runs up to its
// `;` and keeps its Faust meaning; any other line is a gesture, which ends at
// the newline and where `=` gives a value and `:` connects.
import { test } from 'vitest'
import assert from 'node:assert'
import { createTranspiler } from '../../src/transpiler.js'
import { compile } from './faust.js'
import { CATALOGUE, TEMPLATES } from './library.js'

function translate(source) {
  const t = createTranspiler(CATALOGUE, TEMPLATES)
  const results = t.apply(source)
  return { t, results, faust: t.write() }
}

const summary = g => [g.line, g.gesture, g.outcome.done]

test('a Faust definition runs up to its ; over several lines, and is written as it is', async () => {
  const { results, faust } = translate(
    [
      'gain = 0.5;',
      'voice(f) = os.sawtooth(f)',
      '  : fi.lowpass(2, 800);   // a comment inside',
      'let saw1 os.sawtooth',
      'saw1 : process',
    ].join('\n')
  )
  assert.deepEqual(results.map(summary), [
    [1, null, true],
    [2, null, true],
    [4, 'place', true],
    [5, 'wire', true],
  ])
  assert.match(faust, /^gain = 0\.5;$/m)
  assert.match(faust, /^voice\(f\) = os\.sawtooth\(f\)\n {2}: fi\.lowpass\(2, 800\);$/m)
  assert.equal(await compile(faust), null, faust)
})

test('let followed by = is a Faust definition, and no line throws', async () => {
  const lines = ['let = 1;', 'let', 'let lpf1', 'lpf1 =', '= 3', 'lpf1.fc =', '!', ':8', '(', ';']
  for (const line of lines) {
    const t = createTranspiler(CATALOGUE, TEMPLATES)
    assert.doesNotThrow(() => t.apply(line), line)
    assert.doesNotThrow(() => t.write(), line)
  }
  const { results, faust } = translate('let = 1;\nprocess = let;')
  assert.deepEqual(results.map(summary), [
    [1, null, true],
    [2, null, true],
  ])
  assert.match(faust, /^let = 1;$/m)
  assert.equal(await compile(faust), null, faust)
})

test('a line the grammar reads only in part is refused, and changes nothing', () => {
  const t = createTranspiler(CATALOGUE, TEMPLATES)
  const results = t.apply('let lpf2 fi.lowpass(fc=400\nlet lpf3 fi.lowpass')
  assert.deepEqual(
    results.map(g => [g.line, g.outcome.reason]),
    [
      [1, 'does not read: let lpf2 fi.lowpass(fc=400'],
      [2, null],
    ]
  )
  assert.deepEqual([...t.graph.instances.keys()], ['lpf3'])
})

test('a definition gives a module its parameters by name, as constants', async () => {
  const { faust } = translate(
    'voice2(f) = os.sawtooth(freq=f) : fi.lowpass(fc=800);\nlet v os.sawtooth\nv : process'
  )
  assert.match(faust, /^voice2\(f\) = os\.sawtooth\(f\) : fi\.lowpass\(4, 800\);$/m)
  assert.equal(await compile(faust), null, faust)
})

test('a Faust definition of process is one more source into it, which a new one replaces', async () => {
  const { t, faust } = translate(
    'let saw1 os.sawtooth\nsaw1 : process\nprocess = no.noise * 0.1;\nprocess = no.noise * 0.05;'
  )
  assert.match(
    faust,
    /^process = \(saw1, no\.noise \* 0\.05\) :> si\.bus\(outputs\(no\.noise \* 0\.05\)\);$/m
  )
  assert.doesNotMatch(faust, /0\.1/)
  assert.equal(await compile(faust), null, faust)

  t.apply('saw1 !: process')
  assert.match(t.write(), /^process = no\.noise \* 0\.05;$/m)
})

test('= gives a value: to a port, an attribute, a parameter, a negative number after it', () => {
  const { t, results } = translate(
    [
      'let gate1 ef.gate_mono(thresh=-40)',
      'let lpf1 fi.lowpass(fc=800)',
      'lpf1.fc = 400',
      'lpf1.fc.min = 20',
      'x = 10 -5;',
    ].join('\n')
  )
  assert.deepEqual(
    results.map(g => g.outcome.done),
    [true, true, true, true, true]
  )
  const lpf1 = t.graph.instance('lpf1')
  assert.deepEqual(Object.fromEntries(lpf1.settings), { fc: '400', 'fc.min': '20' })
  assert.equal(t.graph.instance('gate1').settings.get('thresh'), '-40')
  assert.match(t.write(), /^x = 10 -5;$/m)
})

test('on a wiring line, a number after the colon, stuck or spaced, counts copies', () => {
  for (const [line, width] of [
    ['saw1 :8 lpf1', 8],
    ['saw1 : 4 lpf1', 4],
  ]) {
    const { t, results } = translate(`let saw1 os.sawtooth\nlet lpf1 fi.lowpass\n${line}`)
    assert.equal(results[2].outcome.done, true, line)
    assert.deepEqual(
      t.graph.wires.map(w => w.width),
      [width],
      line
    )
  }
})

test('import and declare are Faust statements: one written beside the header, one once', () => {
  const { results, faust } = translate(
    'declare name "drone";\nimport("stdfaust.lib");\nimport( "stdfaust.lib" );'
  )
  assert.deepEqual(
    results.map(g => g.outcome.done),
    [true, true, true]
  )
  assert.match(faust, /^declare name "drone";$/m)
  assert.equal(faust.match(/import\( ?"stdfaust\.lib" ?\);/g).length, 2)
})

test('outside a wiring line, : and ~ keep their Faust meaning, and the wiring signs are refused', async () => {
  const { results, faust } = translate(
    [
      'half = os.osc(440) : 0.5 * _;',
      'let v1 os.osc(freq=440) : 2 * _',
      'v1 : process',
      'cut = os.osc(440) !: _;',
    ].join('\n')
  )
  assert.deepEqual(results.map(summary), [
    [1, null, true],
    [2, 'place', true],
    [3, 'wire', true],
    [4, null, false],
  ])
  assert.match(faust, /^half = os\.osc\(440\) : 0\.5 \* _;$/m)
  assert.match(faust, /^v1 = .* : 2 \* _\);$/m)
  assert.equal(await compile(faust), null, faust)
})

test("Faust's local scopes and its delay are read as Faust, inside one definition", async () => {
  const { results, faust } = translate(
    [
      "echo1 = _ <: _, _' :> *(gain) with {",
      '  gain = 0.5;',
      '};',
      'let e1 echo1',
      'e1 : process',
    ].join('\n')
  )
  assert.deepEqual(results.map(summary), [
    [1, null, true],
    [4, 'place', true],
    [5, 'wire', true],
  ])
  assert.equal(await compile(faust), null, faust)
})
