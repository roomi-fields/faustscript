// The catalogue describes the Faust that package.json pins: its header names the versions of
// faustwasm, libfaust and the libraries it was generated from (npm run catalogue), and it marks
// the modules that faustwasm refuses to compile.

import { readFileSync } from 'node:fs'
import { createRequire } from 'node:module'
import { expect, it } from 'vitest'
import { readCatalogue } from '../../src/catalogue.js'
import { compile, instantiate } from './faust.js'

const require = createRequire(import.meta.url)
const CATALOGUE = readFileSync(new URL('../../lib/faust.fx', import.meta.url), 'utf8')

it('names the faustwasm, libfaust and libraries versions the tests compile with', async () => {
  const compiler = await instantiate()
  const faustwasm = require('@grame/faustwasm/package.json').version
  const library = compiler.fs().readFile('/usr/share/faust/version.lib', { encoding: 'utf8' })
  const [, major, minor, patch] = library.match(/^version\s*=\s*(\d+),.*\n\s*(\d+),.*\n\s*(\d+);/m)
  const header = CATALOGUE.split('\n\n')[0]
  expect(header).toContain(
    `@grame/faustwasm ${faustwasm}: libfaust ${compiler.version()}, ` +
      `libraries ${major}.${minor}.${patch} (version.lib).`
  )
})

it('marks a module that calls a foreign function faustwasm refuses, and that one only', async () => {
  const catalogue = readCatalogue(CATALOGUE)
  for (const [name, foreign] of [
    ['erf', 'erff'],
    ['rnoise', 'arc4random'],
  ]) {
    const module = catalogue.get(name)
    expect(module.attribute('faustwasm', 'unavailable')).toBe(foreign)
    expect(await compile(`import("stdfaust.lib");\nprocess = ${module.body};\n`)).toContain(
      `calling foreign function '${foreign}' is not allowed`
    )
  }
  expect(catalogue.get('lowpass').attribute('faustwasm', 'unavailable')).toBe(undefined)
})
