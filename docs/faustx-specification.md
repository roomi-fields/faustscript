# FaustX — Faust, plus what live performance demands

> ⛔ **TO BE REDONE ENTIRELY — 2026-08-05.** This document proposes three inventions with nothing in
> common: a reference sign, brackets with an implicit operand, keywords. **Romain found the principle
> that replaces all three: we DECORATE Faust's signs instead of inventing others.**
>
> ```
> saw1  : lpf1        chain                       Faust
> saw1 :8 lpf1        chain on eight channels     FaustX
> saw1 !: lpf1        cut                         FaustX
> lfo1  : lpf1.reso   patch into a named port     FaustX
> ```
>
> **The review is done** — the eight elements of the language have been gone through, and it starts
> right under this banner: the definition, the five combinators, the routing primitives,
> substitution, the iterators, the interface parameters, the entry point, imports.
>
> **What follows the review still holds**: the scope, the license, the implementation, the
> measurements. **The draft is gone** — its two additions are covered by the review, and its
> `on`/`off` keywords by primitives Faust already carries.

## What FaustX adds


**Tag: `fx:`.** A backtick `` `fx: …` `` carries FaustX.

---

## What Faust does, and what we do not redo

Faust **describes a circuit** and compiles it. Its combinators compose blocks:

```
A : B      series                A , B      stack
A <: B     split                 A :> B     merge
A ~ B      recursion
```

Its library carries **998 public functions** — oscillators, filters, envelopes, effects, analysis — of
which **645 depend on recursion**, the construction that makes reverbs, delays and recursive filters.


---

# The review of the elements

Every construction of Faust is reviewed: what live performance demands, and how the existing sign
gets decorated. **Settled as of today: the definition.**

---

## 1. The definition

### What Faust has

**A Faust name is a macro.** `name = expression;` binds an identifier to a body, and the identifier
is replaced by its body at evaluation — the documentation says it without hedging: *"it is therefore
always equivalent to use an identifier or directly its definition"* (`syntax.md:149`). Writing `lpf`
in two places builds **two circuits**, each with its own memory.

**Measured** (Faust 2.70.3, C output): `lpf = fi.lowpass(3, 800)` used once gives a circuit with **18
memory fields**, used twice **36**. An oscillator has 8, a filter 10, a reverb 97. The duplication is
not a figure of speech, it can be read in the generated code.

**Faust refuses a second definition**: *"multiple definitions of the same identifier are not
allowed"*, except by pattern matching.

### What live performance demands

**Separate state is a given, the address is what is missing.** Every use produces its own instance
with its own memory, with nothing to write. But **no Faust notation designates an instance already
laid down**: naming duplicates, and the name disappears at compile time. Nothing lets you write, an
hour later, "that one".

Live performance demands the three acts this lack forbids: **lay down** an instance, **come back to
it** while the sound is playing, and **give its name back** when it is no longer needed.

### The notation

```faustx
lowpass(order:3, cutoff:800) …       // declare the module — see "interface parameters"

let lpf1 lowpass                     // lay down an instance
    lpf1 lowpass(order:5)            // replace its body, the memory stays
   !let lpf1                         // give the name back, the tail drains
```

**The name first, the body next, with no sign between them.** The first word is the name, all the
rest is the body; it accepts any Faust expression.


**The name alone replaces the body.** `let` declares, the name without `let` reassigns — the
distinction every binding language makes, carried here by the one word that declares, adding nothing.
**Verified by compiling**: `lpf1 fi.lowpass(5,800)` is a syntax error in Faust, both as an expression
and at the head of a line. The slot is free.


### The rules

**One declaration per name.** A second `let` on `lpf1` is an error — like Faust, like every binding
language. To change an instance you replace it or you give it back; you do not redeclare it.



**The name prefixes the control paths.** Faust refuses two controls with the same path — a bank of
eight identical filters gives `ERROR : path '/Filter_Bank/Band/Q' is already used` (`faq.md:180`),
and the usual workaround is to number the label by hand. A name declared once is unique by
construction: `/lpf1/cutoff` is unique with no effort, and the error becomes unreachable.

### The ports

**A module's ports come from its declaration** — their names, their default values, their ranges. The
*interface parameters* element is what establishes this; here it is enough to know that an instance
carries them and that you reach them through the dot.

