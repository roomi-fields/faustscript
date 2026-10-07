# FaustX — the language

**Every Faust program is a FaustX program.** This document says how one writes FaustX; it does not say
why the signs are the ones they are, which is the subject of `faustx-specification.md`.

---

## The three rules

The whole language fits in three rules, and there is nothing else to remember.

| rule | example |
| --- | --- |
| **a `!` in front cancels** what it precedes | `!:` `!~` `!let` `! lpf1` |
| **a digit after says how many** | `:8` `~8` `lpfs:8` |
| **the dot reaches into** an instance | `lpf1.cutoff` `saw1.3` |

Two conventions come with them, shared by Faust and by an earlier language of ours: **the dot calls a
component, the colon assigns a value**. And everywhere, **the name comes first, what it is worth
after**.

## Spacing is significant

**Tight, a sign qualifies; spaced, it connects.** This is not a matter of taste: without this rule,
four writings of the language would be ambiguous.

| tight | spaced |
| --- | --- |
| `saw1 :8 lpf1` — eight instances | `saw1 : 8` — connect to the constant 8 |
| `cutoff:800` — assign to the port | `a : b` — connect a to b |
| `-55` — a negative number | `a - 5` — subtract |
| `lpfs:8` — eight instances | — |

**And one line is one statement.** The newline ends what precedes it; no writing carries over to the
next line.

---

## Placing a module

```faustx
let lpf1 lowpass                     // one instance, everything by default
let lpf2 lowpass(cutoff:400)         // one setting given at the start
let lpfs:8 lowpass                   // eight instances
let voix:8 sawtooth : lowpass        // eight complete chains
```

**`let` places an instance and names it.** The first word is the name, all the rest is the body. A
name is declared **only once**: a second `let` on `lpf1` is an error.

**The name designates an instance, not a copy.** Using it in two places connects the same circuit
twice — where Faust's `=` would build two.

```faustx
let rev1 mono_freeverb

voix1 : rev1                         // both voices enter the SAME reverb
voix2 : rev1                         // and ring together inside it
```

**Multiplicity is written on the name.** `lpfs:8` says that this name designates eight of them; the
third is reached by `lpfs.3`, and all of them together by `lpfs`.

**`i` is the rank of the copy**, as in Faust's `par(i,8,…)` — without it the eight instances would be
identical, and Faust would reduce them to a single circuit:

```faustx
let clic:6 resonbp(fc:311 * 1.5^i, Q:60)     // six resonators, six pitches
let voix:8 sawtooth(freq:110 * (i+1))        // eight harmonics
```

`i` is 0 for the first copy. Outside a multiple `let`, it does not exist.

**An instance lives until its name is given back** — see *The gestures*.

---

## Declaring a module

A declared module carries **the names of its parameters and their starting values**. That is what
allows writing `lowpass` without counting arguments.

```faustx
lowpass(order:3, cutoff:800)  fi.lowpass(order, cutoff)
  cutoff.min:20
  cutoff.max:20000
  cutoff.scale:log
  cutoff.unit:Hz
```

**The name, its parameters with their defaults, then the body.** The same words serve inside and
outside: `cutoff` names the parameter in the body, the port in use, and the attribute that sets it.

**The body is FaustX** — so it calls the modules already declared, by their names:

```faustx
voix(freq:110, cutoff:800)  sawtooth(freq:freq) : lowpass(cutoff:cutoff)
```

**The attributes are the ones Faust expects**: `min`, `max`, `scale`, `unit`, `style`, `midi`, `osc`.
FaustX does not know their list — it passes the word through.

**The catalogue declares Faust's 998 functions** (`lib/faust.fx`). A function it does not cover stays
usable through the fallback:

```faustx
let lpf1 fi.lowpass(3, cutoff:800)   // Faust's own order, a port named on the fly
```

---

## Connecting

```faustx
saw1 : lpf1                          // connect
saw1 !: lpf1                         // cut the wire
saw1 :8 lpf1                         // connect as eight instances
```

**Widths adapt; they never stop the music.**

