# FaustX — interface

FaustX exports one function, `createTranspiler`, which returns a transpiler holding one graph of instances and wires. The host sends FaustX text to the transpiler's `apply`, which applies each line as a gesture on the graph and returns what each line did; it reads the Faust program, a frozen view of the graph and the catalogue from three other methods. This document lists each element that crosses that boundary: its form, what it returns, what it refuses, and the guard that holds it.

## 1. The package

| specifier | content |
| --- | --- |
| `faustx` | `createTranspiler` and the types of this document |
| `faustx/lib/faust.fx` | the text of the catalogue |
| `faustx/lib/translation.fx` | the text of the templates |
| command `faustx` | the command line (§9) |

Every name, field, gesture, code and sentence form of this document is a contract: changing one is a breaking change, recorded in `CHANGELOG.md` under *Changed*.

**Guard** — the interface test (target, faustx-zj5.10): the package exports exactly the elements of this list, and their declared types are the signatures of this document.

## 2. `createTranspiler`

```ts
export function createTranspiler(catalogueText: string, templatesText: string): Transpiler
```

It receives the text of `lib/faust.fx` and the text of `lib/translation.fx`, and returns a transpiler whose graph is empty. Two transpilers share no state: the same text, applied to each in the same order of gestures, returns the same results, to the character. It throws an `Error` whose message is `template missing: <key>` when the templates text lacks a key the transpiler reads; that error belongs to the files, never to a line.

**Guard** — `tests/unit/parsing.test.js` (the catalogue parses in full); target, without a ticket yet: two transpilers given the same text return equal results.

## 3. The transpiler

```ts
export interface Transpiler {
  apply(text: string): readonly LineResult[]
  write(): string
  graph(): GraphView
  catalogue(): Catalogue
}
```

`apply` is the only method that changes the graph. `write`, `graph` and `catalogue` read it and change nothing.

## 4. `apply` and the result of a line

`apply` receives FaustX text, one or more lines, as the author wrote it. It applies the lines in order and returns one result per line, in the same order. A result describes its line at the moment it was applied: a later line of the same text that releases the instance does not change it.

```ts
export type Gesture = 'place' | 'replace' | 'release' | 'remove' | 'bypass' | 'set' | 'wire'

export interface LineResult {
  readonly line: number
  readonly text: string
  readonly gesture: Gesture | null
  readonly name: string | null
  readonly outcome: Outcome
  readonly faust?: string
  readonly needs?: readonly string[]
  readonly port?: string
  readonly value?: string
  readonly path?: string
}

export type Outcome =
  | { readonly done: true }
  | { readonly done: false; readonly code: RefusalCode; readonly reason: string }
```

| field | content |
| --- | --- |
| `line` | the line's number in the text passed to `apply`, from 1 |
| `text` | the line, without its surrounding spaces |
| `gesture` | the gesture the line expresses; `null` when the line has no form the grammar reads |
| `name` | the instance the gesture touches; `null` for a wire |
| `outcome` | applied, or refused with its code and its sentence (§5) |
| `faust`, `needs` | present when a `place`, `replace`, `bypass` or `remove` is applied: the Faust definition of that instance alone, and the other instances that definition cites, which the host compiles with it |
| `port`, `value`, `path` | present when a `set` is applied: the port, the value as written, and the control path from the program root |

The gesture says what the line does to the graph, and what the host has to compile:

| gesture | line | effect on the graph | returns |
| --- | --- | --- | --- |
| `place` | `let lpf1 lowpass(fc:800)` | adds the instance `lpf1` | `faust`, `needs` |
| `replace` | `lpf1 lowpass(fc:400)` | replaces the body of `lpf1`; its other settings stay | `faust`, `needs` |
| `release` | `!let lpf1` | deletes `lpf1` and its wires; the name becomes free | — |
| `remove` | `! lpf1` | takes `lpf1` and its wires out of the flow; the name stays taken | `faust`, `needs` |
| `bypass` | `_ lpf1`, `!_ lpf1` | lets the signal through `lpf1`, or puts `lpf1` back | `faust`, `needs` |
| `set` | `lpf1.fc:400` | records the value of the port `fc` | `port`, `value`, `path` |
| `wire` | `osc1 : lpf1`, `osc1 !: lpf1` | adds or cuts wires | — |

**The ports of an instance.** An instance whose body is a module carries the parameters of that module that carry no nature (§8). An instance whose body is a Faust expression carries the ports its author named in that body: `let lpf1 fi.lowpass(3, cutoff:800)` carries the port `cutoff`. A setting or a wire that targets any other port is refused (§5).

**The control path.** An instance becomes a Faust group named after it, and a control a slider inside that group: `let lpf1 lowpass(fc:800)` writes `lpf1 = vgroup("lpf1", fi.lowpass(4, hslider("fc…", 800, 2, 8000, …)));`, and `lpf1.fc:400` returns the path `/lpf1/fc`. A `set` compiles nothing: the host writes the value on the running circuit at that path. The prefix that a compiled program adds above the program root is the host's.

