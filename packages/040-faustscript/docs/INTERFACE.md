# FaustScript — interface

FaustScript's public package, `faustscript` (`packages/040-faustscript`), exports one function, `createSession`, which returns a session holding one graph of instances and wires: the piece being played. The host sends FaustScript text to the session's `apply`, which applies each line as a gesture on the graph and returns what each line did; it reads the Faust program, a frozen view of the graph, the program's controls and the catalogue from four other methods. A second entry, `faustscript/editor`, gives an editor the parser of the grammar and the refusals of a text as diagnostics. This document lists each element that crosses that boundary: its form, what it returns, what it refuses, and the guard that holds it.

## 1. The package

| specifier | content |
| --- | --- |
| `faustscript` | `createSession` and the types of §2 to §9 |
| `faustscript/editor` | `parser`, `diagnose` and the types of §10 |
| command `faustscript` | the command line (§11) |
| peer dependency `@grame/faustwasm` | the faustwasm version the host compiles with, at one exact version |

The package declares `@grame/faustwasm` as a peer dependency at one exact version, written in its `package.json`. The catalogue is generated from the Faust libraries that version embeds, and the tests compile the Faust FaustScript writes with it: the host that installs that version plays the Faust the tests checked.

Every name, field, gesture, code, parameter and sentence form of this document is a contract: changing one is a breaking change, recorded in `CHANGELOG.md` under *Changed*. Changing the declared faustwasm version is a change of the same kind.

**Guard** — the interface test (target, faustx-zj5.36): the package exports exactly the elements of this list, their declared types are the signatures of this document, and the declared faustwasm version is the one the catalogue records and the tests compile with.

## 2. `createSession`

```ts
export function createSession(channels: number): Session
```

It returns a session whose graph is empty and whose master bus, `process`, has `channels` channels: the host fixes that number once, when it creates the session, and each source into the master bus adapts to it (`LANGUAGE.md` §8). It throws a `RangeError` when `channels` is not a positive integer. The library reads the catalogue once, the first time a session needs it, and every session reads that same frozen value. Two sessions share no other state: the same text, applied to each in the same order of gestures, returns the same results, to the character.

**Guard** — target, faustx-zj5.12: two sessions given the same text return equal results, and a computed signal of the second session is named as in the first; target, faustx-zj5.54: the program `write` returns has as many outputs as the session's master bus has channels, and a count that is not a positive integer throws.

## 3. The session

```ts
export interface Session {
  apply(text: string): readonly LineResult[]
  write(): string
  graph(): GraphView
  controls(): readonly Control[]
  catalogue(): Catalogue
}
```

`apply` is the only method that changes the graph. `write`, `graph`, `controls` and `catalogue` read it and change nothing.

## 4. `apply` and the result of a line

`apply` receives FaustScript text, one or more lines, as the author wrote it. It applies the lines in order and returns one result per line that carries a statement, in the same order. A blank line, or a line that holds only a comment, returns no result; the other lines keep their number in the text. A result describes its line at the moment it was applied: a later line of the same text that releases the instance does not change it.

```ts
export type Gesture =
  | 'define'
  | 'place'
  | 'replace'
  | 'release'
  | 'remove'
  | 'bypass'
  | 'set'
  | 'wire'

export interface LineResult {
  readonly line: number
  readonly text: string
  readonly gesture: Gesture | null
  readonly name: string | null
  readonly outcome: Outcome
  readonly faust?: string
  readonly needs?: readonly string[]
  readonly recompile?: readonly string[]
  readonly port?: string
  readonly value?: string
  readonly path?: string
}

export type Outcome =
  | { readonly done: true }
  | { readonly done: false; readonly fault: Fault }
```

| field | content |
| --- | --- |
| `line` | the line's number in the text passed to `apply`, from 1, blank and comment lines counted |
| `text` | the line, without its surrounding spaces |
| `gesture` | the gesture the line expresses; `null` when the line has no form the grammar reads |
| `name` | the instance the gesture touches, or the name a `define` gives its Faust meaning; `null` for a wire, an `import` and a `declare` |
| `outcome` | applied, or refused with its fault (§5) |
| `faust`, `needs` | present when a `place`, `replace`, `bypass` or `remove` is applied: the Faust definition of that instance alone, and the other instances that definition cites, which the host compiles with it |
| `recompile` | present when a `define` is applied: the instances whose body cites the defined name, or every placed instance for an `import` or a `declare`, in the order they were placed, which the host recompiles |
| `port`, `value`, `path` | present when a `set` is applied: the port, the value as written, and the control path from the program root |

The gesture says what the line does to the graph, and what the host has to compile:

