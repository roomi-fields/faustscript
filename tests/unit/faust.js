/**
 * Faust's verdict on a program, from the `faust` compiler: the only judge of the Faust FaustX writes.
 */

import { mkdtempSync, rmSync, writeFileSync } from 'node:fs'
import { execFileSync } from 'node:child_process'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

/**
 * The first line of the compiler's error on `faust`, or null when it compiles. The program is
 * compiled as `program.dsp`, so that the message is the same from one run to the next. Throws when
 * the compiler does not run, so that a missing `faust` never reads as a refused program.
 */
export function compile(faust) {
  const folder = mkdtempSync(join(tmpdir(), 'faustx-'))
  try {
    writeFileSync(join(folder, 'program.dsp'), faust)
    try {
      execFileSync('faust', ['-lang', 'c', 'program.dsp', '-o', '/dev/null'], {
        cwd: folder,
        stdio: 'pipe',
      })
      return null
    } catch (error) {
      const message = String(error.stderr ?? '').split('\n')[0]
      if (typeof error.status !== 'number' || message === '') {
        throw new Error(`faust does not run: ${error.message}`)
      }
      return message
    }
  } finally {
    rmSync(folder, { recursive: true })
  }
}