```faustx
let lpf1 lowpass                     // the ports declared by the module
    lpf1.cutoff:400                  // live, one control
    lpf1(cutoff:400, order:5)        // several at once
```

**What this replaces**: Faust requires writing the control by hand, and the line triples in length.

```faust
lpf1 = fi.lowpass(3, hslider("cutoff", 800, 20, 20000, 1));   // 59 signs
```
```faustx
let lpf1 lowpass                                              // 16 signs
```


**⚠️ This notation is not neutral for Faust, and that is measured.** With `fc` defined just above,
`fi.lowpass(3, fc:800)` answers `ERROR : sequential composition fc:fc` — the same error, sign for
sign, as `fi.lowpass(3, (fc : 800))`. **Faust reads `fc:800` as a connection**, not as an assignment.
The form only works because FaustX translates and Faust never sees it.

**So it has to be said what FaustX does with it**, since both readings are legitimate inside an
argument — Faust accepts a composed circuit there:

```faustx
fi.lowpass(3, cutoff:800)   // cutoff is defined nowhere → a port
fi.lowpass(3, saw1:lpf2)    // saw1 is an instance       → a connection
```




### What this does to the sound

**`!let` does not cut abruptly.** The name is given back immediately, but the instance stops being
fed and **its tail drains** before it disappears: a reverb that is removed finishes ringing. Without
this rule, every removal produces a click, which is unacceptable while playing.

**The two replacements are therefore distinct, and the musician chooses.**

```faustx
     rev1 mono_freeverb(0.9, 0.7, 0.4, 0)  // the tail in progress survives
!let rev1
 let rev1 mono_freeverb(0.9, 0.7, 0.4, 0)  // the old one dies away, the new one starts blank
```

### What this asks of the implementation

Keep the name → instance table, and emit to Faust a program where each instance is a distinct
circuit, the sharing drawn with `<:` and `:>`, and each port a control placed in the group that bears
the name. **Faust never sees the name.**

### What remains open

**The library prefix.** `lowpass` is written here without `fi.`; that is already valid Faust with
`import("filters.lib")`, but what gets imported by default belongs to the *imports* element.

**The entry point.** The examples do not show the line that produces the sound; `process` belongs to
the *entry point* element.

---

## 2. The five combinators

### What Faust has

Five signs compose circuits: `A : B` puts in series, `A , B` **stacks**, `A <: B` splits, `A :> B`
merges, `A ~ B` loops back. They are frozen productions of the grammar (`faustparser.y:481-485`) — no
library can declare a sixth.


**Width — the number of input and output channels — is fixed at compile time, and the combinators
require it strictly.** Measured, Faust 2.70.3:

| widths | `:` | `<:` | `:>` |
| --- | --- | --- | --- |
| 8 → 8 | passes | — | — |
| 1 → 8 | **refused** | passes | — |
| 8 → 1 | **refused** | — | passes |
| 2 → 3 | refused | **refused** | — |
| 8 → 4 | refused | — | passes |

**The `:` demands exact identity at both ends.** `<:` and `:>` do adapt, but only by whole multiples:
2 into 8 passes, 2 into 3 is refused. Any mismatch stops the compilation.

### What live performance demands


**Writing a width in one sign.** Faust's multichannel is written by duplicating both sides:
`par(i,8,os.sawtooth(100+i)) : par(i,8,fi.lowpass(3,800))` is **56 signs** against **12** for
`saw1 :8 lpf1`. Live, that is the difference between writing while it plays and not managing at all.

**Opening a loop that is sounding.** Recursion carries 645 of the library's functions — every
reverb, every compressor, 109 filters out of 114.

### The adaptation rule — settled 2026-08-06



**It costs Faust nothing.** FaustX translates: it emits the `<:`, the `:>` or the bus that fits the
widths it sees. The compiler receives a program whose widths come out even, and never has to know
that any adaptation took place.



**What the adaptation does not make up for**: width stays **fixed at compile time**, where VCV
changes it while playing. Varying it live means recompiling the module concerned — ~32 ms.

### How each one gets decorated

```faustx
saw1 :8 lpf1        // the width is written on the sign that connects
saw1 !: lpf1        // cut the cable
dly1 !~ fb1         // open the loop
dly1 ~8 fb1         // loop eight channels back
```


**Of the five signs, two get decorated, one stays as it is, and two disappear from everyday
writing.**

