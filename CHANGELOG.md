# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- The catalogue is generated from the libraries of the pinned `@grame/faustwasm` (0.16.6:
  libfaust 2.86.2, libraries 2.71.0), every module compiled and measured by that same Faust
  (`npm run catalogue`); its header records the versions and the module count, and
  `faustwasm.unavailable` marks a module faustwasm refuses to compile.

- Project tooling: Vitest replaces `node --test` (tests move to `tests/unit/`), ESLint,
  Prettier, EditorConfig, a TypeScript configuration ready for the migration, GitHub CI
  and release workflows.

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