| what arrives | what happens |
| --- | --- |
| one channel into several | it spreads over all of them |
| several channels into a module's input | they sum |
| several channels into a named port | the first one is taken |

**Several wires into one port sum** — that is an effect send, and there is nothing to write for it.

**Cutting a wire puts silence there, not nothing.** The module's width does not change: the cut input
receives zero. That is what makes `basse !: vcab` actually silence the branch, whereas removing the
input would have let the other one spread into it and sound on its own.

**Feeding back** puts a module's output into its input, with the one-sample delay that Faust places
itself:

```faustx
dly1 ~ fb1                           // close the loop
dly1 !~ fb1                          // open it
dly1 ~4 fb1                          // four channels come back, the others stay free
```

---

## The gestures

These are the writings one sends back **while the sound is playing**.

```faustx
lpf1 lowpass(cutoff:400)             // replace its body — its memory stays
_ lpf1                               // bypass it — it stays alive, its tail runs out
!_ lpf1                              // put it back into the flow
! lpf1                               // remove it, and all its wires
!let lpf1                            // give its name back — the tail runs out, then it disappears
```

**The name alone replaces the body; `let` declares.** That is the only difference between the two
lines.

**The body of a replacement begins with a name**, never with an arithmetic sign: `vca1 *` could not
be told apart from an unfinished multiplication. To replace with a multiplication, one goes through a
declared module. The declaration itself has no such constraint — `let vca1 *` can be written, since
the `let` removes all ambiguity.

**`!` also cancels a bypass**: `_ lpf1` short-circuits, `!_ lpf1` undoes that short circuit. It is the
same rule as everywhere — the `!` cancels the sign it precedes.

**`! lpf1` removes the module *and its wires*.** The instance still exists and its name stays taken;
it is simply no longer connected to anything. To give the name back, `!let` is needed.

**Nothing is cut off abruptly.** Bypassing, removing or giving back a module lets whatever was ringing
inside run out: a removed reverb finishes ringing. That is the opposite of Faust's `ba.bypass_fade`,
which clears the module's state.

**Two ways to start afresh**, and the musician chooses:

```faustx
     rev1 mono_freeverb(damp:0.9)    // the tail in progress survives
!let rev1
 let rev1 mono_freeverb(damp:0.9)    // the old one dies away, the new one starts blank
```

---

## Setting

```faustx
lpf1.cutoff:400                      // one control
lpf1(cutoff:400, order:5)            // several at once
lfo1 : lpf1.cutoff                   // have it driven by a signal
```

**A port is set with the dot, several with the parentheses.** A port's name is the one its declaration
gives it.

**A port's attributes are reached the same way**, and are written once and for all:

```faustx
lpf1.cutoff.min:20
lpf1.cutoff.scale:log
```

**Cascading: the most local wins.** What is written on the instance beats what the declaration gives
the module.

**A signal connected to a port is scaled.** The port knows its bounds, and the module that emits knows
its own; FaustX places Faust's `it.remap` between the two:

```faustx
lfo1 : lpf1.cutoff       // an LFO from -1 to 1 sweeps the filter from 20 to 20,000 Hz
```

**If either of the two ranges is unknown, the signal passes through as it is** — nothing is guessed.
One then writes the scaling oneself, with Faust's function:

```faustx
lfo1 : it.remap(-1, 1, 140, 900) : lpf1.cutoff
```

**A port that no declaration bounds is a numeric entry** — one types the value into it. Writing `min`
and `max` makes it a slider.

---

## The channels

**The dot followed by a number designates a channel**, counted from 1 as in Faust:

```faustx
saw1.3 : lpf1.5                      // channel 3 into channel 5
lpfs.3.cutoff:400                    // the third of a bank of eight
```

For a bank of one-channel modules, the channel **is** the module.

---

## What sounds

**`process` is the sink.** What arrives there goes out; it is Faust's own word, and a FaustX program
sounds on its own, without a host.

```faustx
saw1 : lpf1 : process                // it sounds
lpf1 !: process                      // it no longer goes out

rev1.1 : process.1                   // and it has channels, like any instance
rev1.2 : process.2                   // — this is how a stereo piece is written
```

