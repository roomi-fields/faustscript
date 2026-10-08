# FaustScript — the language

FaustScript is Faust with named instances. A FaustScript text is a sequence of lines; each line places an instance, connects instances, sets a port, changes an instance already placed, or defines in Faust, and the transpiler writes the Faust program that the resulting graph describes. FaustScript stands to Faust as TypeScript stands to JavaScript: every text that Faust's grammar accepts keeps its Faust meaning, and FaustScript gives a meaning only to writings that Faust's grammar refuses. This document is the specification of the language: what it describes exists, and a gap between it and the transpiler is a defect of the transpiler.

## 1. Lines and signs

### 1.1 Two kinds of line

A line that starts as a Faust definition is Faust up to its `;`, and it may run over several lines: a name or a name with its parameters followed by `=`, an `import(`, a `declare`. Any other line is a FaustScript line — it places, connects, sets or changes an instance — and ends at the newline; the indented lines under a module's declaration belong to it (§3.2). A comment starts with `//` and runs to the end of the line.

```faustscript
gain = 0.5;                          // a Faust definition, up to its ;
voice(f) = os.sawtooth(f)
  : fi.lowpass(2, 800);              // a Faust definition over two lines
let lpf1 fi.lowpass(fc=800)          // a FaustScript line, up to the newline
let = 1;                             // a Faust definition of the identifier let
voix2(f) = os.sawtooth(freq=f) : fi.lowpass(fc=800);  // named settings in a Faust definition
```

A Faust definition gives a module's parameters by name, `freq=f`, as a FaustScript line does: Faust's grammar refuses `=` in a call. The decorations of wiring stay on wiring lines (§4.1).

A Faust definition of a name is the gesture `define`. It gives the name its Faust meaning for the whole text, and each instance whose body cites the name is recompiled with the new definition; a later definition of the same name replaces the earlier one.

```faustscript
gain = 0.5;
let vca1 *(gain)
gain = 0.25;                         // defines gain again: vca1 is recompiled
```

A Faust definition of a placed instance's name is refused: the name designates the instance, which changes through its ports (§6) or a new body (§5).

```faustscript
let hpf1 fi.highpass
hpf1 = 3;                            // refused: NAME_IS_INSTANCE
```

In the same way, a `let` on a name that a Faust definition gives is refused: the name designates the definition.

```faustscript
level = 0.5;
let level os.osc                     // refused: NAME_IS_DEFINITION
```

An `import` or a `declare` line is also the gesture `define`. An import can change the meaning of any name, so every placed instance is recompiled.

A text sent while the sound plays is applied to the graph as it stands, and a file is the same sequence of lines applied to an empty graph.

### 1.2 `=` gives a value, `:` connects

In Faust, `=` gives a name its definition and `:` connects one circuit to the next. FaustScript keeps both meanings and writes `=` where Faust's grammar refuses it, to give a value to a port, an attribute or a parameter:

| writing | gives a value to |
| --- | --- |
| `lpf1.fc = 400` | a port (§6) |
| `lpf1.fc.min = 20` | an attribute of a port (§6) |
| `fi.lowpass(fc=800)` | a parameter, in a call (§3.1) |
| `fi.lowpass(N=4, fc=2000)` | a parameter's starting value, in a declaration (§3.2) |

The name comes first, its value after. The `:` only connects, and its decorations qualify the connection.

### 1.3 The three decorations

FaustScript qualifies Faust's signs with three decorations, each with one meaning in every position:

| decoration | meaning | examples |
| --- | --- | --- |
| a `!` in front | cancels the sign it precedes | `!:` `!~` `!let` `!_` |
| a number after | says how many | `:8` `~4` `lpfs:8` |
| a dot | reaches into an instance | `lpf1.fc` `saw1.3` `lpf1.fc.min` |

### 1.4 Spaces

Spaces separate words as in Faust, and a FaustScript sign is read by its place in the line. Two writings are fixed: `_lpf1` is one Faust identifier, so the bypass is written `_ lpf1`; the `!` that cancels a sign is stuck to it: `!:`, `!~`, `!let`, `!_`.

On a wiring line, a number after `:`, stuck or spaced, says over how many lanes the wire runs: copies, or channels (§4.1). A negative number is written as in Faust, a `-` before the number, wherever Faust accepts a number.

```faustscript
let saw1 os.sawtooth
let lpf1 fi.lowpass
saw1 : 8 lpf1                        // eight copies, as saw1 :8 lpf1
let gate1 ef.gate_mono(thresh=-40)   // a negative number, in a named setting
let gate2 ef.gate_mono(-40, 0.001, 0.1, 0.05)  // a negative number, in Faust's order
```