| gesture | line | effect on the graph | returns |
| --- | --- | --- | --- |
| `define` | `gain = 0.25;`, `import("mes-modules.fsc");` | gives `gain` its Faust meaning, in place of an earlier definition; an import or a declaration reaches every name | `recompile` |
| `place` | `let lpf1 fi.lowpass(fc=800)` | adds the instance `lpf1` | `faust`, `needs` |
| `replace` | `lpf1 fi.lowpass(fc=400)`, `lpfs:16` | replaces the body of `lpf1`, or the number of copies of `lpfs`, an instance without a number having one; the name, the wires, the number of copies and the settings whose port the body carries stay | `faust`, `needs` |
| `release` | `!let lpf1` | deletes `lpf1` and its wires; the name becomes free | — |
| `remove` | `! lpf1` | takes `lpf1` and its wires out of the flow; the name stays taken | `faust`, `needs` |
| `bypass` | `_ lpf1`, `!_ lpf1` | lets the signal through `lpf1`, or puts `lpf1` back | `faust`, `needs` |
| `set` | `lpf1.fc = 400` | records the value of the port `fc` | `port`, `value`, `path` |
| `wire` | `osc1 : lpf1`, `osc1 !: lpf1` | adds or cuts wires | — |

**The ports of an instance.** An instance whose body is a module carries the parameters of that module that carry no nature (§9). An instance whose body is a Faust expression carries the ports its author named in that body: `let lpf1 fi.lowpass(3, cutoff=800)` carries the port `cutoff`. A setting or a wire that targets any other port is refused (§5).

**The control path.** An instance becomes a Faust group named after it, and a control a slider inside that group: `let lpf1 fi.lowpass(fc=800)` writes `lpf1 = vgroup("lpf1", fi.lowpass(4, hslider("fc…", 800, 2, 8000, …)));`, and `lpf1.fc = 400` returns the path `/lpf1/fc`. A `set` compiles nothing: the host writes the value on the running circuit at that path. The prefix that a compiled program adds above the program root is the host's.

**Guard** — `tests/unit/transpiler.test.js` (each gesture says what it touched, and what has to be recompiled; a module driven by another names what it needs); target, faustx-zj5.54: a `define` returns the instances whose body cites the name, and a resize returns `replace` with the bank's Faust; target, faustx-zj5.9: a `set` returns its port, its value and its path; target, faustx-zj5.36: a blank line and a comment line return no result, and the next line keeps its number; the interface test.

## 5. Refusals

A refused line changes nothing in the graph, and the lines after it are applied. Its outcome carries a fault: a code from the closed list below, the sentence that names the cause and the name involved, the values that sentence is written from, and the position of the writing at fault. The code is what the host acts on; the message is what the author reads; the position is where an editor marks it. A fault has the fields of BPScript's, so that a host that plays both reads one form.

```ts
export interface Fault {
  readonly code: RefusalCode
  readonly message: string
  readonly params: Readonly<Record<string, string>>
  readonly origin: Origin
}

export interface Origin {
  readonly line: number
  readonly column: number
  readonly endLine: number
  readonly endColumn: number
}

export type RefusalCode =
  | 'UNREADABLE'
  | 'EMPTY_EXPRESSION'
  | 'UNKNOWN_FORM'
  | 'ALREADY_PLACED'
  | 'UNKNOWN_NAME'
  | 'UNAVAILABLE_MODULE'
  | 'INCOMPLETE_SETTING'
  | 'UNKNOWN_PORT'
  | 'SETTING_FROM_INPUT'
  | 'NO_SUCH_WIRE'
  | 'NAME_IS_INSTANCE'
  | 'NAME_IS_DEFINITION'
  | 'MASTER_WITH_PARAMETER'
  | 'CHANNEL_OUT_OF_RANGE'
```