twice is broadcast; two cables on the same port are summed. This is the first place where the element
settled before this one pays off somewhere other than at home.

### What this does to the sound

**Opening a loop does not cut abruptly**: what is circulating finishes draining, as with `!let`. One
musical rule across every use of `!`.

### What `~8` means


---

## 3. The routing primitives

### What Faust has

**Two one-sign primitives**: `_` lets through (one channel in, one channel out) and `!` cuts (one
channel in, nothing out). Their wide versions are in the library: `si.bus(N)` for N wires,
`si.block(N)` for N cuts.

**And one explicit permutation**: `route(inputs, outputs, from, to, from, to, …)`. Crossing two
channels is written `route(2,2, 1,2, 2,1)` — **verified by compiling**. Each pair says which channel
goes where, and they all have to be listed.

### What live performance demands

**Reaching one precise channel without listing the others.** Crossing two channels out of eight asks
Faust for a list of sixteen numbers in which fourteen say nothing but "stay put".

**Neutralizing a module without removing it**, and deleting a branch — two gestures the primitive can
describe, but only at the place where it is written, never on a circuit already laid down.

### How it gets decorated

**The dot designates a channel, just as it designates a port.**

```faustx
lfo1 : lpf1.cutoff      // a named port      — already settled
saw1.3 : lpf1.5         // channel 3 into channel 5
```


**The two primitives become gestures, written in front of the instance they aim at.**

```faustx
_ lpf1        // neutralize: the signal passes through, the module stays alive
! lpf1        // delete: nothing comes out of it any more
```





### What this does to the sound

**A neutralized module stays alive, and its tail drains.** That is what the notation says of itself:
`_ lpf1` does not replace the body, so the module goes on existing and whatever was ringing inside it
finishes coming out. A bypassed reverb is not cut off.

**This is the opposite of what Faust does.** Its `ba.bypass_fade` feeds the module zeros and **clears
its state**. FaustX's rule is musical, not technical, and it holds for every use of `!` and `_`:
nothing is ever cut abruptly.


---

## 4. Substitution

### What Faust has

**Two bracket constructions.** Explicit substitution, `expr[name = body]`, *"replaces certain
internal definitions without having to modify"* the expression (`syntax.md:1046`,
`faustparser.y:514`). And widget modulation, `["cutoff": 400 -> lpf]`, which aims at a control by its
label (`faustparser.y:609`).

**But substitution applies to almost nothing.** Measured:

| what it is tried on | result |
| --- | --- |
| `component("brique.dsp")[damp = 0.9]` — an imported file | **passes** |
| `environment{ … }[d = 0.9]` — a record of definitions | **passes** |
| `fi.lowpass(3,800)[fc = 400]` — a library function | `ERROR : not a closure` |
| `lpf[fc = 400]` — a name defined above | `ERROR : not a closure` |
| an expression with a `with{}` | `ERROR : not a closure` |

**It is a loading construction, not a patching one.** It serves to customize a `.dsp` you import,
before it becomes a circuit. It cannot aim at a circuit already composed.

### What live performance demands

**Nothing that is not already covered.** The three uses one might look for have each found their
notation elsewhere in the review:

| what you want to do | what already does it |
| --- | --- |
| replace a module's body | `lpf1 lowpass(5, cutoff)` — the name alone |
| give a control a value | `lpf1.cutoff:400` |
| have a signal modulate a control | `lfo1 : lpf1.cutoff` |

### How it gets decorated

**Not at all.** This is the second element, after stacking, where the review concludes there is
nothing to add. Both constructions stay valid — a superset removes nothing — and
`let rev1 component("mareverb.dsp")[damp = 0.9]` is written just as it is if you customize a file at
the moment you lay it down.

### What the measurement corrected

**The first draft of this review justified the brackets badly.** It claimed that FaustX's live graph,
being a table of named definitions, was precisely the object Faust's substitution applies to. **That
was false**: substitution applies to an environment *before* it becomes a circuit, never to a living
circuit. The hot-replacement gesture was therefore not the decoration we thought it was, and dropping
it in favor of the name alone rests on a fact, not on a taste.

---

## 5. The iterators

### What Faust has

**Four constructions that repeat an expression**: `par(i,N,X)` stacks N copies, `seq(i,N,X)` puts
them in series, `sum(i,N,X)` adds them, `prod(i,N,X)` multiplies them. The index `i` is available in
the body, which is what lets each copy vary.

