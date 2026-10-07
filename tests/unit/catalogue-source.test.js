// The catalogue describes the Faust that package.json pins: its header names the versions of
// faustwasm, libfaust and the libraries it was generated from (npm run catalogue), it declares
// every function a documentation title of those libraries names, and it marks the modules that
// faustwasm refuses to compile.

import { readFileSync } from 'node:fs'
import { createRequire } from 'node:module'
import { expect, it } from 'vitest'
import { readCatalogue } from '../../src/catalogue.js'
import { compile, instantiate } from './faust.js'

const require = createRequire(import.meta.url)
const CATALOGUE = readFileSync(new URL('../../lib/faust.fsc', import.meta.url), 'utf8')

/** Where libfaust-wasm keeps its libraries, in its virtual file system. */
const LIBRARIES = '/usr/share/faust'

it('names the faustwasm, libfaust and libraries versions the tests compile with', async () => {
  const compiler = await instantiate()
  const faustwasm = require('@grame/faustwasm/package.json').version
  const library = compiler.fs().readFile(`${LIBRARIES}/version.lib`, { encoding: 'utf8' })
  const [, major, minor, patch] = library.match(/^version\s*=\s*(\d+),.*\n\s*(\d+),.*\n\s*(\d+);/m)
  const header = CATALOGUE.split('\n\n')[0]
  expect(header).toContain(
    `@grame/faustwasm ${faustwasm}: libfaust ${compiler.version()}, ` +
      `libraries ${major}.${minor}.${patch} (version.lib).`
  )
})

it('declares every function a documentation title of the libraries names, alone or grouped', async () => {
  const compiler = await instantiate()
  const fs = compiler.fs()
  const catalogue = readCatalogue(CATALOGUE)
  const titled = new Set()
  for (const file of fs.readdir(LIBRARIES).filter(f => f.endsWith('.lib'))) {
    const text = fs.readFile(`${LIBRARIES}/${file}`, { encoding: 'utf8' })
    for (const [title] of text.matchAll(/^\/\/-+.*`\(\w+\.\)\w+`.*$/gm)) {
      for (const [, prefix, name] of title.matchAll(/`\((\w+)\.\)(\w+)`/g)) {
        titled.add(`${prefix}.${name}`)
      }
    }
  }
  expect(titled).toContain('ef.cubicnl_nodc')
  expect(titled).toContain('ma.SR')
  expect(titled).toContain('pl.SR')
  expect([...titled].filter(name => !catalogue.has(name))).toEqual([])
})

it('marks a module that calls a foreign function faustwasm refuses, and that one only', async () => {
  const catalogue = readCatalogue(CATALOGUE)
  for (const [name, foreign] of [
    ['ma.erf', 'erff'],
    ['no.rnoise', 'arc4random'],
  ]) {
    const module = catalogue.get(name)
    expect(module.attribute('faustwasm', 'unavailable')).toBe(foreign)
    expect(await compile(`import("stdfaust.lib");\nprocess = ${module.body};\n`)).toContain(
      `calling foreign function '${foreign}' is not allowed`
    )
  }
  expect(catalogue.get('fi.lowpass').attribute('faustwasm', 'unavailable')).toBe(undefined)
})

it('gives a module faustwasm refuses no width, the compiler having measured none', () => {
  const catalogue = readCatalogue(CATALOGUE)
  const rnoises = catalogue.get('no.rnoises')
  expect(rnoises.attribute('faustwasm', 'unavailable')).toBe('arc4random')
  const unavailable = [...catalogue.values()].filter(module =>
    module.attribute('faustwasm', 'unavailable')
  )
  expect(unavailable).toContain(rnoises)
  for (const module of unavailable) {
    expect(module.inputs, module.name).toBeUndefined()
    expect(module.outputs, module.name).toBeUndefined()
  }
})

it("reads a module's widths in its own entry only", () => {
  const catalogue = readCatalogue(
    'ma.J0  ma.J0\n  // DOES NOT COMPILE: refused\n\n' +
      'fi.lowpass(N:1, fc:1000)  fi.lowpass(N, fc)\n  // 1 input, 1 output\n\n' +
      'ma.erf  ma.erf\n  faustwasm.unavailable:erff\n' +
      'os.osc(freq:440)  os.osc(freq)\n  // 0 input, 1 output\n'
  )
  expect(catalogue.get('ma.J0').inputs).toBeUndefined()
  expect(catalogue.get('ma.erf').outputs).toBeUndefined()
  expect([catalogue.get('fi.lowpass').inputs, catalogue.get('fi.lowpass').outputs]).toEqual([1, 1])
  expect([catalogue.get('os.osc').inputs, catalogue.get('os.osc').outputs]).toEqual([0, 1])
})
