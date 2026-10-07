# Contributing Guide

## Before proposing a sign

FaustX **decorates Faust's signs, it does not invent others**. Ask first: *does it decorate
something that exists in Faust?* If not, it goes out. The principles are in
[`docs/PRINCIPES.md`](docs/PRINCIPES.md).

FaustX computes nothing (all DSP is Faust), knows nothing of its host, and never modifies
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
| `npm run grammaire` | Regenerate the parser from `src/faustx.grammar` |

The parser (`src/parser.js`, `src/parser.terms.js`) is generated: edit the grammar, never
the parser.

## Commit Guidelines

[Conventional Commits](https://www.conventionalcommits.org/): `feat`, `fix`, `docs`,
`style`, `refactor`, `perf`, `test`, `chore`.

## Testing

Tests live in `tests/unit/` (`*.test.js`). The guard test checks that no sign of the
language is written in the code: signs live in the grammar and the templates.
