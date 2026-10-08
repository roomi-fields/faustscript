# FaustScript — the frame

Translation of CADRE.md; the French text decides.

FaustScript is a superset of Faust for live coding, and its transpiler: it reads a FaustScript text line by line, applies each line as a gesture on a living graph of named instances, and writes the Faust that the graph describes. The package `faustscript` (`packages/040-faustscript`) carries that boundary: a host creates one session per piece, sends it text, and compiles and plays the Faust it returns with the faustwasm version the package declares.

## 1. Role

- **R1.** FaustScript translates FaustScript text into Faust text: the whole program of the graph, and, for a gesture that changes an instance's circuit, that instance's Faust alone.
- **R2.** FaustScript holds the state of a piece as a graph of instances and wires, one graph per session; a line of text is the only way to change it.

## 2. Receives

- **R3.** At the creation of a session, the number of channels of its master bus; the catalogue belongs to the library, which reads it once for every session.
- **R4.** Then, FaustScript text, as the author wrote it, one or more lines at a time.

## 3. Returns

- **R5.** For each line that carries a statement, in order: the line, the gesture, the instance it touched, and either its outcome or its refusal; for a gesture that recompiles, the instance's Faust and the instances that Faust cites; for a Faust definition, the instances to recompile; for a setting, the port, the value and the control path. A blank line or a comment returns nothing.
- **R6.** On request, the whole Faust program of the graph at that instant, a frozen view of the graph, the list of the program's controls with their paths, bounds, units, starting values and smoothing, and the catalogue as a frozen value that marks the modules faustwasm does not provide.
- **R17.** For an editor, the parser of the grammar, and what a text would do on the session that plays: its refusals as diagnostics of the Language Server Protocol, without changing the session.

## 4. Knows

- **R7.** Faust's syntax and the modules its libraries declare, with their parameters, starting values and bounds, through the catalogue, generated from the libraries of the faustwasm version the package declares.
- **R8.** The signs of FaustScript, through the grammar that generates its parser and through the templates.

## 5. Does not know

- **R9.** The host, the audio context, musical time, scenes and the consumers of its package; the Faust compiler at run time, which the host calls.

## 6. Refuses

- **R10.** A line that does not read, an empty expression, an unknown form, a name already placed, a name that does not exist, a module that faustwasm does not provide, a setting that is incomplete or targets a port the instance does not carry (a parameter of its module, or a `key=value` its author named in its Faust body), a port driven by a signal that carries one of the program's inputs, a wire that does not exist, a Faust definition of an instance's name or an instance on a Faust definition's name, a master bus given parameters, a range of channels past a width: the refusal carries a fault with the fields of BPScript's: a stable code, a sentence that names the cause and the name involved, the values it is written from, and the position of the writing at fault; the line changes nothing.
- **R11.** An error the Faust compiler raises on the Faust FaustScript writes stays the compiler's message; the host receives it from the compiler.

## 7. Invariants

- **R12.** The same text, in the same order of gestures, gives the same result, to the character.
- **R13.** A refused line leaves the graph as it was.
- **R14.** The signs of the language live only in the grammar and in the files under `lib/`, which the code reads.
- **R15.** All signal computation belongs to Faust, which FaustScript leaves as GRAME publishes it; its output is Faust that the declared faustwasm version compiles.
- **R18.** The frozen catalogue is the only state the sessions share.

## 8. Cost

- **R16.** One applied line has a measured cost, and a ceiling that only goes down. A gesture that recompiles returns one instance's Faust, so that the host compiles one instance instead of the program.