| notation | inputs | outputs |
| --- | --- | --- |
| `par(i,8,lowpass)` | 8 | 8 |
| `seq(i,8,lowpass)` | 1 | 1 |
| `sum(i,8,…)` | 0 | 1 |

**The number of copies is frozen at compile time.** `par(i, 2*4, _)` passes, `par(i, hslider(…), _)`
is refused — *the parameter must be a constant*. Changing the number of voices while playing
therefore means recompiling the module: ~32 ms, measured, which stays workable.

### What live performance demands

**Laying down a bank of eight without writing the iterator**, and being able to reach the third one.

### ⛔ What the review brings to light: `:8` was never defined

The `saw1 :8 lpf1` decoration has been in place since the first draft, with its measurement — 12
signs against 56. **But it carries two incompatible meanings, and one has to be chosen.**

**First meaning — the width of the cable.** `saw1` and `lpf1` remain one instance each, and the `8`
says the cable carries eight channels. **This meaning has become useless**: the adaptation rule,
settled under the *combinators* element, already adjusts the widths with nothing written.

**Second meaning — duplication.** `saw1 :8 lpf1` is worth `par(i,8,saw1) : par(i,8,lpf1)`, that is
eight complete chains. This is the meaning the 56-against-12 measurement announced, and it is the one
that brings something. **But it makes eight copies of an instance that `let` declared unique.**

**The second is the one kept**, for three reasons: the first is of no use any more, the second
carries the gain the project was founded on, and `let`'s uniqueness is not violated — `saw1 :8 lpf1`
declares nothing, it is an expression that repeats a circuit, exactly like `par` in Faust. What is
unique is the name; what repeats is the circuit it designates.

### Multiplicity is written on the name


```faustx
let lpf1    lowpass                  // one instance
let lpfs:8  lowpass                  // eight
let voix:8  sawtooth : lowpass       // eight complete chains

    lpfs.3.cutoff:400                // the third one, reached like a channel
    lpfs.cutoff:400                  // all of them together
```


**And the eight are named with nothing added**: the dot takes from the instance, the number
designates the channel, and for a bank of one-channel modules, the channel **is** the module.
`lpfs.3` is the third filter. This is the routing-primitives rule, applied just as it stands.

**Verified by compiling**: `lpfs:8` has no reading in Faust, neither at the head of a line nor inside
an expression. The slot is free.

**Changing the number while playing costs a recompilation** — the number of copies is a constant for
Faust. `lpfs:16 lowpass` replaces the bank with a bank of sixteen: ~32 ms, and the tail of the old
eight drains as it does for every replacement.

### How the others get decorated


---

## 6. The interface parameters

### What Faust has

**Seven kinds of control**, among them the `hslider` and `vslider` sliders and the `nentry` numeric
entry, which each take **five arguments**: label, default value, minimum, maximum, step. Plus
`button`, `checkbox`, and the `hbargraph` / `vbargraph` displays.

**All five are mandatory** — `hslider("f", 440)` is a syntax error, **verified**. Faust, on the other
hand, demands nothing of their coherence: minimum equal to maximum, zero step, a range from zero to a
billion, everything passes.

**Groups build a path.** `vgroup("lpf1", …)` around a `cutoff` control produces **`/lpf1/cutoff`** —
verified by reading the interface the compiler describes to its host.

**The metadata live in the label**, between brackets: `"cutoff [unit:Hz] [scale:log]"`. The compiler
extracts them from it and delivers them separately — `[{scale: log}, {unit: Hz}]`. This is how the
unit, the logarithmic scale, a button's style, a MIDI or OSC assignment get declared.

### What live performance demands

**A control fits in one word.** Writing five arguments to make a value controllable is impractical
while playing — the *definition* element already settled that: a free identifier in the body is a
port, and `cutoff:800` gives it its default value.

**But the ranges are missing, and they are not decorative.** A physical controller sends 0 to 127 and
has to map that somewhere. And a frequency is set on a **logarithmic scale**: a linear slider from 20
to 20,000 Hz spends half its travel above 10 kHz, which makes it musically unusable.

**The unique path, for its part, is already a given**: `let` declares a name once only, so
`/lpf1/cutoff` cannot collide — that is what makes the `path is already used` error unreachable.

