// The guard of the old name: no file of the repository, in its path or in its text, writes the
// language's old name (FaustX) or its old extension (.fx) — a block fenced `faustx` or a piece
// named `x.fx` is skipped without a word.
//
// What may write it: the tracker's prefix (`faustx-`, in lower case, opens every ticket id), the
// tracker's data (.beads/) and the supervisor's journal (pitmaster/), which are history, this
// guard, which names what it refuses, and the entries of CHANGELOG.md, which tell the history;
// its link references are addresses, and are read.
import { execFileSync } from 'node:child_process'
import { readFileSync } from 'node:fs'
import { expect, it } from 'vitest'

const ROOT = new URL('../../', import.meta.url)

/** The old name, in any case, and the old extension. */
const OLD_NAME = /faustx|\.fx\b/i

/** A ticket id (`faustx-zj5.50`) or the tracker's prefix written alone (`faustx-` in backquotes). */
const TRACKER = /faustx-(?:[a-z0-9]+(?:\.\d+)*|(?=`))/g

const HISTORY = ['.beads/', 'pitmaster/']

/** This guard's own path, relative to the root. */
const SELF = import.meta.url.slice(ROOT.href.length)

/** The lines of a file that may name the old name: in CHANGELOG.md, every line but a link reference. */
const tellsHistory = (path, line) => path === 'CHANGELOG.md' && !/^\[[^\]]+\]:/.test(line)

/** Every file git follows or would follow (tracked, or new and not ignored), relative to the root. */
const files = () =>
  execFileSync('git', ['ls-files', '--cached', '--others', '--exclude-standard', '-z'], {
    cwd: ROOT,
    encoding: 'utf8',
  })
    .split('\0')
    .filter(Boolean)

/** The places of a repository that write the old name: `path` alone, or `path:line`. */
function oldNames(paths, read) {
  const found = []
  for (const path of paths.filter(p => p !== SELF && !HISTORY.some(h => p.startsWith(h)))) {
    if (OLD_NAME.test(path)) {
      found.push(path)
    }
    const text = read(path)
    if (text === null || text.includes('\0')) {
      continue
    }
    text.split('\n').forEach((line, i) => {
      if (OLD_NAME.test(line.replace(TRACKER, '')) && !tellsHistory(path, line)) {
        found.push(`${path}:${i + 1}`)
      }
    })
  }
  return found
}

const readText = path => {
  try {
    return readFileSync(new URL(path, ROOT), 'utf8')
  } catch {
    // a tracked file deleted from the working tree has no text to read
    return null
  }
}

it('reads the repository, this guard and its neighbours included', () => {
  expect(files()).toEqual(expect.arrayContaining([SELF, 'package.json', 'CHANGELOG.md']))
})

it('finds the old name nowhere in the repository', () => {
  expect(oldNames(files(), readText)).toEqual([])
})

it('refuses the old name in a path, a fence, a word and a link reference', () => {
  const texts = {
    'examples/piece.fx': 'saw1 : lpf1\n',
    'docs/GUIDE.md': 'intro\n```faustx\nsaw1\n```\n',
    'README.md': 'FaustX plays.\nA FaustX-based tool.\n',
    'CHANGELOG.md': '- FaustX is born.\n[0.1.0]: https://github.com/roomi-fields/faustx/releases\n',
  }
  expect(oldNames(Object.keys(texts), p => texts[p])).toEqual([
    'examples/piece.fx',
    'docs/GUIDE.md:2',
    'README.md:1',
    'README.md:2',
    'CHANGELOG.md:2',
  ])
})

it('lets the tracker prefix, the history and the new name pass', () => {
  const texts = {
    'docs/NOTE.md': 'see faustx-zj5.50; prefix `faustx-`; FaustScript, piece.fsc, the fx chain\n',
    '.beads/issues.jsonl': '{"title":"FaustX at BPScript\'s level"}\n',
    'pitmaster/SUIVI.md': 'FaustX au niveau de BPScript\n',
  }
  expect(oldNames(Object.keys(texts), p => texts[p])).toEqual([])
})
