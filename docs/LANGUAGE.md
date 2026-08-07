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
