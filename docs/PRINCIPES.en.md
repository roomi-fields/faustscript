# FaustScript — principles

Translation of PRINCIPES.md; the French text decides.

This document states the directives that apply to the whole project: every reference document, every rule of the repository and every ticket conforms to them.

## 1. The language

- FaustScript is Faust for live coding. It adds what playing live requires and Faust lacks: placing a named instance, acting on it while the sound plays, and giving its name back. The computation of the signal stays that of Faust's functions.
- FaustScript stands to Faust as TypeScript stands to JavaScript. Every text that Faust's grammar accepts is a FaustScript text, with its Faust meaning. An addition occupies only a writing that Faust's grammar refuses, a syntax error: a symbol Faust does not define is still a writing Faust accepts, which a library can define later.
- Every sign of FaustScript is a sign of Faust, decorated. `=` gives a value and `:` connects, as in Faust; what surrounds the `:` qualifies it: `:8` over eight copies, `!:` cuts. The language consists of Faust's signs and their decorations.
- `let` is the one exception: Faust already carries `letrec`, and `let` is the most common word for a single binding.
- A decoration has one meaning in every position: a `!` in front cancels the sign it precedes, a number after says how many, a dot reaches into an instance. One rule that applies everywhere outweighs several separate signs.
- A decoration serves a gesture made while the sound plays. Faust's constructions that are written once — `seq`, `sum`, `prod`, substitution — stay as Faust writes them.
- A Faust writing always stays valid, and FaustScript adds at most one writing for the same act, a decorated one: `fi.lowpass(3, 800)` is Faust's call, `fi.lowpass(N=3, fc=800)` its FaustScript writing.
- Where Faust has a convention, FaustScript takes it: channels count from 1, the master bus is `process`, an input is `_`.
- FaustScript derives what it can derive: any other value passes as written.
- The sound goes on whatever the writing: widths adapt instead of being refused, and a refused line leaves the graph as it was while the rest applies. FaustScript checks the writing: an accepted line that sounds wrong stays accepted.

## 2. The transpiler

- The transpiler writes Faust, and Faust compiles it; all signal computation is Faust's. Its role and its boundary are in `packages/040-faustscript/docs/CADRE.md`.
- The signs of the language live in the grammar and in the files under `lib/`, read by the code; renaming a sign changes those files only.
- The catalogue is generated from Faust's libraries by `tools/`; it is corrected in its generator, then generated again.

## 3. The documents

- `LANGUAGE.md` is the specification: what it describes exists, and a gap between it and the transpiler is a defect of the transpiler. Its examples are executed by a test.
- A rule is affirmative, in the present, without date or author; it says what the thing is, with its reason.
- A piece of information lives at one address: another document that needs it cites it by a reference.

## 4. Arbitration

When two written rules contradict each other, the first force of this list that applies wins, and the choice names it. Two rules of the same force require a decision of the owner.

1. **Faust is the reference.** A writing that Faust reads keeps Faust's meaning. A statement about what Faust does cites its level: the compiler's execution, then its source, then its documentation.
2. **The sound goes on.** Between refusing a writing and giving it the meaning that keeps the sound going, the second wins when that meaning is unique.
3. **The signs are fixed.** The signs of the language are those of `LANGUAGE.md`; a new expressiveness composes existing decorations, and adding a sign is a decision of the owner.
4. **The dependency runs from the host to FaustScript.** What concerns the output devices, musical time, scenes or the substitution of a running instance belongs to the host, which knows FaustScript.
5. **One person maintains the project**, assisted by agents. At equal merit on everything else, the solution one person can maintain wins.