**An input is written `_`, Faust's own wire** — and it is named if one wants to come back to it:

```faustx
_ : lpf1 : process                   // the audio input goes through a filter

let micro _                          // or named
micro : lpf1 : process
micro !: lpf1                        // and the guitar is unplugged from the filter
```

**The order of the declarations fixes the order of the inputs**: `micro` is the first one on the sound
card. The number of inputs is not declared — two inputs written make a two-input program.

---

## Describing or modifying: the place decides

**In a file**, a line describes the circuit, as in Faust.

**Sent alone while it plays**, it **adds** to the graph:

```faustx
voix2 : rev1                         // one more branch; the rest remains
```

That is what saves writing `,` to add a voice, and rewriting the whole graph at every gesture.

---

## Importing

```faustx
import("mes-modules.fx")             // as in Faust
```

**The base is loaded by default**: Faust's libraries without a prefix, and the catalogue that declares
them. That is why `lowpass` is written without `fi.` — but `fi.lowpass` stays valid, as does any Faust
program that places its own imports.

---

## When the code is wrong

**An error is raised, and the sound does not stop.** The faulty gesture does not happen, the graph
stays exactly in the state it was in, and the error is returned to whoever wrote it — without a
missing sample.

This holds for a line that does not parse, for a name that does not exist, and for a program Faust
refuses: in all three cases, what was playing keeps playing.

**A correct line that sounds bad is still a correct line**: FaustX checks the code, not the music.

---

## What FaustX does not do

**No computation.** All the sound is Faust, compiled by Faust, with its 998 public functions.

**No musical time.** When a gesture happens is decided by whatever invokes it.

**No stage channels.** The sink is `process`; wiring the inputs and outputs to devices belongs to the
host.

---

## Quick reference

| writing | what it does |
| --- | --- |
| `let lpf1 lowpass` | place an instance |
| `let lpfs:8 lowpass` | place eight of them |
| `lpf1 lowpass(cutoff:400)` | replace its body |
| `!let lpf1` | give its name back |
| `_ lpf1` · `!_ lpf1` | bypass it · put it back |
| `! lpf1` | remove it, and its wires |
| `i` | the rank of the copy, in a multiple `let` |
| `saw1 : lpf1` | connect |
| `saw1 !: lpf1` | cut |
| `saw1 :8 lpf1` | connect as eight instances |
| `dly1 ~ fb1` | feed back |
| `dly1 !~ fb1` | open the loop |
| `lpf1.cutoff:400` | set a port |
| `lpf1(a:1, b:2)` | set several of them |
| `lpf1.cutoff.min:20` | place an attribute |
| `saw1.3` | one channel |
| `: process` | what sounds |
| `_` | an input |
| `name(p:1) body` | declare a module |

---

## Moved from the design journal, to be rewritten

<!-- moved from faustx-specification.md, "1. The definition" -->

**`let` shares, `=` duplicates.** That is the sentence that separates the two signs. `=` keeps its
Faust meaning intact, and using a name bound by `let` in two places is **the same circuit patched
twice**.

**A shared instance sums its inputs and broadcasts its output** — what Faust writes `:>` and `<:`.
This is the behavior of an effect send: two voices going into the same reverb resonate in the same
space.

<!-- moved from faustx-specification.md, "1. The definition" -->

**One line, never a block.** `letrec` takes a block because its equations are *mutually* recursive;
our bindings are independent. And live, you send back one line, not a batch.

**At the root only.** An instance named inside a `with{}`, a `letrec{}` or an `environment{}` would
be unreachable from outside, which destroys the very point of `let`. Faust's local scopes keep their
meaning and host no `let`.

<!-- moved from faustx-specification.md, "1. The definition" -->

**On the fallback**, when no declaration covers the function, a free identifier written in place of
an argument becomes a port and **the coder is the one who names it** — `fi.lowpass(3, cutoff:800)`.
Faust's own names cannot serve: they are the parameters of the definition, **out of scope at the call
site**, and `fi.lowpass(N:3, fc:800)` answers `undefined symbol : fc`.