## 2. Placing an instance

### 2.1 `let`

`let` places an instance and names it: the first word is the name, the rest of the line is the body.

```faustscript
let lpf1 fi.lowpass                  // one instance, every parameter at its starting value
let lpf2 fi.lowpass(fc=400)          // one parameter given
let lpfs:8 fi.lowpass                // a bank of eight
let voix:8 os.sawtooth : fi.lowpass  // eight complete chains
let vca1 *                           // any Faust expression is a body
```

The body is Faust: `:` and `~` keep their Faust meaning in it, and FaustScript decorates only the calls to modules (§3.1). A repetition inside a body is written as Faust writes it, `par(i, 8, …)`.

`let` is a FaustScript word at the start of a line followed by a name. Elsewhere it is an ordinary Faust identifier, and `let = 1;` is a Faust definition (§1.1).

A name is placed once. A second `let` on a placed name is refused, as Faust refuses a second definition of an identifier:

```faustscript
let lpf1 fi.lowpass
let lpf1 fi.lowpass                  // refused: ALREADY_PLACED
```

`let` is written at the root of the text. Faust's local scopes — `with{}`, `letrec{}`, `environment{}` — keep their Faust meaning and contain no `let`, because an instance named inside them could not be reached from outside.

### 2.2 A name designates one instance

A name placed by `let` designates one instance; Faust's `=` designates a definition that each use copies. Using a `let` name in two places connects the same circuit twice: the instance sums what enters it and sends its output to every destination, as an effect send does.

```faustscript
let voix1 os.sawtooth
let voix2 os.sawtooth(freq=165)
let rev1 re.mono_freeverb
voix1 : rev1                         // both voices enter the same reverb
voix2 : rev1
rev1 : process
```

### 2.3 Banks and the rank `i`

A number after the declared name makes the name designate that many copies of the body: `let lpfs:8 fi.lowpass` is Faust's `par(i, 8, fi.lowpass)`. The number belongs to the name, so a body made of several modules needs no parentheses: `let voix:8 os.sawtooth : fi.lowpass`. The dot then reaches one copy, counted from 1 (`lpfs.3`), and the name alone reaches all of them.

`i` is the rank of the copy inside a bank, from 0, as in Faust's `par(i, N, …)`. It lets the copies differ; eight identical copies would be reduced by Faust to one circuit.

```faustscript
let clic:6 fi.resonbp(fc=311 * 1.5^i, Q=40)  // six resonators, six pitches
let voix:8 os.sawtooth(freq=110 * (i+1))     // eight harmonics
```

`i` has a meaning only in the body of a bank.

The number of copies is a constant for Faust. A placed name followed by a number, alone on its line, gives the instance that many copies of its body; its body, its wires and its settings stay. An instance placed without a number has one copy, and the same line makes it a bank. A new body keeps the number of copies (§5).

```faustscript
let lpfs:8 fi.lowpass(fc=800)
lpfs:16                              // the bank becomes sixteen filters
lpfs fi.highpass                     // sixteen high-pass filters, fc stays 800
let hpf2 fi.highpass
hpf2:4                               // hpf2 becomes a bank of four
```

A number between two names is always a wire: `lpfs:16 lpf2` connects `lpfs` to `lpf2` as sixteen copies (§4.1).

## 3. Modules

### 3.1 The catalogue

A module is a Faust function that the catalogue declares with the names of its parameters and their starting values. The catalogue, `lib/faust.fsc`, declares the public functions of Faust's libraries under Faust's own names, prefix included: `fi.lowpass`, `os.osc`, `re.mono_freeverb`. Two libraries that define the same name give two modules, `ma.SR` and `pl.SR`, and a new version of a library adds a module without changing the meaning of a name already written.

A module is written as Faust writes the function, and FaustScript decorates the call: `fi.lowpass(fc=800)` gives its parameters by name, in any order. The name without its prefix designates no module, and the refusal names the modules whose name it ends:

```faustscript
let lpf1 lowpass                     // refused: UNKNOWN_NAME
```

### 3.2 Declaring a module

A declaration gives the module's name, its parameters with their starting values, then its body; the lines that follow set the attributes of its parameters.

```faustscript
fi.lowpass(N=4, fc=2000)  fi.lowpass(N, fc)
  fc.min = 2
  fc.max = 8000
  fc.scale = log
  fc.unit = Hz
```