### How it gets decorated

**The dot takes from the port what the `:` assigns.** No new rule: these are the same two as
everywhere else, applied once more.

```faustx
let lpf1 lowpass(cutoff:800)         // the port, and where it starts from
    lpf1.cutoff.min:20               // its range, written once only
    lpf1.cutoff.max:20000
    lpf1.cutoff.scale:log            // the scale
    lpf1.cutoff.unit:Hz              // the unit

    lpf1.cutoff:400                  // and live, the value
```

**All of Faust's metadata go through here**, without a single one being named in the grammar: what
follows the second dot is the word Faust expects between brackets. `scale`, `unit`, `style`, `midi`,
`osc` — FaustX does not know the list, it passes them on.

**And the verbosity falls where it does not get in the way**: the ranges are written once, at the
declaration, never while you play.

### What this replaces

```faust
lpf1 = fi.lowpass(3, hslider("cutoff [unit:Hz] [scale:log]", 800, 20, 20000, 1));
```

A line of 78 signs where the label is repeated as a string, the range is drowned in the order of the
arguments, and the module's name is absent — it would still have to be wrapped in a `vgroup` to get
the path.

### The defaults and the names come from the module's declaration

**Nobody is going to write a filter's range every time**, and nobody should have to remember the
position of its arguments. Both problems have the same solution: **every module is declared, and its
declaration carries the names and the default values.**

```faustx
lowpass(order:3, cutoff:800)  fi.lowpass(order, cutoff)
  cutoff.min:20
  cutoff.max:20000
  cutoff.scale:log
  cutoff.unit:Hz
```

**The name first, what it is worth next** — the rule from everywhere else. The parentheses after a
name are the ones Faust already uses to define a function with parameters, and **the same words serve
inside and outside**: `cutoff` names the parameter in the body, the port in use, and the attribute
that bounds it.

**A module can compose several of them**, and **its body is FaustX** — so it calls the modules
already declared with their parameter names, as everywhere else:

```faustx
voix(freq:110, cutoff:800)  sawtooth(freq:freq) : lowpass(cutoff:cutoff)
```


**What this removes**: the imposed order and the argument positions. A declared module is
instantiated without counting.

```faustx
let lpf1 lowpass                     // everything by default
let lpf2 lowpass(cutoff:400)         // one parameter only, in whatever order you like
    lpf2.cutoff:800                  // live, one control
    lpf2(cutoff:800, order:5)        // live, several at once
```

**The parentheses assign several controls at once**, like the bag of an earlier language of ours —
`sa(vel:80)`. The dot assigns one only.

**Cascading, and the most local wins** — a rule taken over as it stands from an earlier language of
ours: what is written on the instance beats what the declaration gives the module.

**The fallback, so as not to close off Faust's library.** An undeclared function stays instantiable,
with its arguments in Faust's order and a port named on the fly:

```faustx
let lpf1 fi.lowpass(3, cutoff:800)   // no declaration: Faust's order, no defaults
```


### The declarations generate themselves

**Faust's libraries already carry what is needed to write them.** Every public function is documented
in a standardized block: a usage section that says whether it takes a signal, the description of each
parameter with its unit and its range, and a worked example to take the default values from.
**`tools/generate-declarations.py` turns them into declarations**, and the result fits in
`lib/faust.fx`.

| out of the 998 public functions | |
| --- | --- |
| **declared** | **980 (98%)** |
| of which at least one unit read | 232 (23%) |
| of which at least one range read | 143 (14%) |
| **complete, with nothing left to fill in** | **186 (18%)** |
| neither signature nor usage usable | 18 |

**Generated from the documentation, inventing nothing:**

```faustx
resonlp(fc:1000, Q:2, gain:0.8)  fi.resonlp(fc, Q, gain)
  fc.unit:Hz
  gain.min:0
  gain.max:1
  // TO COMPLETE: fc with no range
  // TO COMPLETE: Q with no range
```

**What the extraction needed beyond the signatures**: following the forwardings from one definition
to another — `sawtooth = saw2;` only exposes its parameters at the end of the chain — and recognizing
the modules with no control, whose usage is written without parentheses:
`_ : softclipQuadratic1 : _`. The two together take coverage from 87% to 98%.

