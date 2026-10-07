# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- `=` gives a value and `:` only connects: `fi.lowpass(fc=800)`, `lpf1.fc = 400`,
  `lpf1.fc.min = 20`, and the catalogue declares `fi.lowpass(N=4, fc=2000)` and `fc.unit = Hz`.
  On a wiring line a number after `:`, stuck or spaced, counts copies (`saw1 : 8 lpf1`); spacing
  no longer changes what a sign means. A minus sign before a number is negative where a term is
  awaited, and subtracts after a term (`10 -5`).
- A Faust definition (`gain = 0.5;`, `voice(f) = …;`), an `import` and a `declare` are read as
  Faust up to their `;`, over several lines, and written as they are; `let = 1;` is one of them. A
  call by name inside a definition takes its values as constants. `process = expr;` is one more
  source into the sink, summed with the wires; a new one replaces it.
- FaustX is renamed FaustScript: the package and the command are `faustscript`, a file of the
  language ends in `.fsc` (`lib/faust.fsc`, `lib/translation.fsc`, `examples/*.fsc`), the grammar
  is `src/faustscript.grammar`, and a block of the language in a document is fenced `faustscript`.
  The repository is `roomi-fields/faustscript` and the site `roomi-fields.github.io/faustscript`.
- The catalogue is generated from the libraries of the pinned `@grame/faustwasm` (0.19.0:
  libfaust 2.90.0, libraries 2.74.2), every module compiled and measured by that same Faust
  (`npm run catalogue`); its header records the versions and the module count, and
  `faustwasm.unavailable` marks a module faustwasm refuses to compile.
- The catalogue declares every function a documentation title of the libraries names, alone or
  grouped (`(ef.)cubicnl`, `(ef.)cubicnl_nodc`): 1172 modules, `tf2`, `fft` and `conv` among them.
- A module is written under its Faust name, prefix included: `let lpf1 fi.lowpass(fc=800)`. The
  catalogue declares `fi.lowpass`, and both `ma.SR` and `pl.SR`; a name without
  its prefix in a body is refused, `lowpass is not a module; fi.lowpass is`.
- A call that passes an argument without its name keeps Faust's order and meaning:
  `fi.lowpass(3, 800)` is Faust's call.
- From the libraries 2.74.2: `os.osc` freq goes up to 12000 Hz (was 8000), `de.fdelay` n starts at
  512 samples on a log scale (was 44100), and `ba.selector` takes its channel as a constant.

- Project tooling: Vitest replaces `node --test` (tests move to `tests/unit/`), ESLint,
  Prettier, EditorConfig, a TypeScript configuration ready for the migration, GitHub CI
  and release workflows.

### Fixed

- A line the grammar reads only in part is refused, `does not read: <line>`, and changes nothing;
  `let = 1;` no longer throws.
- A call in Faust's order that names one of its arguments keeps its other arguments:
  `fi.lowpass(3, cutoff=800)` writes `fi.lowpass(3, nentry("cutoff", …))`.

- A module without a width line in the catalogue has no width: reading no longer gives it the
  next module's, and generation no longer gives a module faustwasm refuses (`rnoises`) the
  widths of a form that only hides the refused call.

## [0.1.0] - 2026-08-07

### Added

- The language: definition, the five composition operators, routing primitives,
  substitution, iterators, interface parameters, entry point, imports.
- The transpiler: FaustX → Faust, a parser generated from `src/faustx.grammar`, the
  catalogue of Faust's 998 declared functions.
- A command line (`faustx`) and a library entry point.
- Live gestures: each one says what it touched and carries only the Faust that changed.

[Unreleased]: https://github.com/roomi-fields/faustscript/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/roomi-fields/faustscript/releases/tag/v0.1.0
