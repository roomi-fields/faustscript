#!/usr/bin/env node
// The Faust of the pinned @grame/faustwasm, served to the catalogue's generator
// (tools/generate-declarations.py, tools/measure-ranges.py): the libraries it
// carries, the compiler that judges a module, and the bench that makes it sound.
//
//   node tools/faustwasm.mjs
//
// One JSON request on stdin, its JSON answer on stdout; tools/faustwasm.py runs
// each request in a process of its own:
//
//   {"op": "versions"}                  → {"faustwasm", "libfaust", "libraries"}
//   {"op": "libraries", "to": dir}      → {"files": n}, every .lib copied into dir
//   {"op": "compile", "code": faust}    → {"inputs", "outputs"} or {"error": message}
//   {"op": "measure", "code": faust,
//    "rate", "duration", "settle"}      → {"arity", "silence", "noise"}, {"error": message},
//                                         or {"trap": message} when the module stops dead
//
// An answer {"broken": message} says that the compiler failed outside of a
// compilation.

import { readFileSync, writeFileSync } from 'node:fs'
import { createRequire } from 'node:module'
import { join } from 'node:path'
import { text } from 'node:stream/consumers'
import { instantiate } from '../tests/unit/faust.js'

const require = createRequire(import.meta.url)
const FaustWasm = await import(
  join(require.resolve('@grame/faustwasm/package.json'), '../dist/esm/index.js')
)

/** Where libfaust-wasm keeps its libraries, in its virtual file system. */
const LIBRARIES = '/usr/share/faust'

/** The block the bench computes at a time, as a host's audio callback does. */
const BLOCK = 512

// faustwasm writes its progress on the console: stdout carries the answers alone
console.log = console.info = console.warn = () => {}

const compiler = await instantiate()
const fs = compiler.fs()

/** The version triplet of `version.lib`, read from its definition. */
function librariesVersion() {
  const text = fs.readFile(`${LIBRARIES}/version.lib`, { encoding: 'utf8' })
  const definition = text.replace(/\/\/.*$/gm, '').match(/version\s*=\s*([^;]*);/)
  return definition[1].split(',').map(Number).join('.')
}

function versions() {
  return {
    faustwasm: JSON.parse(readFileSync(require.resolve('@grame/faustwasm/package.json'))).version,
    libfaust: compiler.version(),
    libraries: librariesVersion(),
  }
}

function libraries(to) {
  const files = fs.readdir(LIBRARIES).filter(f => f.endsWith('.lib'))
  for (const f of files) {
    writeFileSync(join(to, f), fs.readFile(`${LIBRARIES}/${f}`))
  }
  return { files: files.length }
}

/**
 * The factory of `code`, or the compiler's message. The program is named `module`, so that a
 * message is the same from one run to the next.
 */
async function factory(code) {
  try {
    // the argument list is one string here, not an array: the wasm binding wants it that way
    return { factory: await compiler.createMonoDSPFactory('module', code, '') }
  } catch (error) {
    const message = compiler.getErrorMessage()
    if (message === '' || error.message !== message) {
      return { broken: error.message }
    }
    return { error: message }
  }
}

async function compile(code) {
  const { factory: f, ...failure } = await factory(code)
  if (!f) {
    return failure
  }
  const { inputs, outputs } = JSON.parse(f.json)
  compiler.deleteDSPFactory(f)
  return { inputs, outputs }
}

/**
 * The bench's white noise, for `channels` inputs over `length` samples: a 64-bit linear
 * congruential generator from a fixed seed, filled block by block and channel after channel,
 * full scale in [-1, 1).
 */
function noise(channels, length) {
  const buffers = Array.from({ length: channels }, () => new Float32Array(length))
  let seed = 20260806n
  for (let pos = 0; pos < length; pos += BLOCK) {
    const end = Math.min(pos + BLOCK, length)
    for (const buffer of buffers) {
      for (let j = pos; j < end; j++) {
        seed = BigInt.asUintN(64, seed * 6364136223846793005n + 1442695040888963407n)
        buffer[j] = Math.fround(Number((seed >> 33n) & 0x7fffffn) / 4194304) - 1
      }
    }
  }
  return buffers
}

/** Rounds to `digits` significant digits, as the answer records a measured value. */
const significant = (value, digits) => Number(value.toPrecision(digits))

/**
 * One regime: a fresh instance with its starting values, fed silence or noise, and the range of
 * its outputs over the tail, after `settle` seconds. faustwasm's offline render computes whole
 * blocks of BLOCK samples. The peak is kept per quarter of the tail, each block counted in the
 * quarter where it starts.
 */
async function regime(f, rate, inputs, total, start) {
  const generator = new FaustWasm.FaustMonoDspGenerator()
  const processor = await generator.createOfflineProcessor(rate, BLOCK, f)
  const outputs = processor.render(inputs, total)
  processor.destroy()
  const measured = total - start
  const peaks = [0, 0, 0, 0]
  let low = 0
  let high = 0
  let nonfinite = 0
  let points = 0
  for (let pos = Math.ceil(start / BLOCK) * BLOCK; pos < total; pos += BLOCK) {
    const quarter = Math.min(3, Math.floor((4 * (pos - start)) / (measured > 0 ? measured : 1)))
    const end = Math.min(pos + BLOCK, total)
    for (const output of outputs) {
      for (let j = pos; j < end; j++) {
        const v = output[j]
        if (!Number.isFinite(v)) {
          nonfinite++
          continue
        }
        if (points === 0 || v < low) {
          low = v
        }
        if (points === 0 || v > high) {
          high = v
        }
        peaks[quarter] = Math.max(peaks[quarter], Math.abs(v))
        points++
      }
    }
  }
  return {
    min: significant(low, 9),
    max: significant(high, 9),
    nonfinite,
    points,
    peaks: peaks.map(p => significant(p, 6)),
  }
}

async function measure(code, rate, duration, settle) {
  const { factory: f, ...failure } = await factory(code)
  if (!f) {
    return failure
  }
  try {
    const { inputs, outputs } = JSON.parse(f.json)
    const answer = { arity: [inputs, outputs] }
    if (outputs === 0) {
      return answer
    }
    const total = Math.floor(duration * rate)
    const start = Math.floor(settle * rate)
    const silence = Array.from({ length: inputs }, () => new Float32Array(total))
    try {
      answer.silence = await regime(f, rate, silence, total, start)
      if (inputs > 0) {
        answer.noise = await regime(f, rate, noise(inputs, total), total, start)
      }
    } catch (error) {
      // a WebAssembly trap of the module itself: the compiler stays sound
      return { trap: error.message }
    }
    return answer
  } finally {
    compiler.deleteDSPFactory(f)
  }
}

async function answer(request) {
  switch (request.op) {
    case 'versions':
      return versions()
    case 'libraries':
      return libraries(request.to)
    case 'compile':
      return compile(request.code)
    case 'measure':
      return measure(request.code, request.rate, request.duration, request.settle)
    default:
      return { broken: `unknown request: ${request.op}` }
  }
}

let reply
try {
  reply = await answer(JSON.parse(await text(process.stdin)))
} catch (error) {
  reply = { broken: error.message }
}
process.stdout.write(`${JSON.stringify(reply)}\n`)
