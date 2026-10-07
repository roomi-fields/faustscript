/**
 * Faust's verdict on a program, from the Faust of @grame/faustwasm, the version package.json pins:
 * the only judge of the Faust FaustX writes.
 */

import { copyFileSync, mkdtempSync, rmSync } from 'node:fs'
import { createRequire } from 'node:module'
import { tmpdir } from 'node:os'
import { dirname, join } from 'node:path'

const require = createRequire(import.meta.url)
const pkg = dirname(require.resolve('@grame/faustwasm/package.json'))
const libfaust = join(pkg, 'libfaust-wasm/libfaust-wasm')

/** The compiler's instantiation, started once per test file: its compiler serves every compile. */
let compiler = null

/**
 * A new compiler. faustwasm loads libfaust by writing a module next to the script it is given and
 * deleting it after: the script is copied into a folder of this call's own, so that test files
 * instantiating at the same time never delete each other's module.
 */
async function instantiate() {
  const FaustWasm = await import(join(pkg, 'dist/esm/index.js'))
  const folder = mkdtempSync(join(tmpdir(), 'faustx-libfaust-'))
  try {
    const script = join(folder, 'libfaust-wasm.js')
    copyFileSync(`${libfaust}.js`, script)
    const module = await FaustWasm.instantiateFaustModuleFromFile(
      script,
      `${libfaust}.data`,
      `${libfaust}.wasm`
    )
    return new FaustWasm.FaustCompiler(new FaustWasm.LibFaust(module))
  } finally {
    rmSync(folder, { recursive: true })
  }
}

/**
 * The compiler's error message on `faust`, whole and as it gives it, or null when it compiles. The
 * program is compiled as `program`, so that the message is the same from one run to the next.
 * Throws when the compiler fails without a message of this compilation, so that a broken compiler
 * never reads as a refused program.
 */
export async function compile(faust) {
  const faustwasm = await (compiler ??= instantiate())
  try {
    // the argument list is one string here, not an array: the wasm binding wants it that way
    await faustwasm.createMonoDSPFactory('program', faust, '-I libraries/')
    return null
  } catch (error) {
    const message = faustwasm.getErrorMessage()
    if (message === '' || error.message !== message) {
      throw new Error(`faustwasm does not compile: ${error.message}`)
    }
    return message
  }
}