**Guard** — `tests/unit/transpiler.test.js` (each gesture says what it touched, and what has to be recompiled; a module driven by another names what it needs); target, faustx-zj5.9: a `set` returns its port, its value and its path; target, faustx-zj5.10: the interface test.

## 5. Refusals

A refused line changes nothing in the graph, and the lines after it are applied. Its outcome carries a code from the closed list below, and a sentence that names the cause and the name involved. The code is what the host acts on; the sentence is what the author reads.

```ts
export type RefusalCode =
  | 'UNREADABLE'
  | 'EMPTY_LINE'
  | 'EMPTY_EXPRESSION'
  | 'UNKNOWN_FORM'
  | 'ALREADY_PLACED'
  | 'UNKNOWN_NAME'
  | 'INCOMPLETE_SETTING'
  | 'SETTING_WITHOUT_PORT'
  | 'UNKNOWN_PORT'
  | 'SETTING_FROM_INPUT'
  | 'NO_SUCH_WIRE'
```

| code | the line | sentence |
| --- | --- | --- |
| `UNREADABLE` | does not read by the grammar | `does not read: <text>` |
| `EMPTY_LINE` | carries no form | `empty line` |
| `EMPTY_EXPRESSION` | an expression with no term | `empty expression` |
| `UNKNOWN_FORM` | a form the grammar reads and no gesture handles | `unknown form: <form>` |
| `ALREADY_PLACED` | `let lpf1 …` when `lpf1` is placed | `lpf1 is already placed` |
| `UNKNOWN_NAME` | names an instance that does not exist, or gives a new body to a name that is not placed | `ghost does not exist` |
| `INCOMPLETE_SETTING` | a setting without its port or its value | `incomplete setting: <text>` |
| `SETTING_WITHOUT_PORT` | `lpf1:3` | `a setting targets a port: lpf1` |
| `UNKNOWN_PORT` | a setting or a wire that targets a port the instance does not carry: `lpf1.nope:3`, `osc1 : lpf1.nope` | `lpf1 has no port nope` |
| `SETTING_FROM_INPUT` | drives a port with a signal that carries a program input | `in1 carries one of the program's inputs: a port is driven by a signal, never by an input` |
| `NO_SUCH_WIRE` | `osc1 !: lpf1` where no wire joins them | `no wire between osc1 and lpf1` |

An error the Faust compiler raises on the Faust that FaustX writes is the compiler's message: the host receives it from the compiler.

**Guard** — `tests/unit/transpiler.test.js` (a faulty line is refused without touching the graph; a port cannot be driven by a program input); target, faustx-zj5.9: each code of the list is produced by its line, every refusal carries a code of the list, and the graph view after a refused line equals the view before it; target, faustx-zj5.7: each refused example of the language reference carries its code.

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
}
```

`graph` returns a copy of the graph at the instant of the call, frozen in depth: a later `apply` does not change it, and writing into it throws without reaching the graph. Instances come in the order they were placed, wires in the order they were laid. `body` is the name of the module the body calls, or the Faust expression of the body as written; its settings are in `settings`. `removed` marks an instance taken out of the flow, whose name stays taken; `computed` marks a computed signal, an instance the transpiler places under a name of its own for an expression such as `lfo1 * 3800 + 400`. A wire end whose `port` is not `null` drives that port of the instance; the sink is a wire end under its reserved name, `process`. `width` is the number of copies a wire places (`saw1 :8 lpf1`), `null` when it places none; `loop` marks a feedback wire, whose output returns to the input.

**Guard** — target, faustx-zj5.10: the interface test checks that the view is frozen in depth, that a write into it throws and leaves `write()` unchanged, and that a view taken before a gesture is the same after it.

## 8. `catalogue`

```ts
export type Catalogue = Readonly<Record<string, CatalogueModule>>

export interface CatalogueModule {
  readonly name: string
  readonly ports: readonly Port[]
}

export interface Port {
  readonly name: string
  readonly start: string | null
  readonly min: number | null
  readonly max: number | null
}
```

`catalogue` returns the 998 modules the catalogue declares, as one value frozen in depth, the same at each call. A `Port` is a parameter of the module that carries no nature (a function, a signal): its name, its starting value as written, and its bounds. Each one is a port of the instances whose body calls the module.

**Guard** — `tests/unit/graph.test.js` (the catalogue carries the 998 Faust modules); target, faustx-zj5.10: the interface test checks that the value is frozen in depth and that a write into it throws.

## 9. The command line

```
faustx <file.fx> [-o <file.dsp>]
faustx --version
```

The command applies the file to an empty graph and writes the Faust program to standard output, or to the file given by `-o`. Each refused line goes to standard error as `<file>:<line>: refused <CODE> — <reason>`, followed by the line. It exits with 0 once the file is read, refused lines included, and with 2 when no file is given.

**Guard** — `tests/unit/transpiler.test.js` (the command line translates a file).
