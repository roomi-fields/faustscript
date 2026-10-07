# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- The catalogue is generated from the libraries of the pinned `@grame/faustwasm` (0.19.0:
  libfaust 2.90.0, libraries 2.74.2), every module compiled and measured by that same Faust
  (`npm run catalogue`); its header records the versions and the module count, and
  `faustwasm.unavailable` marks a module faustwasm refuses to compile.
- The catalogue declares every function a documentation title of the libraries names, alone or
  grouped (`(ef.)cubicnl`, `(ef.)cubicnl_nodc`): 1170 modules, `tf2`, `fft` and `conv` among them.
- From the libraries 2.74.2: `os.osc` freq goes up to 12000 Hz (was 8000), `de.fdelay` n starts at
  512 samples on a log scale (was 44100), and `ba.selector` takes its channel as a constant.

- Project tooling: Vitest replaces `node --test` (tests move to `tests/unit/`), ESLint,
  Prettier, EditorConfig, a TypeScript configuration ready for the migration, GitHub CI
  and release workflows.

### Fixed

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

[Unreleased]: https://github.com/roomi-fields/faustx/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/roomi-fields/faustx/releases/tag/v0.1.0