| code | the line | `params` | message |
| --- | --- | --- | --- |
| `UNREADABLE` | does not read by the grammar | `text` | `does not read: <text>` |
| `EMPTY_EXPRESSION` | an expression with no term | — | `empty expression` |
| `UNKNOWN_FORM` | a form the grammar reads and no gesture handles | `form` | `unknown form: <form>` |
| `ALREADY_PLACED` | `let lpf1 …` when `lpf1` is placed | `name` | `lpf1 is already placed` |
| `UNKNOWN_NAME` | names an instance that does not exist, or gives a new body to a name that is not placed | `name` | `ghost does not exist` |
| `UNKNOWN_NAME` | writes the last member of a catalogue module's name without its prefix, where no instance bears it: `let lpf1 lowpass`, `saw1 : lowpass` | `name`, `modules` | `lowpass is not a module; fi.lowpass is` |
| `UNAVAILABLE_MODULE` | places or gives a body that calls a module the declared faustwasm does not provide: `let n1 no.rnoises` | `module`, `function` | `no.rnoises calls arc4random, which faustwasm does not provide` |
| `INCOMPLETE_SETTING` | a setting without its port or its value | `text` | `incomplete setting: <text>` |
| `UNKNOWN_PORT` | a setting or a wire that targets a port the instance does not carry: `lpf1.nope = 3`, `osc1 : lpf1.nope` | `name`, `port` | `lpf1 has no port nope` |
| `SETTING_FROM_INPUT` | drives a port with a signal that carries a program input | `name` | `in1 carries one of the program's inputs: a port is driven by a signal, never by an input` |
| `NO_SUCH_WIRE` | `osc1 !: lpf1` where no wire joins them | `from`, `to` | `no wire between osc1 and lpf1` |
| `NAME_IS_INSTANCE` | a Faust definition of a placed instance's name: `lpf1 = 3;` | `name`, `port`, `value` | `lpf1 is an instance; set a port (lpf1.fc = 3) or give the definition another name` |
| `NAME_IS_INSTANCE` | the same, when the instance carries no port: `let vca1 *` then `vca1 = 3;` | `name` | `vca1 is an instance; replace its body (vca1 …) or give the definition another name` |
| `NAME_IS_DEFINITION` | `let gain …` when a Faust definition gives `gain` | `name` | `gain is a Faust definition; give the instance another name` |
| `MASTER_WITH_PARAMETER` | a Faust definition that gives the master bus parameters: `process(x) = x;` | `name` | `process is the master bus; it takes no parameter` |
| `CHANNEL_OUT_OF_RANGE` | a range of channels that runs past the last channel of its source or destination: `src2.2 :4 dst3.1` when `src2` has 3 | `name`, `first`, `last`, `channels` | `src2 has 3 channels; 2 to 5 runs past them` |

`params` holds, under the names of its column, the values the message is written from, as they appear in the line; for `NAME_IS_INSTANCE`, `port` is the first port the instance carries and `value` the expression the definition gives; for `CHANNEL_OUT_OF_RANGE`, `name` is the end the range runs past, `first` and `last` the channels the range reaches on it, and `channels` its number of channels. `origin` is the span of the writing at fault in the text passed to `apply`: the node the refusal names (the name, the port, the wire), or the line without its surrounding spaces for `UNREADABLE`, `EMPTY_EXPRESSION` and `UNKNOWN_FORM`. Its lines count from 1 as `line` does, its columns from 1 in UTF-16 code units; `endColumn` is just past the last character.

A module that faustwasm does not provide is one whose Faust calls a foreign function that faustwasm's WebAssembly backend refuses; the catalogue marks it (§9), and its sentence names that function. An error the Faust compiler raises on the Faust that FaustScript writes is the compiler's message: the host receives it from the compiler.

**Guard** — `tests/unit/transpiler.test.js` (a faulty line is refused without touching the graph; a port cannot be driven by a program input; a name without its prefix is refused, and its sentence names the modules); `tests/unit/language-examples.test.js` (each refused example of the language reference carries its code); target, faustx-zj5.54: `NAME_IS_INSTANCE`, `NAME_IS_DEFINITION`, `MASTER_WITH_PARAMETER` and `CHANNEL_OUT_OF_RANGE` are produced by their lines; target, faustx-zj5.9: each code of the list is produced by its line with its parameters and its origin, every refusal carries a code of the list, and the graph view after a refused line equals the view before it.

## 6. `write`

`write` returns the whole Faust program of the graph at this instant: the library import, one definition per instance in the flow, and `process`. As soon as one instance feeds more than one destination, the program is written in stages. An empty graph gives a valid program that outputs silence.

**Guard** — `tests/unit/transpiler.test.js` (the pieces compile; an emptied graph stays a valid, silent program; a shared signal is written only once); `tests/unit/references.test.js` (each piece of `examples/` and each example block of `LANGUAGE.md` gives the results and the program engraved under `tests/references/`).

## 7. `graph`

```ts
export interface GraphView {
  readonly instances: readonly InstanceView[]
  readonly wires: readonly WireView[]
}

export interface InstanceView {
  readonly name: string
  readonly body: string
  readonly settings: Readonly<Record<string, string>>
  readonly bypassed: boolean
  readonly removed: boolean
  readonly computed: boolean
}

export interface WireView {
  readonly from: WireEnd
  readonly to: WireEnd
  readonly width: number | null
  readonly loop: boolean
}

export interface WireEnd {
  readonly name: string
  readonly port: string | null
  readonly channel: number | null
}
```