<!-- moved from faustx-specification.md, "1. The definition" -->

**The rule that decides is the one we already have**: a free identifier is a port. But it leaves a
door open that has to be closed — the day someone lays down `let cutoff …`, every `cutoff:800` line
written elsewhere would change meaning with nothing moving on screen. **A port therefore cannot bear
the name of an instance, nor the reverse: the collision is refused in both directions.**

<!-- moved from faustx-specification.md, "1. The definition" -->

**The assigning `:` is not an invention**: Faust already uses it in widget modulation,
`["cutoff": 400 -> lpf]`, and its documentation states that this `:` separates visually and is not
the sequential composition operator (`syntax.md:3241`). **Verified by compiling**:
the form is accepted, and the modulator takes a constant as readily as a signal —
`["cutoff": os.osc(1) -> lpf]` compiles and adds the oscillator's state to the circuit.

<!-- moved from faustx-specification.md, "1. The definition" -->

**What FaustX takes from it is the move.** In Faust the target is written **inside** the brackets and
the expression is rebuilt; live, the target is already laid down and carries a name, so
`lpf1.cutoff:400` is enough.

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**⚠️ The comma is not the studio's parallel**, and Faust's documentation, which calls it *parallel
composition*, invites confusion. It **stacks** two circuits that ignore each other: each keeps its
own inputs and outputs. Measured — `A , B` has **2 inputs and 2 outputs**, where the musician's
parallel, `A <: (X,Y) :> B`, has **one of each**. The latter is written with `<:` and `:>`, and it is
precisely the one that naming an instance makes automatic.

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**FaustX's `:` adapts instead of refusing, like a polyphonic cable in VCV Rack.**

| what arrives | what FaustX does |
| --- | --- |
| one channel into several | it is **broadcast** to all of them |
| several channels into a module's input | they are **summed** |
| several channels into a named port | the **first** is taken |
| widths with no whole ratio | we come back to the number the port accepts |

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**This distinction is VCV Rack's, to the letter.** Its voltage standards prescribe, for a
one-channel module receiving a multi-channel cable: *"sum the voltages of all channels"* on an audio
input, *"use the first channel's voltage"* on a modulation input.

**And our notation already carries it, with nothing added.** `saw8 : lpf1` aims at the module's
input, so at audio, so we sum — nothing falls silent. `lfo8 : lpf1.cutoff` aims at a named port, so
at a control, which has only one value: the first channel is taken. The dot is enough to tell the two
apart, where Faust knows only one kind of signal.

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**What stays non-VCV, and is meant to**: in VCV Rack an input takes only one cable, and an effect
send needs a mixer. In FaustX, several cables arriving at a port are summed, because the port belongs
to a named instance. These are two distinct questions — the width of a cable, and the number of
cables on a port.

<!-- moved from faustx-specification.md, "2. The five combinators" -->

| sign | what it does | in FaustX |
| --- | --- | --- |
| `:` | put in series | `:8` the width, `!:` cut, and it adapts |
| `,` | stack | **unchanged** |
| `<:` | split | **implicit** |
| `:>` | merge | **implicit** |
| `~` | loop back | `!~` open, `~8` the width |

**Stacking needs nothing**, and that is a result: what it serves to do live — add a branch — is
already covered by the placement rule. In a file, a line describes the circuit; sent alone while it
plays, it adds. The `,` keeps its role inside an expression written in one piece.

**Split and merge disappear because the definition made them automatic.** A named instance connected

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**The digit says how many channels come back** — and the measurement shows the question is a real
one, because Faust does not loop everything back by default:

| Faust notation | inputs | outputs |
| --- | --- | --- |
| `par(i,8,+) ~ par(i,8,_)` — eight channels looped back | 8 | 8 |
| `par(i,8,+) ~ par(i,4,_)` — four looped back | 12 | 8 |
| `par(i,8,+) ~ _` — **one only** looped back | 15 | 8 |
| `+ ~ par(i,8,_)` — more returns than inputs | **refused** | |

