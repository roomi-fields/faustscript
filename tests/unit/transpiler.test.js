// End to end: a FaustX text must become Faust that the compiler accepts.
// This is the only test that proves the whole chain holds.
import { test } from 'vitest'
import assert from 'node:assert'
import { readFileSync, writeFileSync, mkdtempSync } from 'node:fs'
import { execFileSync } from 'node:child_process'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import { createTranspiler } from '../../src/transpiler.js'

const lire = f => readFileSync(new URL(f, import.meta.url), 'utf8')
const dossier = mkdtempSync(join(tmpdir(), 'faustx-'))

function traduire(source) {
  const t = createTranspiler(lire('../../lib/faust.fx'), lire('../../lib/translation.fx'))
  const gestes = t.apply(source)
  return { faust: t.write(), refus: gestes.filter(g => !g.outcome.done), gestes }
}

function compile(faust) {
  const fichier = join(dossier, 'essai.dsp')
  writeFileSync(fichier, faust)
  try {
    execFileSync('faust', ['-lang', 'c', fichier, '-o', '/dev/null'], { stdio: 'pipe' })
    return null
  } catch (erreur) { return String(erreur.stderr).split('\n')[0] }
}

test('a minimal synth translates and compiles', () => {
  const { faust, refus } = traduire(`
let osc1 sawtooth(freq:110)
let lpf1 lowpass(fc:800)
osc1 : lpf1 : process
`)
  assert.deepEqual(refus, [])
  assert.equal(compile(faust), null, faust)
})

test('several sources into one input sum', () => {
  const { faust } = traduire(`
let osc1 sawtooth(freq:110)
let osc2 sawtooth(freq:220)
let lpf1 lowpass(fc:800)
(osc1, osc2) : lpf1 : process
`)
  assert.match(faust, /:>/, 'three into one input requires a merge')
  assert.equal(compile(faust), null, faust)
})