The same word names the parameter in the body, the port of an instance, and the attribute that bounds it. The body calls the modules already declared by their names, or Faust as it stands.

```faustscript
voix(freq=110, fc=800)  os.sawtooth(freq=freq) : fi.lowpass(fc=fc)
```

### 3.3 A call in Faust's order

A call that passes an argument without its name is written in Faust's argument order and keeps Faust's meaning: `fi.lowpass(3, 800)` is Faust's call. A Faust function the catalogue does not declare is called this way. In such a call, an argument written `key=value` becomes a port that the author names; Faust's parameter names cannot serve, since they are out of scope at the call site.

```faustscript
let lpf1 fi.lowpass(3, cutoff=800)   // Faust's order, a port named cutoff
```

### 3.4 Ports

A port is what a setting or a wire targets on an instance, by its name after the dot: each parameter of the instance's module that carries no nature, or each `key=value` the author named in a call in Faust's order (§3.3). A port that is not written stays a constant, which Faust precomputes; a control costs computation, so one names what one controls.

A port that is written and whose bounds are known becomes a control, a slider between those bounds. The bounds come from the catalogue, or from `min` and `max` written on the instance. A port without bounds stays a constant: FaustScript guesses no range, and the author gives `min` and `max` to make the port controllable.

Setting a port that is still a constant recompiles the instance, so that the control exists.

A parameter that Faust requires constant when it compiles — a filter's order `N`, a delay's size `n` — is marked constant by the catalogue. Setting it recompiles the instance with the new value, and it never becomes a control:

```faustscript
let lpf1 fi.lowpass
lpf1.N = 5                           // recompiles lpf1 as a filter of order 5
```

The attributes are the ones Faust reads between brackets in a control's label: `min`, `max`, `scale`, `unit`, `style`, `midi`, `osc`. FaustScript passes the word through to Faust.

## 4. Connecting

### 4.1 Wires

A wiring line connects placed instances. It is written at the root of the text, where Faust's grammar refuses a bare expression; on it, `:`, `!:`, `:8`, `~`, `~4`, `!~` and a port as target are FaustScript's. Inside a body (§2.1) and inside a Faust definition (§1.1), `:` and `~` keep their Faust meaning.

```faustscript
let saw1 os.sawtooth
let lpf1 fi.lowpass
saw1 : lpf1                          // connects
saw1 !: lpf1                         // cuts
saw1 :8 lpf1                         // connects as eight copies
```

A number after the colon, stuck or spaced, says over how many lanes the wire runs. Between two names, a lane is a copy: `saw1 :8 lpf1` is Faust's `par(i, 8, saw1) : par(i, 8, lpf1)`, it repeats the circuit and declares no name. After a channel, a lane is a channel, and the wire carries that many consecutive channels (§7).

A line sent alone adds its wires to the graph: `voix2 : rev1` adds one branch and leaves the others. Faust's `,` stacks two circuits that keep their own inputs and outputs, and stays available inside an expression; the studio's parallel, Faust's `A <: (X, Y) :> B`, is what two wires to one instance write.

| Faust's sign | what it does | in FaustScript |
| --- | --- | --- |
| `:` | series | `:8` over eight lanes, `!:` cuts, and widths adapt (§4.2) |
| `,` | stacks | unchanged |
| `<:` | splits | written by connecting one instance to several |
| `:>` | merges | written by connecting several instances to one |
| `~` | feeds back | `~4` channels returned, `!~` opens (§4.4) |

### 4.2 Widths adapt

A wire between two widths that Faust's `:` would refuse is written as the routing that fits:

| what arrives | what happens |
| --- | --- |
| one channel into several | it is sent to all of them |
| several channels into an instance's input | they are summed |
| several channels into a named port | the first channel is taken |
| widths with no whole ratio | the destination takes the number of channels it accepts |

The dot tells the two middle cases apart: an instance's input carries audio, which is summed; a named port carries a control, which takes one value. Several wires into one port are summed, as an effect send sums its sources.

### 4.3 A cut wire carries silence

Cutting a wire leaves the destination's width unchanged: the input that the wire fed receives zero. In the example below, `basse !: vcab` silences the bass branch; the other branch is not sent into the freed input.

```faustscript
let basse os.sawtooth(freq=55)
let nappe os.sawtooth(freq=220)
let vcab si.bus(2) :> _
basse : vcab
nappe : vcab
vcab : process
basse !: vcab
```

### 4.4 Feedback

`~` puts an instance's output back into its input, with the one-sample delay that Faust places.

