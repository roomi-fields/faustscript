/**
 * The examples of docs/LANGUAGE.md: each block fenced as `faustscript`, with its examples. An example is
 * a line written at the block's left edge, with the indented lines that follow it (the
 * attributes under a module declaration). An example whose comment is exactly `// refused: CODE` is
 * one the transpiler refuses with that code; every other example is one it applies. The mark is
 * read in the document's source, since apply removes the comment from the text it returns.
 */

import { readFileSync } from 'node:fs'

export const LANGUAGE = readFileSync(new URL('../../docs/LANGUAGE.md', import.meta.url), 'utf8')

const FENCE = /^(\s*)(`{3,}|~{3,})\s*(.*?)\s*$/
const MARK = /^\/\/\s*refused:\s*([A-Z_]+)\s*$/

/**
 * A line split at its comment: the code before the first `//` that stands outside a string, and the
 * comment from that `//` on (empty when there is none).
 */
function split(source) {
  let quoted = false
  for (let k = 0; k < source.length; k++) {
    if (quoted && source[k] === '\\') {
      k++
    } else if (source[k] === '"') {
      quoted = !quoted
    } else if (!quoted && source.startsWith('//', k)) {
      return { code: source.slice(0, k), comment: source.slice(k).trim() }
    }
  }
  return { code: source, comment: '' }
}

/**
 * The examples of one block's lines. Each example holds its text (its first line, without comment
 * or surrounding spaces), the numbers of its first and last lines in the block from 1, and the code
 * its mark names (`null` for an example the transpiler applies). A line that holds only spaces or a
 * comment belongs to no example. `problem` receives each writing that cannot be read as an example.
 */
function examplesOf(body, problem) {
  const out = []
  body.forEach((source, k) => {
    const { code, comment } = split(source)
    const mark = MARK.exec(comment)?.[1] ?? null
    if (mark === null && /refused/i.test(comment)) {
      problem(k + 1, `a refusal mark is written \`// refused: CODE\`: ${comment}`)
    }
    if (code.trim() === '') {
      return
    }
    const previous = out.at(-1)
    if (/^\s/.test(source)) {
      if (previous === undefined) {
        problem(k + 1, `an indented line continues no example: ${source.trim()}`)
        return
      }
      if (mark !== null) {
        problem(k + 1, 'a refusal mark goes on the first line of its example')
      }
      previous.last = k + 1
      return
    }
    out.push({ text: code.trim(), first: k + 1, last: k + 1, refused: mark })
  })
  return out
}

/**
 * Every fenced block of `doc`, in order: the line of the document where it opens, its margin, its
 * info string, its fence line and its body lines. A fence never closed ends the reading and is
 * returned with `closed` false and the lines after it as its body.
 */
export function fences(doc) {
  const out = []
  const lines = doc.split('\n')
  for (let i = 0; i < lines.length; i++) {
    const open = FENCE.exec(lines[i])
    if (open === null) {
      continue
    }
    const [, margin, marker, info] = open
    let j = i + 1
    while (j < lines.length && !closes(lines[j], marker)) {
      j++
    }
    out.push({
      at: i + 1,
      margin,
      info,
      fence: lines[i],
      body: lines.slice(i + 1, j),
      closed: j < lines.length,
    })
    i = j
  }
  return out
}

/**
 * Every `faustscript` block of `doc`, and the problems that keep a writing from being read: a fence that
 * names faustscript without opening a block at the left edge, a fence never closed, a block without an
 * example, a malformed refusal mark. A block holds its text, the line of the document where it
 * opens, and its examples; a problem holds the document line it is on and what is wrong.
 */
export function read(doc) {
  const blocks = []
  const problems = []
  for (const { at, margin, info, fence, body, closed } of fences(doc)) {
    if (!closed) {
      problems.push({ at, what: 'a fence is never closed' })
      break
    }
    const isFaustScript = /faustscript/i.test(info)
    if (isFaustScript && (margin !== '' || info !== 'faustscript')) {
      problems.push({
        at,
        what: `a faustscript block opens with \`\`\`faustscript at the left edge: ${fence}`,
      })
    } else if (isFaustScript) {
      const problem = (k, what) => problems.push({ at: at + k, what })
      const examples = examplesOf(body, problem)
      if (examples.length === 0) {
        problem(0, 'a faustscript block holds no example')
      } else {
        blocks.push({ at, text: body.join('\n'), examples })
      }
    }
  }
  return { blocks, problems }
}

/** Does `line` close a fence opened by `marker`: the same character, at least as many times? */
function closes(line, marker) {
  const close = FENCE.exec(line)
  return (
    close !== null &&
    close[3] === '' &&
    close[2][0] === marker[0] &&
    close[2].length >= marker.length
  )
}
