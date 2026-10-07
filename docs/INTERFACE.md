# FaustX — interface

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