```faustscript
let dly1 de.delay(4096, 1000)
let fb1 _ * 0.5
dly1 ~ fb1                           // closes the loop
dly1 !~ fb1                          // opens it
dly1 ~4 fb1                          // four channels return, the others stay free
```

The number says how many channels return; the inputs that receive no return stay inputs of the circuit.

| Faust | inputs | outputs |
| --- | --- | --- |
| `par(i,8,+) ~ par(i,8,_)` — eight return | 8 | 8 |
| `par(i,8,+) ~ par(i,4,_)` — four return | 12 | 8 |
| `par(i,8,+) ~ _` — one returns | 15 | 8 |

A return into an input that already receives a wire is summed with that wire, as several wires into one input are summed (§4.2): with `src1 : dly1`, the loop `dly1 ~ fb1` is Faust's `(+ : dly1) ~ fb1`, fed by `src1`.

```faustscript
let src1 os.sawtooth
let dly1 de.delay(4096, 1000)
let fb1 _ * 0.5
src1 : dly1
dly1 ~ fb1                           // the return is summed with src1
dly1 : process
```

## 5. Changing a placed instance

```faustscript
let lpf1 fi.lowpass
lpf1 fi.lowpass(fc=400)              // replaces its body
_ lpf1                               // bypasses it
!_ lpf1                              // puts it back in the flow
! lpf1                               // removes it from the flow, with its wires
!let lpf1                            // gives its name back
```

A placed name followed by a body replaces the body; the instance keeps its name, its wires, its number of copies, and the settings whose port the new body carries. What becomes of the running circuit's state belongs to the host, which substitutes the compiled instance. `let` places, the name alone replaces. The body of a replacement starts with a name: `vca1 *` would read as an unfinished multiplication, so a replacement by an operator goes through a declared module.

Replacing a body changes the circuit; a bypass leaves the body and changes the instance's place in the flow: the bypassed instance receives silence, the signal passes around it, and its output stays summed in, so what rings inside it runs out. Faust's `ba.bypass_fade` clears the module's state instead.

`! lpf1` takes the instance out of the flow with all its wires; the name stays placed, and nothing enters it, so its tail runs out. `!let lpf1` deletes the instance and its wires and frees the name. When an instance or a loop leaves the program — `!let`, `!~` — the host decides how its sound ends.

An instance that no wire touches keeps its name and its definition, which the host can compile alone, and stays out of `process`. Once the loop opens, `fb1` is such an instance:

```faustscript
let dly1 de.delay(4096, 1000)
let fb1 _ * 0.5
dly1 ~ fb1
dly1 : process
dly1 !~ fb1                          // fb1 stays placed, out of process
```

Two ways to start again, and the author chooses:

```faustscript
let rev1 re.mono_freeverb
rev1 re.mono_freeverb(damp=0.9)      // the same instance, with its settings
!let rev1
let rev1 re.mono_freeverb(damp=0.9)  // a new instance, from the module's starting values
```

## 6. Settings

```faustscript
let lpf1 fi.lowpass(fc=800)
let lfo1 os.osc(freq=0.2)
lpf1.fc = 400                        // one port
lpf1(fc=400, N=5)                    // several at once
lpf1.fc.min = 20                     // an attribute of the port
lfo1 : lpf1.fc                       // a signal drives the port
```

The dot sets one port, the parentheses several. A port's attributes are reached the same way. What is written on the instance overrides what the catalogue gives the module.

A signal connected to a port is rescaled from the range of the module that emits it to the bounds of the port, with Faust's `it.remap`: an `os.osc` from -1 to 1 sweeps `lpf1.fc` from 2 to 8000 Hz. When either range is unknown, the signal passes as it is, and the author writes the rescaling:

```faustscript
let lfo1 os.osc(freq=0.2)
let lpf1 fi.lowpass(fc=800)
lfo1 : it.remap(-1, 1, 140, 900) : lpf1.fc
```

A port is driven by a signal, never by one of the program's inputs:

```faustscript
let micro _
let lpf1 fi.lowpass(fc=800)
micro : lpf1.fc                      // refused: SETTING_FROM_INPUT
```

## 7. Channels

A dot followed by a number designates a channel, counted from 1 as Faust's `route` counts them. FaustScript writes the `route` that carries only the channels named.

```faustscript
let src1 si.bus(4)
let dst1 si.bus(8)
let lpfs:8 fi.lowpass
src1.3 : dst1.5                      // channel 3 into channel 5
lpfs.3.fc = 400                      // the third filter of the bank
```

In a bank of one-channel bodies, the channel is the copy: `lpfs.3` is the third filter.