**What the extraction does not give.** The names stay Faust's, often terse — `N`, `Q`, `fc`. **The
ranges are missing four times out of five**, because the documentation does not give them: they have
to be written by hand, function by function, as use dictates. Every gap is marked `// TO COMPLETE` in
the generated file. **The generated declarations are a starting point, not a finished catalogue.**

### The default for an unbounded port

**A port that no library covers and that has not been given a range is a numeric entry.** Writing
`min` and `max` makes it a slider.


**The case is rare anyway and the choice is reversible**: as soon as a library covers the function,
the range comes from it. Nothing that is written depends on this default.

---

## 7. The entry point

### What Faust has

**One single name, and it is mandatory**: `process`. A program that does not define it is refused —
`ERROR : undefined symbol : process`, verified. The inputs and outputs of `process` **are** the
inputs and outputs of the program: Faust has no named sink, no output declared anywhere else.

**The number of inputs is not declared, it is deduced from the circuit.**

| what you write | inputs | outputs | |
| --- | --- | --- | --- |
| `os.sawtooth(440)` | 0 | 1 | a generator |
| `_ : fi.lowpass(3,800)` | 1 | 1 | an effect |
| `_,_ : (lpf, lpf)` | 2 | 2 | a stereo effect |

**A `_` written at the head is an input**: it is the "let through" primitive, and one wire at the
start of the circuit is enough to create one.

**And Faust never names its inputs.** The generated code calls them `input0`, `input1` — a numbered
array — and the interface it describes to its host says nothing more than `inputs: 2`. No label,
nowhere. **So this is an extension FaustX adds, not something it takes over.**

### What live performance demands

**Saying what is sounding, without rewriting the whole thing.** While playing you add a voice, you
remove one — and `process = …` describes the entire circuit, which you do not want to rewrite at
every gesture.

**Naming what comes in.** A live coding language that cannot handle a guitar is incomplete; and
`input0` does not say what is plugged into it.

### How it gets decorated

**`process` is an instance like any other, and you patch into it.**

```faustx
let saw1 sawtooth(freq:110)
let lpf1 lowpass(cutoff:800)

saw1 : lpf1 : process        // it sounds
saw1 !: process              // nothing comes out any more
```


### And an input is written both ways

**Faust's wire, just as it is** — nothing to learn, it is exact Faust:

```faustx
_ : lpf1 : process
```

**Or named, like everything else** — because `input0` does not say what is plugged into it:

```faustx
let micro _
let ligne _

micro : lpf1 : process
ligne : rev1 : process
```

**`let` lays down an instance whose body is a wire coming from outside.** Nothing new in the
language: `_` is a Faust expression, `let` binds it, and you come back to it afterwards as to any
other instance — `micro !: lpf1` unplugs the guitar from the filter without touching the rest.


**The order of the inputs is the order of the declarations.** Faust numbers them without naming them,
so something has to decide which one is `input0`: it is the order in which the `let … _` are laid
down. So `micro` is the first input of the sound card, `ligne` the second, and that does not change
when the graph is rewritten.

**The number of inputs stays deduced, never declared** — two inputs written make a program with two
inputs, as in Faust. FaustX adds no format declaration.

### ⛔ What this corrects in our own texts


---

## 8. Imports

### What Faust has

**Three notations, and they do not do the same thing**:

| notation | effect | measured |
| --- | --- | --- |
| `import("filters.lib")` | pours the definitions into the current space | bare `lowpass(3,800)` **passes** |
| `fi = library("filters.lib")` | builds a prefixed environment | `fi.lowpass(3,800)` passes |
| `import("stdfaust.lib")` | does nothing but `library()` calls | bare `lowpass` **is refused** |
| `component("x.dsp")` | loads a file as a circuit | — |

**This is why everyone writes `fi.lowpass`**: `stdfaust.lib`, which everybody imports, gives nothing
but prefixed environments. Importing the library file directly is enough to write the bare name, and
**several direct imports coexist without trouble** — verified.

### What live performance demands

**Writing `lowpass`, not `fi.lowpass`.** Two characters and a dot, repeated at every module, in a
language whose whole point is writing fast.

**Not repeating the imports.** A line `import("stdfaust.lib");` at the head of every fragment played
makes no sense live.

### How it gets decorated

