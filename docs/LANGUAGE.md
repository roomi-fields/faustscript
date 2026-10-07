# FaustX — the language

FaustX is Faust with named instances. A FaustX text is a sequence of lines; each line places an instance, connects instances, sets a port or changes an instance already placed, and the transpiler writes the Faust program that the resulting graph describes. Every Faust program is a FaustX program: FaustX gives a meaning only to writings that Faust refuses. This document is the specification of the language: what it describes exists, and a gap between it and the transpiler is a defect of the transpiler.

## 1. Lines and signs

### 1.1 One line, one statement

A newline ends the statement that precedes it; no writing carries over to the next line. A comment starts with `//` and runs to the end of the line. A text sent while the sound plays is applied to the graph as it stands, and a file is the same sequence of lines applied to an empty graph.

### 1.2 The three decorations

FaustX keeps Faust's signs and qualifies them with three decorations, each with one meaning in every position:

| decoration | meaning | examples |
| --- | --- | --- |
| a `!` in front | cancels the sign it precedes | `!:` `!~` `!let` `!_` |
| a number after | says how many | `:8` `~4` `lpfs:8` |
| a dot | reaches into an instance | `lpf1.fc` `saw1.3` `lpf1.fc.min` |

The colon stuck to a name assigns a value, as in Faust's widget modulation `["fc": 400 -> lpf]`; FaustX writes the target outside the brackets because the instance is already placed and named. The name comes first, its value after.

### 1.3 Spacing

A sign stuck to its neighbour qualifies it; a spaced sign connects. Without this rule, the four writings below would each have two readings.

| stuck | spaced |
| --- | --- |
| `saw1 :8 lpf1` — eight copies | `saw1 : 8` — connects `saw1` to the constant 8 |
| `fc:800` — assigns 800 to the port `fc` | `a : b` — connects `a` to `b` |
| `-55` — a negative number | `a - 5` — subtracts |
| `lpfs:8` — a bank of eight | — |

A gesture sign written before a name is spaced from it: `_lpf1` and `!lpf1` are Faust identifiers, so the bypass is written `_ lpf1` and the removal `! lpf1`. The `!` is stuck only to the sign it cancels: `!:`, `!~`, `!let`, `!_`.

## 2. Placing an instance

### 2.1 `let`

`let` places an instance and names it: the first word is the name, the rest of the line is the body.

```faustx
let lpf1 lowpass                     // one instance, every parameter at its starting value
let lpf2 lowpass(fc:400)             // one parameter given
let lpfs:8 lowpass                   // a bank of eight
let voix:8 sawtooth : lowpass        // eight complete chains
let vca1 *                           // any Faust expression is a body
```

A name is placed once. A second `let` on a placed name is refused, as Faust refuses a second definition of an identifier:

```faustx
let lpf1 lowpass
let lpf1 lowpass                     // refused: ALREADY_PLACED
```

`let` is written at the root of the text. Faust's local scopes — `with{}`, `letrec{}`, `environment{}` — keep their Faust meaning and contain no `let`, because an instance named inside them could not be reached from outside.

### 2.2 A name designates one instance

A name placed by `let` designates one instance; Faust's `=` designates a definition that each use copies. Using a `let` name in two places connects the same circuit twice: the instance sums what enters it and sends its output to every destination, as an effect send does.

```faustx
let voix1 sawtooth
let voix2 sawtooth(freq:165)
let rev1 mono_freeverb
voix1 : rev1                         // both voices enter the same reverb
voix2 : rev1
rev1 : process
```

### 2.3 Banks and the rank `i`

A number stuck to the declared name makes the name designate that many copies of the body: `let lpfs:8 lowpass` is Faust's `par(i, 8, lowpass)`. The number belongs to the name, so a body made of several modules needs no parentheses: `let voix:8 sawtooth : lowpass`. The dot then reaches one copy, counted from 1 (`lpfs.3`), and the name alone reaches all of them.

`i` is the rank of the copy inside a bank, from 0, as in Faust's `par(i, N, …)`. It lets the copies differ; eight identical copies would be reduced by Faust to one circuit.

```faustx
let clic:6 resonbp(fc:311 * 1.5^i, Q:40)     // six resonators, six pitches
let voix:8 sawtooth(freq:110 * (i+1))        // eight harmonics
```

`i` has a meaning only in the body of a bank.

The number of copies is a constant for Faust. A replacement that carries a new number resizes the bank:

```faustx
let lpfs:8 lowpass
lpfs:16 lowpass                      // the bank becomes sixteen filters
```

## 3. Modules

### 3.1 The catalogue

A module is a Faust function that the catalogue declares with the names of its parameters and their starting values. The catalogue, `lib/faust.fx`, declares the 998 public functions of Faust's libraries under Faust's own names, each name once, with bodies that call them by their usual prefixes (`fi.`, `os.`, `re.`…). A module is written by its name alone: `lowpass` is `fi.lowpass`, with its parameters in any order and by name.

