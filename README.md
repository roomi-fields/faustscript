# FaustX — live coding on top of Faust

**FaustX is a language for patching while the sound is playing.** It adds to
[Faust](https://faust.grame.fr) the two things live performance needs and Faust
does not have: **naming one instance**, and **acting on that instance while it
runs**.

It computes nothing. A FaustX program is **translated into Faust**, and Faust
compiles it — with its 998 public library functions, untouched.

```faustx
let saw1 sawtooth(freq:110)
let lpf1 lowpass(fc:800)

saw1 : lpf1 : process
```

becomes

```faust
import("stdfaust.lib");
saw1 = vgroup("saw1", os.sawtooth(hslider("freq[unit:Hz][scale:log]", 110, 0.08, 220, 0.001)));
lpf1 = vgroup("lpf1", fi.lowpass(4, hslider("fc[unit:Hz][scale:log]", 800, 2, 8000, 0.001)));
process = saw1 : lpf1;
```

The filter order stays a constant, `fc` becomes a slider with its real bounds
and a logarithmic scale, and the instance name becomes the control path
`/lpf1/fc`. All of that comes from the catalogue; you wrote `fc:800`.

---

## Why a new language at all

In Faust, **a name is a macro**: it is replaced by its body during evaluation,
so writing `lpf` twice builds two filters. Measured on Faust 2.70.3: one use of
`fi.lowpass(3, 800)` produces a circuit with **18 memory fields**, two uses
produce **36**.

Separate state is therefore free — but **no Faust expression can point at an
instance that already exists**. Naming duplicates; there is no address. That is
what stops you from writing, an hour into a set, *"that filter, the one that is
currently ringing — open it up."*

FaustX gives that address, and nothing else.

---

## The principle

**Decorate Faust's own signs; do not invent new ones.** The `:` stays the
connection, and what surrounds it qualifies it.

| written | what it does | |
|---|---|---|
| `A : B` | connect | Faust |
| `let lpf1 lowpass` | place **one** instance | FaustX |
| `let lpfs:8 lowpass` | place eight | FaustX |
| `lpf1 lowpass(fc:400)` | replace its body, memory kept | FaustX |
| `!let lpf1` | give the name back | FaustX |
| `saw1 :8 lpf1` | connect as eight instances | FaustX |
| `saw1 !: lpf1` | cut the wire | FaustX |
| `dly1 ~ fb1` · `dly1 !~ fb1` | close · open a feedback loop | Faust · FaustX |
| `_ lpf1` · `!_ lpf1` | bypass · un-bypass | FaustX |
| `! lpf1` | remove it and its wires | FaustX |
| `lpf1.fc:400` | set one control | FaustX |
| `lpf1(fc:400, q:2)` | set several at once | FaustX |
| `lfo1 : lpf1.fc` | drive a control with a signal | FaustX |
| `saw1.3` | one channel of an instance | FaustX |

**Three rules, and nothing else to remember:** a `!` in front cancels what
follows it, a digit after says how many, and the dot reaches into an instance.

**Spacing is significant:** `:8` is a width,
`: 8` connects to the constant 8; `fc:800` assigns, `a : b` connects. And one
line is one statement.

The gain is measurable. `par(i,8,saw) : par(i,8,lpf)` is 28 characters;
`saw1 :8 lpf1` is 12. **Live, that is the difference between typing while it
plays and not managing at all.**

---

## What FaustX does not do

**It computes nothing.** Every sample is Faust's work.

**It knows nothing about musical time.** When a gesture happens is decided by
whatever invokes it.

**It knows nothing about your stage.** Its sink is `process`, Faust's own, so a
program runs standalone; wiring inputs and outputs to devices or to an actor's
channels belongs to the host.

**It never modifies the Faust compiler.** Nothing here is a fork.

---

## Behaviour worth knowing about

These follow from Faust's own routing, and they match VCV Rack:

**Cutting a wire feeds silence, it does not remove the input.** Cut the bass
feeding an amplifier and the branch goes quiet — rather than the envelope being
multiplied by itself and carrying on.

**Several wires into one input sum.** Three oscillators into one filter mix,
like three players around one microphone.

**One wire into several inputs is copied.** One LFO drives two filters exactly
in phase — one LFO, not two.

**Nothing is cut off abruptly.** A bypassed or removed module keeps running on
silence, so what was ringing inside finishes ringing. Faust's own `ba.bypass1`
does the opposite — measured, a reverb's 97 memory fields drop to 0, the module
is erased; ours keeps 81.

**A wrong line raises an error and the sound does not stop.** The graph is never
touched until the program compiles.

---

## Status

**The language is settled.** All eight elements of Faust have been reviewed —
definition, the five composition operators, routing primitives, substitution,
iterators, interface parameters, entry point, imports — and every claim in the
specification was checked by compiling.

**The transpiler works.** The three pieces in `examples/` translate without a
single rejected gesture, and the Faust they produce compiles. 34 tests, a dozen
of which invoke the real compiler.

**The catalogue declares all 998 public Faust functions** — parameters, starting
values, bounds, measured input and output counts, and measured output ranges for
738 of them. It is generated from Faust's own documentation by
`tools/generate-declarations.py`.

**What is not true yet:** *every Faust program is a FaustX program* is the
stated goal, not the current state. The grammar reads FaustX, plus Faust's
definitions, imports, operators, iterators and feedback — but not yet `with{}`,
`letrec`, pattern matching or explicit substitution. Real `.dsp` files do not
parse whole.

**There is no sound here.** FaustX emits Faust source. Compiling it while the
audio runs, and swapping a module without dropping a sample, belongs to the
host — that is where the measured **14.7 ms** per module recompilation matters,
against 340 ms for a fifty-module program.

---

## Try it

```bash
npm install && npm test
```

Requires Node 22+. The compilation tests need `faust` on your `PATH`
(measurements here were made with 2.70.3).

---

## How it is built

The rule the whole implementation obeys: **no sign of the language is written
anywhere in the code.** The grammar generates the parser, the catalogue declares
the modules, the templates say what each form becomes in Faust — and a test
fails if any of it leaks into the engine.

| | |
|---|---|
| `src/faustx.grammar` | the grammar; it **generates** `src/parser.js` (Lezer) |
| `lib/faust.fx` | the catalogue — 998 modules, itself written in FaustX |
| `lib/translation.fx` | templates, reserved words, decision rules |
| `src/` | graph, reading, staging, emission — none of it knows the language |

---

## Documentation

`docs/LANGUAGE.md` — the reference: how to write FaustX.
`docs/ARCHITECTURE.md` — how the transpiler is built.
`docs/faustx-specification.md` — the design: why each sign is the one it is.

---

## Licence and upstream

**FaustX is MIT licensed** — see `LICENSE`. Nothing is imposed on anyone using
it.

The Faust compiler is LGPL 2.1, and **the code it generates is not covered by
it** — GRAME's FAQ states so explicitly. FaustX requires **no change to the
compiler** and touches none of its 304 architecture files, whose licence
exception holds precisely on the condition that they are not modified.

FaustX is an independent project. It is not affiliated with GRAME-CNCM, who
develop Faust.
