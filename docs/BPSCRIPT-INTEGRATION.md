# FaustX inside BPScript — the integration sheet

**BPScript consumes FaustX as a library.** A language module of BPScript, written in the BPScript
repository, calls FaustX's exports, compiles the Faust they return and plays it in the host's audio.
FaustX stays what its charter says: it knows no host, computes nothing, and modifies nothing of Faust.

This sheet says what that module reads from FaustX, what reaches FaustX and from whom, and how
BPScript drives a control in time. It names BPScript's own documents by their address and does not
copy them: a path starting with `bp-mono/` lives in the BPScript repository, `~/dev/bp-mono`; any
other path is this repository's.

---

## 1. Who does what

| | owns |
| --- | --- |
| **FaustX** (this repository) | the language, the transpiler, the catalogue, the gestures and their refusals |
| **the FaustX module** (BPScript, series 800) | compiling the Faust, substituting a living module, the fade, the audio connection, the time |
| **BPScript's chain** | when a code plays, for how long, with which values; the tuning, the random draws |
| **the host** (browser page, or `bp-mono/packages/910-host-node`) | the audio context, the clock, the page |

**The FaustX module does not exist yet.** It follows the two language modules already built,
`bp-mono/packages/810-strudel` (sound) and `bp-mono/packages/830-hydra` (image): each has a `CADRE.md`, an
`INTERFACE.md` and an `ARCHITECTURE.md` under `docs/`, and implements `LanguageModule`
(`bp-mono/packages/000-forms/docs/INTERFACE.md` §8.3). The rule that gives every guest language its own
package is `bp-mono/packages/800-evaluator/docs/CADRE.md` R2.

**BPScript receives FaustX by its published package**, under the package name `faustx`, never from
this repository's working tree; a module that needs a fresher state asks FaustX to publish.

**The dependency goes one way.** The module imports FaustX; nothing in FaustX imports, names or
tests for BPScript. A need of the module that FaustX cannot meet with a host-free function goes back
to the BPScript side, or becomes a question for Romain (§6).

---

## 2. What the module reads from FaustX

The module reads the three exports of `package.json` and the two files under `lib/`. Each of them is
a contract with a living consumer: a change to a name, a field, a gesture or a message is a breaking
change, and it goes in `CHANGELOG.md` under *Changed*.

**`createTranspiler(catalogueText, templatesText)`** — from `.`. The module reads `lib/faust.fx` and
`lib/translation.fx` and passes their text; the files ship in the package (`files`). One transpiler
holds one graph: its state is the living piece.

**`apply(text)`** returns one result per line, in order:

| field | meaning for the module |
| --- | --- |
| `line`, `text` | where a refusal points, for the fault BPScript shows the author |
| `outcome.done`, `outcome.reason` | applied, or refused with nothing changed |
| `gesture` | `place`, `replace`, `release`, `remove`, `bypass`, `set`, `wire` |
| `name` | the instance the gesture touched; `null` for a wire |
| `faust`, `needs` | for a gesture that recompiles: that instance's Faust alone, and the instances it cites |

The module acts on `gesture`, never on the shape of the line: it recompiles only the instance a
`place`, `replace`, `bypass` or `remove` returns, and the ~32 ms per module against ~620 ms for a
fifty-module program (`README.md`, *Status*) is what makes a gesture playable on the beat.

**`write()`** returns the whole Faust program of the graph at this instant. The module compiles it
at the first installation, and whenever a gesture cannot be compiled alone.

**The catalogue** — `readCatalogue` from `./catalogue` — gives each module's parameters, starting
values and bounds. The module reads it to tell the author which ports exist and what range each
port takes.

**The control path.** An instance's name becomes a Faust group, and a port a slider inside it:
`let lpf1 lowpass(fc:800)` gives `vgroup("lpf1", … hslider("fc…", 800, 2, 8000, …))`, the path
`/lpf1/fc`. A `set` gesture compiles nothing: the module writes the value on the running circuit
through that path. The instance name is the musician's word, kept as written, and that is what lets
a BPScript address reach it.

**The refusal.** A refused gesture's `reason` reaches the author as written: the module raises it as
an exception, and `bp-mono/packages/800-evaluator` turns it into the fault `EVAL_CODE_FAILED`, the message
as its reason (`bp-mono/packages/810-strudel/docs/INTERFACE.md` §2 shows the same path). A reason is
therefore an English sentence that names the cause and the name involved: `lpf1 does not exist`.

**The types.** BPScript type-checks every package strictly. The exported surface reaches it with its
types, which the migration to TypeScript provides.

---

## 3. What reaches FaustX

**Text, and nothing else.** The module passes FaustX the text of a code, as the author wrote it
between backticks, plus the two `lib/` files. FaustX receives no time, no clock, no random, no
host object, no audio context.

**BPScript provides the whole context of a guest code, to the module**
(`bp-mono/spec/LANGUAGE.md` §28, « Le code entre accents graves »):

- the time, by the duration of the code's event: a code plays from its event's start, for its
  duration, and the scene's tempo reaches it through that duration;
- the random, by the function `random`, drawn on the chain's single generator; a code itself reads
  neither the hour nor any random;
- the inputs: a running code receives `duration` (seconds), `controls` (each value of the event's
  modulation under its address) and `level` (`bp-mono/packages/150-sounding/docs/INTERFACE.md`,
  `codeInputs`);
