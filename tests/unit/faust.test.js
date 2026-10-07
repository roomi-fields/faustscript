// The compile helper: the Faust of @grame/faustwasm, its verdict and its message as the compiler gives them.

import { expect, it } from 'vitest'
import { compile } from './faust.js'

it('compiles with the libraries faustwasm carries', async () => {
  expect(await compile('import("stdfaust.lib");\nprocess = la.identity(2);\n')).toBe(null)
})

it("returns the compiler's whole message for a refused program, the same on every run", async () => {
  const faust = 'import("stdfaust.lib");\nprocess = os.osc(440) : _,_;\n'
  const message = await compile(faust)
  expect(message).toMatch(/^ERROR : sequential composition osc\(440\):B\nThe number of outputs/)
  expect(await compile(faust)).toBe(message)
})

it('names the program `program`, so that a message carries no file of the run', async () => {
  expect(await compile('process = nowhere;\n')).toBe(
    'program:1 : ERROR : undefined symbol : nowhere\n'
  )
})