**Not at all — what changes is what gets loaded automatically.** The `import(…)` notation stays
Faust's; FaustX only adds an **implicit base**: Faust's libraries imported without a prefix, and the
catalogue of declarations that gives them names and default values.

```faustx
let lpf1 lowpass(cutoff:800)     // nothing to import, the base is there
import("mes-modules.fx")         // and you load your own as in Faust
```

**The bare name is workable, and that is measured**: out of the 1,389 names defined by the 40 library
files, **only 41 appear in more than one file, that is 2%** — and the most frequent of those are the
prefixes `ba`, `ma`, `si`, `fi`, redeclared by every file, not functions. Real collisions are
therefore rare, and the prefix stays available to resolve them.

**What the base does not do**: it hides nothing. `fi.lowpass` can still be written, and any Faust
program that lays down its own imports behaves as before.


### What remains open

**What exactly the base contains.** All of Faust's libraries, or only those the catalogue declares
modules from? The question will settle itself in use: loading 1,389 names automatically in order to
use twelve of them is a drawback only if the collisions get in the way, and they run at 2%.

---

## What the first programs revealed — 2026-08-06

Three complete programs were written to put the review to the test, and their Faust translations
compile (`examples/`). Six gaps came out of it; five are filled, one is set aside.

**The bank index.** `let clic:6 …` laid down six **identical** instances, and Faust reduces six
identical circuits to one. Without a rank, a bank does not exist. `i` is taken over from Faust's
`par(i,6,…)`: `let clic:6 resonbp(fc:311 * 1.5^i, Q:60)`.

**The channels of `process`.** The review named the inputs and forgot the outputs, which made every
piece mono. `process` is an instance, so the dot rule applies to it: `rev1.1 : process.1`. It was a
writing oversight, not a decision.

**Putting a bypassed module back.** `_ lpf1` short-circuited with no way back. `!_ lpf1` follows from
the `!` rule, which cancels the sign it precedes.

**What `!` removes.** `! lpf1` removes the module **and its cables**; the instance remains and its
name stays taken. Giving the name back requires `!let`.

**Cutting puts silence in.** The gesture `basse !: vcab` did not silence a branch when the module had
two inputs: the adaptation rule broadcast the other input, and the branch went on sounding. **A cut
wire does not remove the input, it puts zero into it** — the width does not change, and the expected
silence happens.

**Rescaling.** An LFO swinging from -1 to 1 patched into a cutoff frequency had no useful effect.
Faust carries the function — `it.remap(from1, from2, to1, to2)`, whose documentation gives as an
example *"an oscillator rescaled from [-1, 1] to [100, 1000]"*. FaustX places it between the two when
both ranges are known, and lets the signal through as it is otherwise: **nothing is guessed**.

**What is set aside: insertion into a chain that is playing.** Slipping a filter between two modules
already connected takes three lines, during which the sound goes through both paths. Faust has
nothing of the kind — it describes an entire circuit, it has no cable to modify — and no obvious
notation presented itself. **We write the three lines.** To be reopened if use shows the gesture
comes up often.

---

## What happens when the code is wrong — settled 2026-08-06


**What this imposes on the implementation: nothing touches the live graph before compiling.** The
module is compiled aside, and it replaces the old one only if the compilation succeeded. The thirty
milliseconds are therefore paid **before** the substitution, never during it.

| where the error arises | what happens |
| --- | --- |
| the line does not parse | the gesture is refused, the graph is intact |
| an unknown name, a port that does not exist | the gesture is refused, the graph is intact |
| Faust refuses the program produced | the gesture is refused, the graph is intact |

**In all three cases the rule is the same**: the faulty gesture does not take place, the error is
returned to whoever wrote it, and what was playing goes on playing, without one missing sample.


---

## What FaustX does not do

**FaustX computes nothing.** All computation is Faust, compiled by Faust.

**FaustX does not know the channels of the stage.** Its sink is `process`, Faust's own, and the
program sounds on its own; whatever connects its inputs and outputs to devices or to an actor's
channels belongs to the host, never to the language.

**FaustX does not know musical time.** When a gesture happens is decided by the scheduler that
invokes it.

---

## The implementation

### FaustX translates — settled 2026-08-06

**FaustX produces Faust, and does not extend the compiler.** Faust never sees an instance name: it
receives a program where each instance is a distinct circuit, the sharing drawn with `<:` and `:>`,
and each port laid down as a control in the group that bears the name.

