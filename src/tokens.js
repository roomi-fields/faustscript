// The part of the grammar that a grammar file cannot write: what a newline
// ends. `faustscript.grammar` declares both; lezer-generator builds the parser
// around them.
//
// A Faust statement — a definition, an `import`, a `declare` — runs up to its
// `;`, over as many lines as it takes; a gesture ends at the newline. The
// context counts the Faust statements open at this point of the text, and the
// newline is the end of a line when none is open, a space when one is. This is
// how lezer's Python grammar keeps a newline inside brackets from ending a
// statement.

import { ExternalTokenizer, ContextTracker } from '@lezer/lr'
import {
  endOfLine,
  continuation,
  FaustHead,
  FaustDefinition,
  Import,
  Declare,
  _import,
  declare,
} from './parser.terms.js'

const LINE_FEED = 10
const CARRIAGE_RETURN = 13
const SPACE = 32
const TAB = 9

const ends = c => c === LINE_FEED || c === CARRIAGE_RETURN
const blank = c => ends(c) || c === SPACE || c === TAB

/** The number of Faust statements open: one more at a head or a Faust word,
 *  one fewer once the statement is complete. */
export const statements = new ContextTracker({
  start: 0,
  shift(open, term) {
    return term === _import || term === declare ? open + 1 : open
  },
  reduce(open, term) {
    if (term === FaustHead) {
      return open + 1
    }
    if (term === FaustDefinition || term === Import || term === Declare) {
      return Math.max(open - 1, 0)
    }
    return open
  },
  hash: open => open,
  strict: false,
})

/** A newline and the blank lines after it: the end of a line, or inside an
 *  open Faust statement a space. */
export const newlines = new ExternalTokenizer(
  (input, stack) => {
    if (!ends(input.next)) {
      return
    }
    while (blank(input.next)) {
      input.advance()
    }
    input.acceptToken(stack.context > 0 ? continuation : endOfLine)
  },
  { contextual: true }
)
