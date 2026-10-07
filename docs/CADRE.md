# FaustX — the frame

FaustX is a superset of Faust for live coding, and its transpiler: it reads a FaustX text line by line, applies each line as a gesture on a living graph of named instances, and writes the Faust that the graph describes. A host creates one transpiler per graph, sends it text, and compiles and plays the Faust it returns.

## 1. Role

- **R1.** FaustX translates FaustX text into Faust text: the whole program of the graph, and, for a gesture that changes an instance's circuit, that instance's Faust alone.
- **R2.** FaustX holds the state of a piece as a graph of instances and wires; a line of text is the only way to change it.

## 2. Receives

- **R3.** At creation, the text of the catalogue (`lib/faust.fx`) and the text of the translation templates (`lib/translation.fx`).
- **R4.** Then, FaustX text, as the author wrote it, one or more lines at a time.

## 3. Returns

- **R5.** For each line, in order: the line, the gesture, the instance it touched, and either its outcome or its refusal; for a gesture that recompiles, the instance's Faust and the instances that Faust cites; for a setting, the port, the value and the control path.
- **R6.** On request, the whole Faust program of the graph at that instant, a frozen view of the graph, and the catalogue as a frozen value.

## 4. Knows

- **R7.** Faust's syntax and the 998 modules its libraries declare, with their ports, starting values and bounds, through the catalogue.
- **R8.** The signs of FaustX, through the grammar that generates its parser and through the templates.

## 5. Does not know

- **R9.** The host, the audio context, musical time, scenes and the consumers of its package; the Faust compiler at run time, which the host calls.

## 6. Refuses

- **R10.** A line that does not read, an empty line or expression, an unknown form, a name already placed, a name that does not exist, a setting that is incomplete, does not target a port or targets a port the instance does not carry (a port of its catalogue module, or a setting its author named in its Faust body), a setting driven by a signal that carries one of the program's inputs, a wire that does not exist: the refusal carries a stable code and a sentence that names the cause and the name involved, and the line changes nothing.
- **R11.** An error the Faust compiler raises on the Faust FaustX writes stays the compiler's message; the host receives it from the compiler.

## 7. Invariants

- **R12.** The same text, in the same order of gestures, gives the same result, to the character.
- **R13.** A refused line leaves the graph as it was.
- **R14.** No sign of the language is written in the code: the grammar and the files under `lib/` carry them.
- **R15.** FaustX computes no signal and modifies nothing of Faust; its output is Faust that Faust compiles.

## 8. Cost

- **R16.** One applied line has a measured cost, and a ceiling that only goes down. A gesture that recompiles returns one instance's Faust, so that the host compiles one module instead of the program.