`graph` returns a copy of the graph at the instant of the call, frozen in depth: a later `apply` does not change it, and writing into it throws without reaching the graph. Instances come in the order they were placed, wires in the order they were laid. `body` is the name of the module the body calls, or the Faust expression of the body as written; its settings are in `settings`. `removed` marks an instance taken out of the flow, whose name stays taken; `computed` marks a computed signal, an instance the session places under a name of its own for an expression such as `lfo1 * 3800 + 400`. A wire end whose `port` is not `null` drives that port of the instance; a wire end whose `channel` is not `null` is that channel of the instance, counted from 1, the first of the range when `width` is not `null`; the master bus is a wire end under its reserved name, `process`. `width` is the number of lanes a wire runs over, copies between two names (`saw1 :8 lpf1`) or consecutive channels after a channel (`src1.1 :4 dst1.1`), `null` when it names none; `loop` marks a feedback wire, whose output returns to the input.

**Guard** — target, faustx-zj5.36: the interface test checks that the view is frozen in depth, that a write into it throws and leaves `write()` unchanged, and that a view taken before a gesture is the same after it.

## 8. `controls`

```ts
export interface Control {
  readonly path: string
  readonly instance: string
  readonly port: string
  readonly min: number
  readonly max: number
  readonly unit: string | null
  readonly start: string
  readonly smoothing: string | null
}
```

`controls` returns the controls of the program `write` returns at the same instant, as one value frozen in depth: for each instance in the flow, in the order instances were placed, its controls in the order its body writes them. A control is a port that has a setting and bounds (`LANGUAGE.md` §3.4). `path` is its control path from the program root, the one a `set` returns; `min` and `max` are the bounds the slider carries; `unit` is the port's `unit` attribute, `null` when it has none; `start` is the value the slider starts at, as written; `smoothing` is the Faust function the program applies to the control's value before the circuit reads it (`si.smoo`), `null` when the value enters as it is. The host scales its values into the bounds and writes them by path; FaustScript scales nothing.

**Guard** — target, faustx-zj5.36: each control a compiled program exposes, read from the compiler's description of its interface, has an entry with the same path and bounds, and no entry lacks its control.

## 9. `catalogue`

```ts
export type Catalogue = Readonly<Record<string, CatalogueModule>>

export interface CatalogueModule {
  readonly name: string
  readonly ports: readonly Port[]
  readonly unavailable: string | null
}

export interface Port {
  readonly name: string
  readonly start: string | null
  readonly min: number | null
  readonly max: number | null
}
```

`catalogue` returns the modules the catalogue declares, each under its Faust name, prefix included (`fi.lowpass`), as one value frozen in depth, the same at each call and for every session. A `Port` is a parameter of the module that carries no nature (a function, a signal): its name, its starting value as written, and its bounds. Each one is a port of the instances whose body calls the module. `unavailable` is the foreign function a module calls that the declared faustwasm does not provide, `null` for a module it compiles; placing a module whose `unavailable` is not `null` is refused (§5).

**Guard** — `tests/unit/graph.test.js` (the catalogue carries every module its header counts); `tests/unit/catalogue-source.test.js` (a module faustwasm refuses is marked with the function it calls); target, faustx-zj5.36: the interface test checks that the value is frozen in depth and that a write into it throws.

## 10. The editor entry

```ts
import type { LRParser } from '@lezer/lr'

export const parser: LRParser
export function diagnose(text: string): readonly Diagnostic[]

export interface Diagnostic {
  readonly range: Range
  readonly severity: 1
  readonly code: RefusalCode
  readonly source: 'faustscript'
  readonly message: string
}

export interface Range {
  readonly start: Position
  readonly end: Position
}

export interface Position {
  readonly line: number
  readonly character: number
}
```

`faustscript/editor` serves an editor. `parser` is the Lezer parser generated from FaustScript's grammar, the one the session reads with: a CodeMirror editor builds its language from it (`LRLanguage.define({ parser })`) and highlights FaustScript by the grammar's node names. `diagnose` applies a text to a new session, as the command line applies a file, and returns one diagnostic per refused line, in the order of the lines: the fault of §5, printed in the form of the Language Server Protocol. `range` is the fault's `origin`, its lines and characters counted from 0 in UTF-16 code units; `severity` is 1, an error; `code` and `message` are the fault's.

**Guard** — target, faustx-zj5.36: the interface test checks the two exports; each refused example of the language reference gives one diagnostic with its code and the range of its fault's origin.

## 11. The command line

```
faustscript <file.fsc> [-o <file.dsp>] [--channels <N>]
faustscript --version
```

The command applies the file to a new session whose master bus has the channels given by `--channels`, 2 when the option is absent, and writes the Faust program to standard output, or to the file given by `-o`. Each refused line goes to standard error as `<file>:<line>:<column>: refused <CODE> — <message>`, the position being the fault's origin, followed by the line. It exits with 0 once the file is read, refused lines included, and with 2 when no file is given or when `--channels` is not a positive integer.

**Guard** — `tests/unit/transpiler.test.js` (the command line translates a file); target, faustx-zj5.54: `--channels` sets the outputs of the program written, 2 by default, and an invalid count exits with 2.