**The condition set was the overhead**, since the target is live performance. It can be measured, and
it comes in three items. The measurements that decide are taken where the sound will be made: the
compiler built for WebAssembly, which is what a browser host runs.

**1. Translating costs nothing.** The operation works on a few dozen lines of text, against a
compilation that takes thirty milliseconds at the very least.

**2. A gesture recompiles one module, never the program.**

Measured by `tools/measure-compilation.mjs`, which anyone can rerun: median of twelve compilations
after three warm-up rounds, the compiler cache defeated on every round. Figures are rounded, because
they move by a good tenth from one run to the next.

| what gets recompiled | in the browser | natively, same backend |
| --- | --- | --- |
| one module alone | **~32 ms** | ~30 ms |
| a program of 5 modules | ~64 ms | ~60 ms |
| a program of 20 modules | ~200 ms | ~185 ms |
| a program of 50 modules | **~620 ms** | ~520 ms |

The first column goes through libfaust-wasm 0.16.6 (Faust 2.86.2) in the running process; the second
is Faust 2.70.3 on the command line with the same WebAssembly backend, its 34 ms of process startup
measured separately and subtracted. **Compiling in the browser costs about what it costs natively** —
which is the figure that matters, since the browser is where this will be played.

**The ratio is what decides: around 19 times cheaper** (17 to 21 across runs). A gesture that
recompiled everything would be
unplayable beyond ten modules or so; a gesture that recompiles only the module touched stays under
the threshold of perception, and the substitution happens in the live graph with no break in the
sound.

**So a `let` is a compilation unit.** This is not a free implementation choice: the measurement
imposes it, and it is what makes live performance practicable.

**And these thirty milliseconds are the worst case, not the common one.** A module whose body is known is
compiled **ahead of time**: when the piece is loaded, or while the musician is typing. All that stays
on the critical path is the body written at that very moment — the one no anticipation can cover.

**3. What the separation and the ports cost in computation, permanently.**

| item | measured overhead |
| --- | --- |
| compiling per module instead of one block | **+12.9%** operations (Faust no longer optimizes across modules) |
| a controlled port instead of a constant | **+17%** operations on a 3rd-order filter |
| the instance name itself | **0** — an interface group is a label |


**Reading the total**: roughly 30% more computation than a monolithic Faust in which everything is
constant, in exchange for hot patching. That is below what any object-graph modular system costs.

### What Faust already provides

**Hot patching requires no modification to the Faust compiler.** Faust already carries its five
combinators implemented at runtime on live instances (`architecture/faust/dsp/dsp-combiner.h`, 810
lines), plus a crossfade. What they lack is being **mutable**: the two composed DSPs are fixed in the
constructor. **A mutable subclass is modeled on the one that exists: 52 lines.**

**Gapless transition is already solved, twice over** — FaustLive and `faust2clap` reload a program
while it runs, with no break in the sound. The measured cost of an on-the-fly recompilation ranges
from **6 to 52 milliseconds** depending on the module (arXiv:2606.13193v1).

**A precedent for extending the language exists**: `nuchi/faust` adds `throw`/`catch` primitives in a
handful of commits, on a public branch.

**None of this requires forking Faust**: the subclass is written on our side, which preserves the
license exception on the 304 architecture files — valid **on the condition that they are not
modified**.

---

## The license

**The Faust compiler is under LGPL 2.1** (`COPYING.txt`). **The generated code is not contaminated**
— GRAME's FAQ says so: *"The LGPL license of the compiler doesn't apply to the code generated by the
compiler."*

**The libraries declare a license PER FUNCTION** (`filters.lib`), most of them LGPL 2.1, some STK
4.3, of the permissive kind.

**This repository is not affected by the open question of the embedded compiler.** FaustX produces
Faust text and embeds no compiler; the question of what its license imposes on software that would
include it concerns whoever compiles, not the language.

---

## What is still to be decided

| point | who decides |
| --- | --- |
| *(nothing on the language as of today)* | |

**The signs, for their part, are settled**: `let` lays down, the name alone replaces, `!let` gives
back, `!` cancels the sign it precedes, a digit gives the width, the dot takes from an instance.

**What the community has not asked for**: neither cutting nor multi-cable has an open issue. The only
one on dynamic patching is **#685**, open since 2021 and never resolved. **The slot is free.**