### 3.2 Declaring a module

A declaration gives the module's name, its parameters with their starting values, then its body; the lines that follow set the attributes of its parameters.

```faustx
lowpass(N:4, fc:2000)  fi.lowpass(N, fc)
  fc.min:2
  fc.max:8000
  fc.scale:log
  fc.unit:Hz
```

The same word names the parameter in the body, the port of an instance, and the attribute that bounds it. The body is FaustX: it calls the modules already declared by their names, or Faust as it stands.

```faustx
voix(freq:110, fc:800)  sawtooth(freq:freq) : lowpass(fc:fc)
```

### 3.3 A Faust function the catalogue does not declare

A Faust function the catalogue does not declare is called with Faust's own argument order. An argument written `key:value` becomes a port that the author names; Faust's parameter names cannot serve, since they are out of scope at the call site.

```faustx
let lpf1 fi.lowpass(3, cutoff:800)   // Faust's order, a port named cutoff
```

A port named this way cannot bear the name of a placed instance, and the reverse: otherwise placing `let cutoff …` would turn every `cutoff:800` into a connection. This call is the one place where two writings do the same thing; it keeps every Faust function reachable.

### 3.4 Ports

A port is a parameter that the author writes, at placement or later. A parameter that is not written stays a constant, which Faust precomputes; a control costs computation, so one names what one controls.

A port whose bounds are known becomes a control, a slider between those bounds. The bounds come from the catalogue, or from `min` and `max` written on the instance. A port without bounds stays a constant: FaustX guesses no range, and the author gives `min` and `max` to make the port controllable.

Setting a port that is still a constant recompiles the instance, so that the control exists.

The attributes are the ones Faust reads between brackets in a control's label: `min`, `max`, `scale`, `unit`, `style`, `midi`, `osc`. FaustX passes the word through to Faust.

## 4. Connecting

### 4.1 Wires

```faustx
let saw1 sawtooth
let lpf1 lowpass
saw1 : lpf1                          // connects
saw1 !: lpf1                         // cuts
saw1 :8 lpf1                         // connects as eight copies
```

`saw1 :8 lpf1` is Faust's `par(i, 8, saw1) : par(i, 8, lpf1)`: it repeats the circuit, and declares no name. A number after the colon means eight times, whether it is stuck to a declared name or between two names.

A line sent alone adds its wires to the graph: `voix2 : rev1` adds one branch and leaves the others. Faust's `,` stacks two circuits that keep their own inputs and outputs, and stays available inside an expression; the studio's parallel, Faust's `A <: (X, Y) :> B`, is what two wires to one instance write.

| Faust's sign | what it does | in FaustX |
| --- | --- | --- |
| `:` | series | `:8` copies, `!:` cuts, and widths adapt (§4.2) |
| `,` | stacks | unchanged |
| `<:` | splits | written by connecting one instance to several |
| `:>` | merges | written by connecting several instances to one |
| `~` | feeds back | `~4` channels returned, `!~` opens (§4.4) |

### 4.2 Widths adapt

A wire between two widths that Faust's `:` would refuse is written as the routing that fits:

| what arrives | what happens |
| --- | --- |
| one channel into several | it is sent to all of them |
| several channels into a module's input | they are summed |
| several channels into a named port | the first channel is taken |
| widths with no whole ratio | the destination takes the number of channels it accepts |

The dot tells the two middle cases apart: a module's input carries audio, which is summed; a named port carries a control, which takes one value. Several wires into one port are summed, as an effect send sums its sources.

### 4.3 A cut wire carries silence

Cutting a wire leaves the destination's width unchanged: the input that the wire fed receives zero. In the example below, `basse !: vcab` silences the bass branch; the other branch is not sent into the freed input.

```faustx
let basse sawtooth(freq:55)
let nappe sawtooth(freq:220)
let vcab si.bus(2) :> _
basse : vcab
nappe : vcab
vcab : process
basse !: vcab
```

### 4.4 Feedback

`~` puts an instance's output back into its input, with the one-sample delay that Faust places.

