# FaustX — the vocabulary

This file defines the words of FaustX: the language, and the transpiler that reads it and writes Faust. Each definition sums up what `docs/LANGUAGE.md` says of the language and what `docs/INTERFACE.md` says of the transpiler's boundary; on a gap, those two documents decide. A word whose definition changes here changes code.

## 1. The language

- **FaustX** — a superset of Faust for live coding: Faust plus named instances that a text places, connects, sets and changes while the sound plays. Every Faust program is a FaustX program, with its Faust meaning.
- **Line** — the unit of a FaustX text: one statement, ended by a newline. The transpiler applies each line on its own, in order.
- **Decoration** — one of the three marks FaustX adds to a Faust sign: a `!` in front cancels it (`!:`, `!let`, `!_`), a number after says how many (`:8`, `~4`), a dot reaches into an instance (`lpf1.fc`, `saw1.3`). A decoration has one meaning in every position.
- **Module** — a Faust function that the catalogue declares, or that a declaration in the text declares (`lowpass(N:4, fc:2000) fi.lowpass(N, fc)`), with the names of its parameters and their starting values. A module is written by its name alone: `lowpass` is `fi.lowpass`.
- **Parameter** — a named argument of a module, with its starting value and, through its attributes, its bounds. A parameter that carries a nature (a function, a signal) is part of the module's structure and never a port.
- **Instance** — a circuit that `let` places in the graph under a name: `let lpf1 lowpass`. A name designates one instance: using it in two places connects the same circuit twice, which sums what enters it and sends its output to each destination.
- **Body** — what an instance computes: a module with its settings (`lowpass(fc:400)`), or any Faust expression (`*`, `fi.lowpass(3, cutoff:800)`). A replacement gives an instance a new body and keeps its other settings.
- **Bank** — an instance whose name carries a number of copies of its body: `let lpfs:8 lowpass` is Faust's `par(i, 8, lowpass)`. `lpfs.3` reaches the third copy, and **`i`** is the rank of a copy inside the body, from 0.
- **Port** — what a setting or a wire targets on an instance, by its name after the dot: each parameter of the instance's module that carries no nature, or each `key:value` the author named in a Faust body (`cutoff` in `fi.lowpass(3, cutoff:800)`). A line that targets any other name is refused.
- **Setting** — a value written on a port: in the parentheses of a body (`lowpass(fc:800)`), or by a later line (`lpf1.fc:400`, `lpf1(fc:400, N:5)`). The instance keeps its settings, and they override the module's starting values.
- **Attribute** — a word that qualifies a port, as Faust reads it between brackets in a control's label: `min`, `max`, `scale`, `unit`, `style`, `midi`, `osc`. It is written under a module's declaration (`fc.min:2`) or on an instance (`lpf1.fc.min:20`).
- **Control** — a port that has a setting and known bounds, written in Faust as a slider between those bounds. A parameter that is not set, or a port without bounds, stays a constant, which Faust precomputes.
- **Wire** — a connection from one instance's output to another instance, to one of its ports, or to the sink: `saw1 : lpf1` lays it, `saw1 !: lpf1` cuts it, and a cut wire leaves the destination's width unchanged and feeds it silence. A wire into a port drives that port with a signal. A wire can place copies (`saw1 :8 lpf1`), and a **loop** wire returns an output to an input (`dly1 ~ fb1`).
- **Channel** — one signal of an instance's outputs or inputs, reached by a dot and a number counted from 1, as Faust's `route` counts them: `src1.3 : dst1.5`.
- **Sink** — `process`, the reserved name where the program's output arrives; wires into it are summed, and it has channels like any instance.
- **Input** — one of the program's inputs, Faust's wire `_`, written in a chain or placed under a name (`let micro _`). The order in which inputs are placed is their order on the program. An input never drives a port.
- **Computed signal** — an instance the transpiler places under a name of its own for an expression in a chain that is neither a name nor a module, such as `lfo1 * 3800 + 400`.

## 2. The transpiler

- **Transpiler** — the object `createTranspiler` returns: it holds one graph, applies FaustX text to it, and writes the Faust program it describes. Two transpilers share no state.
- **Graph** — the state of a piece: the instances in the order they were placed, with their bodies, settings and marks, and the wires in the order they were laid. A line is the only way to change it; the host reads it as a frozen view.
- **Gesture** — what a line does to the graph, one of seven: `place` (`let`), `replace` (a placed name followed by a body), `release` (`!let`: the instance goes, its name becomes free), `remove` (`! lpf1`: the instance leaves the flow with its wires, its name stays taken), `bypass`, `set` (a setting), `wire` (lays or cuts wires). The gesture tells the host what it has to compile.
- **Bypass** — the gesture `_ lpf1`, and the mark it leaves on the instance: the instance receives silence, the signal passes around it, and its output stays summed in, so what rings inside it runs out. `!_ lpf1` puts the instance back in the flow.
- **Refusal** — the outcome of a line the transpiler does not apply: a stable code from a closed list, and a sentence that names the cause and the name involved. A refused line leaves the graph as it was, and the lines after it apply. An error the Faust compiler raises stays the compiler's message.
- **Control path** — the address of a control in the compiled program, from the program root: an instance is written as a Faust group named after it, so `lpf1.fc:400` returns `/lpf1/fc`. The host writes a setting's value at that path without compiling.
- **Stages** — the form of the program once an instance feeds more than one destination: each shared signal is written once and its destinations read it.
- **Catalogue** — `lib/faust.fx`, the declaration of the 998 public functions of Faust's libraries as modules, under Faust's own names, with their parameters, starting values and bounds. `tools/` generates it from Faust's libraries; the transpiler exposes it as a frozen value.
- **Template** — an entry of `lib/translation.fx` that gives the Faust text a form of the language becomes, with its places between braces (`template.Series {a} : {b}`). The same file declares the words the language reserves: the sink, the rank `i`, the input `_`. The code reads these files and writes no sign of the language.
- **Host** — the program that creates a transpiler, sends it text, compiles the Faust it returns and plays it. The output, musical time, scenes and what becomes of a running circuit's state belong to the host.
