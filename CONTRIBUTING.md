# Contributing Guide

## Before proposing a sign

FaustScript **decorates Faust's signs, it does not invent others**. Ask first: *does it decorate
something that exists in Faust?* If not, it goes out. The principles are in
[`docs/PRINCIPES.md`](docs/PRINCIPES.md).

FaustScript computes nothing (all DSP is Faust), knows nothing of its host, and never modifies
the Faust compiler.

## Development Setup

Prerequisites: Node.js >= 22. The tests compile with the Faust of `@grame/faustwasm`, installed by `npm install`.

```bash
npm install
npm test
```

| Command | Description |
|---------|-------------|
| `npm test` | Run the test suite (Vitest) |
| `npm run test:coverage` | Tests with coverage |
| `npm run references` / `-- --update` | Compare / engrave the reference outputs under `tests/references/`; `--update` goes in a commit that names the gap |
| `npm run lint` / `lint:fix` | Check / fix code style |
| `npm run format` / `format:check` | Format with Prettier |
| `npm run typecheck` | TypeScript check |
| `npm run grammaire` | Regenerate the parser from `src/faustscript.grammar` |
| `npm run catalogue` | Regenerate `lib/faust.fsc` from the libraries of the pinned `@grame/faustwasm`, every module compiled and measured by that same Faust (needs Python 3) |

The parser (`src/parser.js`, `src/parser.terms.js`) is generated: edit the grammar, never
the parser. The catalogue (`lib/faust.fsc`) is generated too: correct
`tools/generate-declarations.py`, never the catalogue; its header records the versions of
faustwasm, libfaust and the libraries it describes, and `tools/measured-ranges.json` keeps the
measured output ranges of that libfaust.

## Commit Guidelines

[Conventional Commits](https://www.conventionalcommits.org/): `feat`, `fix`, `docs`,
`style`, `refactor`, `perf`, `test`, `chore`.

## Testing

Tests live in `tests/unit/` (`*.test.js`). The guard test checks that no sign of the
language is written in the code: signs live in the grammar and the templates.
The old-name test checks that no file writes the language's old name or its old extension;
its header lists the places that may. A test reads `lib/` through `tests/unit/library.js`.