- the tuning: a function name → hertz from the playing actor's pitch system, `hertz("E4")`
  (`bp-mono/packages/001-kernel/docs/INTERFACE.md`, « Les outils d'un code hébergé », `hertzLayer`).

**The determinism rule** (`bp-mono/spec/LANGUAGE.md` §28): with the same text, the same libraries and the
same seed, BPScript plays the same thing, to the bit. It protects an author of good faith; isolation
against a hostile code is a separate project. A FaustX result that depends only on the text it is
given, and on the order of the gestures, keeps that rule.

**The module runs a code with BPScript's hosted-code tools** (`bp-mono/packages/001-kernel/docs/INTERFACE.md`,
« Les outils d'un code hébergé »): `callAt` for an instant on the clock, `hertzLayer`, `actOn` and
`OperationNotOffered` for an action's body, a refusal list (`Refusals`, `refusedNames`,
`closedLayer`) for names a language must hide, and the scope layers in the order
`[{ self }, members, hertz]` for an action's body. `hostedCompiler` compiles JavaScript; which of
these tools a FaustX code needs is the module's choice (§6).

---

## 4. How BPScript drives a FaustX control in time

**The place of a code says what it does** (`bp-mono/spec/LANGUAGE.md` §28):

- at the head of the scene, a code prepares its interpreter at loading: the module's `prepare`;
- alone in a sequence, a code is a terminal that plays at its instant, for its duration, by its
  actor: the module's `run` returns a running code, and `bp-mono/packages/150-renderer-codevoices` calls its
  `start(at)` and `stop(at)` (`bp-mono/packages/000-forms/docs/INTERFACE.md` §8.3, `RunningCode`);
- inside a value, a code returns that value.

**The module turns an instant into a gesture.** It applies a FaustX line, or writes a control by its
path, at the host instant BPScript gives, through the read-only clock (`ClockView`,
`bp-mono/packages/000-forms/docs/INTERFACE.md` §8.4) and `callAt`. FaustX applies the line when it is called;
"when" is the module's, as the charter says.

**A value that moves in time** is a BPScript signal (`bp-mono/spec/LANGUAGE.md` §25, « Les variables »:
`signal`, `phase`, `logic`) with a mode (`bp-mono/spec/LANGUAGE.md` §48, « La cascade »: `fixed`, `step`,
`cont`). It reaches a running code under `controls`, by its address. Writing such a value on a
FaustX port is a `set` on the port's path, at each instant the module samples.

**The earlier design** drove an effect parameter as a polymetric voice beside the melody,
`{ alap jor jhala , sitar.lpf.cutoff(ramp(200, 8000)) }`, with scopes scene → actor → terminal
(`~/dev/bp/BPscript/docs/design/EFFECTS.md`, read-only). BPScript records the return of effects and
continuous values with FaustX as an open risk (`bp-mono/docs/ARCHITECTURE.md` §10): the form is not written
yet (§6).

---

## 5. What the module needs and FaustX does not return yet

Measured on the current `src/`, with `apply` on `let lpf1 lowpass(fc:800)` then `lpf1.fc:400` and
`lpf1.nope:3`:

- a `set` result carries the gesture and the instance, not the port, the value or the path: the
  module has to read them back from the graph and rebuild the path the emitter writes;
- `lpf1.nope:3` comes back applied, while `docs/ARCHITECTURE.md` (*When the code is wrong*) says a
  port that does not exist is refused by the graph.

---

## 6. Open questions

None of these is settled. Each goes to Romain; an agent that meets one stops and asks.

1. **What FaustX is to BPScript.** A guest language among the others (a tag in
   `bp-mono/libraries/eval.bpsl`, a package of series 800), or a distinct component of the chain that also
   checks the wiring of its modulations, as `bp-mono/docs/ARCHITECTURE.md` §10 phrases it, with effects
   shared by actors, tracks and sends?
2. **How a scene writes FaustX.** The tag (`fx:` in an earlier note, `faustx:`), and its places: a
   head code that places the modules, a code in a sequence that acts on them. No writing is decided.
4. **The package's number and name** in series 800.
5. **What one graph covers.** One transpiler per scene, per actor, or per session; and what happens
   to the graph when the author edits the scene while it plays.
6. **The address of a FaustX control from BPScript.** `sitar.lpf1.fc`, a scene-level `lpf1.fc`, or
   an occurrence's setting; and who scales a BPScript value to the port's bounds, BPScript's units
   or FaustX's `it.remap`.
7. **A continuous value.** A `cont` signal sampled by the module and written by path, or a ramp
   compiled into Faust (`si.smoo`, an envelope) — and where its rate is chosen.
8. **What a `set` gesture returns** (§5): the port, the value, the full path.
9. **The full control path** inside libfaust compiled to WebAssembly: the prefix the compiled
   program adds above `/lpf1/fc`, never measured.
10. **The context inside a FaustX text.** How `hertz`, `duration` and `controls` reach a FaustX
    code, since FaustX has no host function; and whether Faust's noise generators, seeded inside
    Faust, keep `bp-mono/spec/LANGUAGE.md` §28 when a module starts at a different instant.
11. **The audio routing.** What `process` feeds (the actor's output, the host's destination,
    `AudioTarget` in `bp-mono/packages/000-forms/docs/INTERFACE.md` §8.7), and what an input `_` receives.
12. **The fade and the substitution.** FaustX leaves both to the host (`docs/ARCHITECTURE.md`,
    *What is left*): the module carries them, by Faust's runtime combiners or otherwise.
13. **The checks that Dédale owned.** The earlier resolver `~/dev/bp/dedale` checked a patch
    against the catalogue, held the name → instance table and composed modules hot. FaustX's graph
    already holds the table; where the rest lives is open.