test('a bank of eight se traduit', () => {
  const { faust } = traduire(`
let lpfs:8 lowpass(fc:1200)
lpfs : process
`)
  assert.match(faust, /par\(i,8,/)
  assert.equal(compile(faust), null, faust)
})

test('the first complete piece compiles', () => {
  const { faust, refus } = traduire(lire('../../examples/1-drone-that-plays-alone.fx'))
  assert.deepEqual(refus.map(r => r.text), [])
  assert.equal(compile(faust), null, faust)
})

test('a faulty line is refused without touching the graph', () => {
  const t = createTranspiler(lire('../../lib/faust.fx'), lire('../../lib/translation.fx'))
  t.apply('let osc1 sawtooth(freq:110)\nosc1 : process\n')
  const avant = t.write()
  const refus = t.apply('zorg : process\nlet osc1 sawtooth(freq:55)\n')
    .filter(g => !g.outcome.done)
  assert.equal(refus.length, 2, 'both lines are refused')
  assert.equal(t.write(), avant, 'the graph has not moved')
})

test('all three pieces translate with nothing refused', () => {
  for (const name of ['1-drone-that-plays-alone', '2-processed-guitar',
                     '3-twenty-minute-session']) {
    const { refus } = traduire(lire(`../../examples/${name}.fx`))
    assert.deepEqual(refus.map(r => r.text.trim()), [], name)
  }
})

test('the pieces compile', () => {
  for (const name of ['1-drone-that-plays-alone', '2-processed-guitar',
                     '3-twenty-minute-session']) {
    const { faust } = traduire(lire(`../../examples/${name}.fx`))
    assert.equal(compile(faust), null, `${name} :\n${faust}`)
  }
})

test('a shared signal is written only once', () => {
  const { faust } = traduire(`
let saw1 sawtooth(freq:110)
let lpf1 lowpass(fc:800)
let rev1 mono_freeverb(damp:0.5)
saw1 : lpf1
saw1 : rev1
lpf1 : process
rev1 : process
`)
  const count = faust.split('\n').at(-2).split('saw1').length - 1
  assert.equal(count, 1, 'saw1 doit apparaître une seule fois dans process')
  assert.equal(compile(faust), null, faust)
})

test('every live gesture translates', () => {
  const debut = `
let saw1 sawtooth(freq:110)
let lpf1 lowpass(fc:800)
saw1 : lpf1 : process
`
  for (const [quoi, geste] of Object.entries({
    bypass: '_ lpf1',
    remettre:   '_ lpf1\n!_ lpf1',
    remove:    '! lpf1',
    replace:  'lpf1 highpass(fc:2000)',
    release:     '!let lpf1\nsaw1 : process',
    set:     'lpf1.fc:400',
  })) {
    const { faust, refus } = traduire(debut + geste + '\n')
    assert.deepEqual(refus.map(r => r.text), [], quoi)
    assert.equal(compile(faust), null, `${quoi} :\n${faust}`)
  }
})

test('a feedback loop uses the Faust feedback sign', () => {
  const { faust } = traduire(`
let saw1 sawtooth(freq:110)
let dly1 fdelay(maxdel:65536, del:4800)
let fb1 *(retour:0.6)
saw1 : dly1
dly1 ~ fb1
dly1 : process
`)
  assert.match(faust, /~/, 'feedback must use the Faust sign')
  assert.equal(compile(faust), null, faust)
})

test('an emptied graph stays a valid, silent program', () => {
  const { faust } = traduire(`
let saw1 sawtooth(freq:110)
saw1 : process
! saw1
`)
  assert.equal(compile(faust), null, faust)
})

test('a signal connected to a setting drives it, at its scale', () => {
  const { faust } = traduire(`
let lfo1 osc(freq:0.5)
let lpf1 lowpass(fc:800)
let saw1 sawtooth(freq:110)
lfo1 : lpf1.fc
saw1 : lpf1 : process
`)
  assert.match(faust, /lfo1 : it\.remap/,
    'the LFO must be rescaled to the port bounds')
  assert.doesNotMatch(faust.split('\n').find(l => l.startsWith('lpf1')), /hslider/,
    'a driven port carries no slider')
  assert.equal(compile(faust), null, faust)
})

test('a setting cannot be driven by a program input', () => {
  // Faust refuses a parameter that consumes an input: the gesture is refused
  // before producing a program the compiler would reject.
  const { refus, faust } = traduire(`
let pedale _
let lpf1 lowpass(fc:800)
let saw1 sawtooth(freq:110)
pedale * 3800 + 400 : lpf1.fc
saw1 : lpf1 : process
`)
  assert.equal(refus.length, 1)
  assert.match(refus[0].outcome.reason, /one of the program's inputs/)
  assert.equal(compile(faust), null, 'the program stays valid despite the refusal')
})

test('a bypassed module stays alive, its tail runs out', () => {
  const { faust } = traduire(`
let saw1 sawtooth(freq:110)
let rev1 mono_freeverb(damp:0.4)
saw1 : rev1 : process
_ rev1
`)
  // Faust's own bypass erases the module; ours keeps it fed with silence, its
  // output still summed in — that is what lets the tail come out
  assert.match(faust, /0 : rev1/, 'the module must receive silence, not vanish')
  assert.doesNotMatch(faust, /bypass/, 'the Faust bypass would clear the state')
  assert.equal(compile(faust), null, faust)
})

test('the command line translates a file', () => {
  const out = join(dossier, 'cli.dsp')
  execFileSync('node', [
    new URL('../../bin/faustx.js', import.meta.url).pathname,
    new URL('../../examples/1-drone-that-plays-alone.fx', import.meta.url).pathname,
    '-o', out,
  ], { stdio: 'pipe' })
  assert.equal(compile(readFileSync(out, 'utf8')), null)
})

test('each gesture says what it touched, and what has to be recompiled', () => {
  // this is what a host needs in order to recompile one module instead of the
  // program: the architecture promises it, so it is tested
  const { gestes } = traduire(`
let osc1 sawtooth(freq:110)
let lpf1 lowpass(fc:800)
osc1 : lpf1
lpf1.fc:400
!let osc1
`)
  const vus = gestes.filter(g => g.gesture).map(g =>
    [g.gesture, g.name, g.faust ? 'to compile' : 'nothing to compile'])

  assert.deepEqual(vus, [
    ['place', 'osc1', 'to compile'],
    ['place', 'lpf1', 'to compile'],
    ['wire', null, 'nothing to compile'],
    ['set', 'lpf1', 'nothing to compile'],
    ['release', 'osc1', 'nothing to compile'],
  ])

  const pose = gestes.find(g => g.name === 'lpf1' && g.gesture === 'place')
  assert.match(pose.faust, /^lpf1 = /, 'the Faust of that instance alone')
  assert.deepEqual(pose.needs, [], 'it compiles on its own')
})

test('a module driven by another names what it needs', () => {
  const { gestes } = traduire(`
let lfo1 osc(freq:0.15)
let lpf1 lowpass(fc:800)
lfo1 : lpf1.fc
lpf1 lowpass(fc:900)
`)
  const remplacement = gestes.find(g => g.gesture === 'replace')
  assert.deepEqual(remplacement.needs, ['lfo1'],
    'the host cannot compile lpf1 without lfo1')
})
