# Contributing Guide

## Before proposing a sign

FaustX **decorates Faust's signs, it does not invent others**. Ask first: *does it decorate
something that exists in Faust?* If not, it goes out. The design of each sign is in
[`docs/faustx-specification.md`](docs/faustx-specification.md).

FaustX computes nothing (all DSP is Faust), knows nothing of its host, and never modifies
the Faust compiler.

## Development Setup

Prerequisites: Node.js >= 22, the Faust compiler (`faust`) on the `PATH` for the tests.

```bash
npm install
npm test
```

| Command | Description |
|---------|-------------|
| `npm test` | Run the test suite (Vitest) |
| `npm run test:coverage` | Tests with coverage |
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