A number after the colon that follows a channel carries that many consecutive channels, from the channel named on each side: `src1.1 :4 dst1.1` routes channels 1 to 4 of `src1` into channels 1 to 4 of `dst1`. One source is split into several destinations by one line per range.

```faustscript
let src1 si.bus(7)
let dst1 si.bus(4)
let lpf1 fi.lowpass
let dst2 si.bus(2)
src1.1 :4 dst1.1                     // channels 1 to 4 into channels 1 to 4 of dst1
src1.5 : lpf1                        // channel 5 into lpf1
src1.6 :2 dst2.1                     // channels 6 and 7 into channels 1 and 2 of dst2
```

A range that runs past the last channel of its source or of its destination is refused, and the line changes nothing:

```faustscript
let src2 si.bus(3)
let dst3 si.bus(4)
src2.2 :4 dst3.1                     // refused: CHANNEL_OUT_OF_RANGE
```

## 8. The master bus and the inputs

`process` is the master bus: it mixes the sources that arrive there into the program's output. It is Faust's own name; FaustScript writes `process = <what arrives>`, and several sources into it are summed. Its number of channels is fixed by the host when it creates the session, and each source adapts to it by §4.2: a one-channel source is sent to every channel, a source as wide as the master bus enters channel by channel. A dot reaches one of its channels, as on any instance. The examples of this document play on a master bus of two channels.

```faustscript
let saw1 os.sawtooth
let lpf1 fi.lowpass
let rev1 re.stereo_freeverb
saw1 : lpf1 : process                // sounds
lpf1 !: process                      // no longer goes out
lpf1 : rev1
rev1.1 : process.1                   // a stereo output
rev1.2 : process.2
```

A Faust definition of `process` is one more source into the master bus, summed with the wires into `process`. Defining it again replaces that definition and leaves the wires.

```faustscript
let saw1 os.sawtooth
saw1 : process
process = no.noise * 0.1;            // the noise is summed with saw1
process = no.noise * 0.05;           // replaces the noise, saw1 stays
```

The master bus takes no parameter: a Faust definition that gives `process` parameters is refused.

```faustscript
process(x) = x * 0.5;                // refused: MASTER_WITH_PARAMETER
```

An input is Faust's wire `_`, written in a chain or placed under a name; both writings are FaustScript.

```faustscript
let lpf1 fi.lowpass
_ : lpf1 : process                   // the first input through a filter
```

```faustscript
let micro _
let lpf1 fi.lowpass
micro : lpf1 : process
micro !: lpf1                        // unplugs the microphone from the filter
```

The order in which the inputs are placed is their order on the program: the first `let … _` is input 1. The number of inputs follows from the circuit, as in Faust.

## 9. Imports

The transpiler imports Faust's standard library and the catalogue into every program: `fi.lowpass` needs no import. A Faust program that writes its own imports keeps them.

```faustscript
import("mes-modules.fsc");           // as in Faust
```

## 10. A refused line

A line that the transpiler refuses changes nothing in the graph, and the lines after it are applied; what plays keeps playing. A line that is accepted and sounds wrong is still accepted: FaustScript checks the writing, not the music. The refusals and their codes are listed in `packages/040-faustscript/docs/INTERFACE.md` §5.

## 11. Quick reference

| writing | what it does |
| --- | --- |
| `name = expr;` | defines in Faust, up to the `;` |
| `let lpf1 fi.lowpass` | places an instance |
| `let lpfs:8 fi.lowpass` | places a bank of eight |
| `lpfs:16` | resizes the bank to sixteen |
| `i` | the rank of the copy, in a bank |
| `lpf1 fi.lowpass(fc=400)` | replaces its body |
| `_ lpf1` · `!_ lpf1` | bypasses it · puts it back |
| `! lpf1` | removes it from the flow, with its wires |
| `!let lpf1` | gives its name back |
| `saw1 : lpf1` · `saw1 !: lpf1` | connects · cuts |
| `saw1 :8 lpf1` | connects as eight copies |
| `dly1 ~ fb1` · `dly1 !~ fb1` | feeds back · opens the loop |
| `lpf1.fc = 400` · `lpf1(fc=400, N=5)` | sets a port · several |
| `lpf1.fc.min = 20` | sets an attribute |
| `saw1.3` | a channel |
| `src1.1 :4 dst1.1` | four consecutive channels |
| `: process` | into the master bus |
| `process = expr;` | one more source into the master bus |
| `_` | an input |
| `name(p=1) body` | declares a module |