The inputs that are not looped back stay free, and their number changes with the width of the return.
Writing `dly1 ~4 fb1` therefore says something no other notation says briefly: **four channels come
back, the others stay open**.

<!-- moved from faustx-specification.md, "3. The routing primitives" -->

No new sign: the dot already takes something from an instance, and what follows says what — a name
for a control, a number for a channel. FaustX emits the matching `route(…)`, and writes only the
channels being talked about.

<!-- moved from faustx-specification.md, "3. The routing primitives" -->

**The operator comes before its operand**, as everywhere else in programming, and as the `!` already
does on `!:`, `!~` and `!let`. One single use of `!` in the whole language: **in front of what it
cancels**.

<!-- moved from faustx-specification.md, "3. The routing primitives" -->

**And this is not the same thing as replacing a body.** `lpf1 lowpass(5, cutoff)` makes the filter
another filter; `_ lpf1` does not touch the body, it changes the module's relation to the graph. Two
distinct acts, two notations.

<!-- moved from faustx-specification.md, "3. The routing primitives" -->

**The `_` requires the space.** `_lpf1` is a valid identifier in Faust — verified by compiling a
definition that carries that name. Written flush, the gesture would become a name. So we write
`_ lpf1` and, by symmetry, `! lpf1`; the `!` only sticks to compound signs.

<!-- moved from faustx-specification.md, "3. The routing primitives" -->

**Channels are counted from 1, like Faust.** `saw1.1` is the first. VCV Rack counts from 0, but Faust
is what receives the program, and `route(2,2, 1,2, 2,1)` counts this way.

<!-- moved from faustx-specification.md, "5. The iterators" -->

**`:8` means *eight times*, and nothing else, wherever it appears.**

<!-- moved from faustx-specification.md, "5. The iterators" -->

**Stuck to the name being declared**, it says that this name designates eight of them; **between two
names**, it says the connection is made in eight copies. One single idea, two positions.

**Multiplicity belongs to the name, not to the body** — and that is what keeps the notation workable
when the body gets complicated: `let voix:8 sawtooth : lowpass` needs no parentheses at all, where
carrying the number at the end of the expression would require them.

<!-- moved from faustx-specification.md, "6. The interface parameters" -->

The body accepts raw Faust just as well, through the fallback: `voix(freq:110) os.sawtooth(freq)`.

<!-- moved from faustx-specification.md, "6. The interface parameters" -->

Faust requires five arguments, so FaustX has to invent four: the choice is forced, it is only a
matter of making it well. A slider with arbitrary bounds is unusable — its travel means nothing —
whereas a numeric entry stays correct whatever its bounds, since you **type** the value into it. That
is precisely the live coding gesture.

<!-- moved from faustx-specification.md, "7. The entry point" -->

**No invention**: `process` is Faust's word, the `:` is the connection, the `!:` the cut. What FaustX
adds is a point of view — where Faust makes it a definition you write once, FaustX makes it **the
sink of the graph**, which you patch into and out of while it plays.

**What the translation does with it**: it gathers everything arriving at `process` and emits
`process = <what arrives there>`. Multiple connections are summed, as on any port.

<!-- moved from faustx-specification.md, "7. The entry point" -->

**Both notations are allowed.** The first is Faust, the second is what live performance calls for;
neither deprives you of the other.

<!-- moved from faustx-specification.md, "8. Imports" -->

**The catalogue stays compatible with `stdfaust.lib`, and that is verified.** The modules it declares
carry **exactly Faust's names**, neither renamed nor translated, and their bodies call the functions
by their usual prefixes — `fi.`, `os.`, `ba.`, `pm.` No name is declared twice in it. A musician who
knows Faust recognizes everything they read; they simply write two characters fewer.

<!-- moved from faustx-specification.md, "The implementation" -->

**The name is free, the control is paid for.** This is what grounds the rule *name only what you
control*: a declared port makes the control addressable and stops Faust from precomputing the
coefficients, where a constant freezes them. The coder chooses, module by module.
