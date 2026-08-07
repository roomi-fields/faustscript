#!/usr/bin/env node
// faustx — translate a FaustX file into Faust.
//
//   faustx piece.fx              writes the Faust to standard output
//   faustx piece.fx -o piece.dsp writes it to a file
//   faustx --version
//
// What it prints on standard error, if anything, is the gestures it refused:
// a line that names something that does not exist, or asks for something Faust
// cannot do. The rest of the file is still translated — that is the rule.

import { readFileSync, writeFileSync } from 'node:fs'
import { fileURLToPath } from 'node:url'
import { dirname, join } from 'node:path'
import { createTranspiler } from '../src/transpiler.js'

const here = dirname(fileURLToPath(import.meta.url))
const root = join(here, '..')

function main(argv) {
  if (argv.includes('--version')) {
    const { version } = JSON.parse(readFileSync(join(root, 'package.json'), 'utf8'))
    console.log(version)
    return 0
  }

  const output = takeOption(argv, '-o') ?? takeOption(argv, '--output')
  const [source] = argv.filter(a => !a.startsWith('-'))

  if (!source) {
    console.error('usage: faustx <file.fx> [-o <file.dsp>]')
    return 2
  }

  const transpiler = createTranspiler(
    readFileSync(join(root, 'lib/faust.fx'), 'utf8'),
    readFileSync(join(root, 'lib/translation.fx'), 'utf8'))

  const refused = transpiler.apply(readFileSync(source, 'utf8'))
  for (const { line, text, outcome } of refused) {
    console.error(`${source}:${line}: refused — ${outcome.reason}\n    ${text.trim()}`)
  }

  const faust = transpiler.write()
  if (output) writeFileSync(output, faust)
  else process.stdout.write(faust)

  // a refused gesture is not a failure of the translation: the rest stands
  return 0
}

/** Reads `-o value` out of the arguments and removes both. */
function takeOption(argv, flag) {
  const at = argv.indexOf(flag)
  if (at < 0) return null
  const [value] = argv.splice(at, 2).slice(1)
  return value ?? null
}

process.exit(main(process.argv.slice(2)))
