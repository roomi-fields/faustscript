// How long does it take to compile a program of N modules?
//
// The whole design rests on one ratio: a gesture recompiles the module it
// touched, never the program. That is only worth doing if one module is much
// cheaper than fifty. This measures both, where the sound will actually be
// made — libfaust compiled to WebAssembly, which is what a browser host runs —
// and, for comparison, the same programs through the native compiler.
//
//   node tools/measure-compilation.mjs
//
// The native column needs `faust` on the PATH; it is skipped if absent.

import { execFileSync } from 'node:child_process'
import { mkdtempSync, writeFileSync } from 'node:fs'
import { createRequire } from 'node:module'
import { tmpdir } from 'node:os'
import { dirname, join } from 'node:path'

const SIZES = [1, 5, 20, 50]
const ROUNDS = 12
const WARMUP = 3 // the first compiles pay for waking up; they are not the gesture

/** A program of `n` independent filters, salted so no compiler cache can hit. */
function program(n, salt) {
  const modules = Array.from(
    { length: n },
    (_, i) => `m${i + 1} = fi.lowpass(3, ${800 + i + 1} + ${salt} * 0);`
  ).join('\n')
  const chain = Array.from({ length: n }, (_, i) => `(os.sawtooth(${101 + i}) : m${i + 1})`).join(
    ' , '
  )
  return `import("stdfaust.lib");\nprocess = ${chain};\n${modules}\n`
}

const median = xs => [...xs].sort((a, b) => a - b)[Math.floor(xs.length / 2)]

/** Runs `compile` over each size, discarding the warm-up rounds. */
async function measure(compile) {
  const rows = []
  for (const n of SIZES) {
    const times = []
    for (let round = -WARMUP; round < ROUNDS; round++) {
      const start = performance.now()
      await compile(program(n, `${n}-${round}`), `p${n}r${round}`)
      const took = performance.now() - start
      if (round >= 0) {
        times.push(took)
      }
    }
    rows.push({ n, ms: median(times), lo: Math.min(...times), hi: Math.max(...times) })
  }
  return rows
}

function report(title, rows) {
  console.log(`\n${title}`)
  for (const { n, ms, lo, hi } of rows) {
    console.log(
      `  ${String(n).padStart(2)} modules  median ${ms.toFixed(1).padStart(6)} ms` +
        `   (${lo.toFixed(1)} – ${hi.toFixed(1)})`
    )
  }
  const ratio = rows.at(-1).ms / rows[0].ms
  console.log(`  one module is ${ratio.toFixed(1)}× cheaper than ${rows.at(-1).n}`)
}

// --- in the browser ---------------------------------------------------------

const require = createRequire(import.meta.url)
const pkg = dirname(require.resolve('@grame/faustwasm/package.json'))
const FaustWasm = await import(join(pkg, 'dist/esm/index.js'))

const faustModule = await FaustWasm.instantiateFaustModuleFromFile(
  join(pkg, 'libfaust-wasm/libfaust-wasm.js')
)
const compiler = new FaustWasm.FaustCompiler(new FaustWasm.LibFaust(faustModule))

console.log(`libfaust-wasm carries Faust ${compiler.version()}, on node ${process.version}`)

report(
  'through libfaust-wasm, in the running process',
  await measure(async (code, name) => {
    // the argument list is one string here, not an array: the wasm binding wants it that way
    const factory = await compiler.createMonoDSPFactory(name, code, '-I libraries/')
    if (!factory) {
      throw new Error(compiler.getErrorMessage())
    }
  })
)

// --- natively, for comparison -----------------------------------------------

let native
try {
  native = execFileSync('faust', ['--version'], { encoding: 'utf8' }).split('\n')[0]
} catch {
  console.log('\nno `faust` on the PATH: skipping the native column')
  process.exit(0)
}

const dir = mkdtempSync(join(tmpdir(), 'faustx-measure-'))
const floor = median(
  Array.from({ length: 12 }, () => {
    const file = join(dir, 'floor.dsp')
    writeFileSync(file, 'import("stdfaust.lib");\nprocess = _;\n')
    const start = performance.now()
    execFileSync('faust', ['-lang', 'wasm', '-o', '/dev/null', file], { stdio: 'ignore' })
    return performance.now() - start
  })
)

console.log(`\n${native} — process startup measured at ${floor.toFixed(1)} ms, subtracted below`)

report(
  'natively, same backend, startup subtracted',
  (
    await measure(async (code, name) => {
      const file = join(dir, `${name}.dsp`)
      writeFileSync(file, code)
      execFileSync('faust', ['-lang', 'wasm', '-o', '/dev/null', file], { stdio: 'ignore' })
    })
  ).map(r => ({ ...r, ms: r.ms - floor, lo: r.lo - floor, hi: r.hi - floor }))
)