```faustx
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

## 5. Changing a placed instance

```faustx
let lpf1 lowpass
lpf1 lowpass(fc:400)                 // replaces its body
_ lpf1                               // bypasses it
!_ lpf1                              // puts it back in the flow
! lpf1                               // removes it from the flow, with its wires
!let lpf1                            // gives its name back
```

A placed name followed by a body replaces the body; the instance and its other settings stay. What becomes of the running circuit's state belongs to the host, which substitutes the compiled instance. `let` places, the name alone replaces. The body of a replacement starts with a name: `vca1 *` would read as an unfinished multiplication, so a replacement by an operator goes through a declared module.

Replacing a body changes the circuit; a bypass leaves the body and changes the instance's place in the flow: the bypassed instance receives silence, the signal passes around it, and its output stays summed in, so what rings inside it runs out. Faust's `ba.bypass_fade` clears the module's state instead.

`! lpf1` takes the instance out of the flow with all its wires; the name stays placed, and nothing enters it, so its tail runs out. `!let lpf1` deletes the instance and its wires and frees the name. When an instance or a loop leaves the program — `!let`, `!~` — the host decides how its sound ends.

Two ways to start again, and the author chooses:

```faustx
let rev1 mono_freeverb
rev1 mono_freeverb(damp:0.9)         // the same instance, with its settings
!let rev1
let rev1 mono_freeverb(damp:0.9)     // a new instance, from the module's starting values
```

## 6. Settings

```faustx
let lpf1 lowpass(fc:800)
let lfo1 osc(freq:0.2)
lpf1.fc:400                          // one port
lpf1(fc:400, N:5)                    // several at once
lpf1.fc.min:20                       // an attribute of the port
lfo1 : lpf1.fc                       // a signal drives the port
```

The dot sets one port, the parentheses several. A port's attributes are reached the same way. What is written on the instance overrides what the catalogue gives the module.

A signal connected to a port is rescaled from the range of the module that emits it to the bounds of the port, with Faust's `it.remap`: an `osc` from -1 to 1 sweeps `lpf1.fc` from 2 to 8000 Hz. When either range is unknown, the signal passes as it is, and the author writes the rescaling:

```faustx
let lfo1 osc(freq:0.2)
let lpf1 lowpass(fc:800)
lfo1 : it.remap(-1, 1, 140, 900) : lpf1.fc
```

A port is driven by a signal, never by one of the program's inputs:

```faustx
let micro _
let lpf1 lowpass(fc:800)
micro : lpf1.fc                      // refused: SETTING_FROM_INPUT
```

## 7. Channels

A dot followed by a number designates a channel, counted from 1 as Faust's `route` counts them. FaustX writes the `route` that carries only the channels named.

```faustx
let src1 si.bus(4)
let dst1 si.bus(8)
let lpfs:8 lowpass
src1.3 : dst1.5                      // channel 3 into channel 5
lpfs.3.fc:400                        // the third filter of the bank
```

In a bank of one-channel modules, the channel is the module: `lpfs.3` is the third filter.

## 8. The sink and the inputs

`process` is the sink: what arrives there is the program's output. It is Faust's own name; FaustX writes `process = <what arrives>`, and several wires into it are summed. It has channels like any instance.

```faustx
let saw1 sawtooth
let lpf1 lowpass
let rev1 stereo_freeverb
saw1 : lpf1 : process                // sounds
lpf1 !: process                      // no longer goes out
lpf1 : rev1
rev1.1 : process.1                   // a stereo output
rev1.2 : process.2
```

An input is Faust's wire `_`, written in a chain or placed under a name; both writings are FaustX.

```faustx
let lpf1 lowpass
_ : lpf1 : process                   // the first input through a filter
```

```faustx
let micro _
let lpf1 lowpass
micro : lpf1 : process
micro !: lpf1                        // unplugs the microphone from the filter
```

The order in which the inputs are placed is their order on the program: the first `let … _` is input 1. The number of inputs follows from the circuit, as in Faust.

## 9. Imports

The transpiler imports Faust's standard library and the catalogue into every program: `lowpass` needs no import and no prefix, and `fi.lowpass` stays valid. A Faust program that writes its own imports keeps them.

```faustx
import("mes-modules.fx")             // as in Faust
```

## 10. A refused line

A line that the transpiler refuses changes nothing in the graph, and the lines after it are applied; what plays keeps playing. A line that is accepted and sounds wrong is still accepted: FaustX checks the writing, not the music. The refusals and their codes are listed in `INTERFACE.md` §5.

## 11. Quick reference

| writing | what it does |
| --- | --- |
| `let lpf1 lowpass` | places an instance |
| `let lpfs:8 lowpass` | places a bank of eight |
| `i` | the rank of the copy, in a bank |
| `lpf1 lowpass(fc:400)` | replaces its body |
| `_ lpf1` · `!_ lpf1` | bypasses it · puts it back |
| `! lpf1` | removes it from the flow, with its wires |
| `!let lpf1` | gives its name back |
| `saw1 : lpf1` · `saw1 !: lpf1` | connects · cuts |
| `saw1 :8 lpf1` | connects as eight copies |
| `dly1 ~ fb1` · `dly1 !~ fb1` | feeds back · opens the loop |
| `lpf1.fc:400` · `lpf1(fc:400, N:5)` | sets a port · several |
| `lpf1.fc.min:20` | sets an attribute |
| `saw1.3` | a channel |
| `: process` | the output |
| `_` | an input |
| `name(p:1) body` | declares a module |
