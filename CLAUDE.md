# FaustX

FaustX is a superset of Faust for live coding, and its transpiler: a line of FaustX places a named instance or acts on it while the sound plays, and the transpiler writes the Faust that the host compiles and plays. This repository carries the language and its transpiler, as one TypeScript library with its command line.

**Owner**: Romain. He validates `docs/LANGUAGE.md`, `docs/PRINCIPES.md`, `docs/ARCHITECTURE.md`, `docs/CADRE.md` and `docs/INTERFACE.md`; the supervisor validates the other documents.

## What decides

`docs/PRINCIPES.md`, then the specification (`docs/LANGUAGE.md`), then the frame (`docs/CADRE.md`, `docs/INTERFACE.md`, `docs/ARCHITECTURE.md`), then the code. A gap between the specification and the transpiler is a defect of the transpiler. A decision lives in the document it settles; a rule is affirmative, in the present, without date or author. `CONTEXT.md` gives each word of the domain its one sense.

- `docs/LANGUAGE.md` — how FaustX is written: read it before touching the grammar, a gesture or a translation.
- `docs/INTERFACE.md` — what crosses FaustX's boundary: read it before changing an export, a line's result or a refusal.
- `docs/CADRE.md` — FaustX's role and boundary (R1…): cite its rules in a ticket.

## The flow of a task

1. `bd ready`, `bd update <id> --claim`, read the ticket and the frame of what it touches.
2. A decision remains to be taken: `/grill-me` before writing, its questions in the ticket.
3. The plan goes in the ticket (`bd update <id> -d`), the work is done in `/tdd`. A commit that changes a behaviour corrects in the same commit every text that describes it.
4. The ticket closes on its targeted tests, the review (`mattpocock-skills:code-review`, which asks: does this notion already exist elsewhere?) and a commit.
5. `/handoff` in the ticket, then `bd close`, with what is not done and why.

A supervision session loads the supervisor (`pitmaster`); a development agent loads the developer (`grillardin`).

## What keeps the repository straight

- **Faust stays as GRAME ships it.** The licence exception on Faust's architecture files holds on the condition that they are unmodified; FaustX writes Faust and calls the compiler as published.
- **Signs live in the grammar and in `lib/`**, never in the code; a guard checks it.
- **A neighbour reads only FaustX's published package**, and FaustX reads only its neighbours' published packages. A consumer that needs a fresher state asks for a publication.
- **One subject, one address.** What a document already describes is poured into it.
- **A replacement deletes what it replaces** in the same commit, with its consumers and its guards.
- **A comment says what the thing is**, in the present.
- **A rule of this charter enters in place of another.** The charter fits on one page.

## Tools

- ⛔ **No command that can ask for a validation**: a prompt freezes the session. Every temporary file goes in the session scratchpad; no `cd` (`env -C <dir>` or `git -C`); a deletion targets a named path that was read.
- **The index first**: every exploratory search starts with `rtfm_search` (mode `hybrid`), then `rtfm_expand` on the relevant results.
- Tickets: Beads (`bd`), prefix `faustx-`, see `docs/agents/issue-tracker.md`.
- Repository skills: the supervisor (`pitmaster`), the developer (`grillardin`), initialisation and architecture (`grill`), measurement (`thermometre`), the writer for a human reader (`menu`), release (`release`). Flow: the `mattpocock-skills` plugin, prefix required; a document for an agent is written with `mattpocock-skills:writing-for-agents`.
- Answers in French; documents, code and API names in English.

## Commands

- `npm test` · `npm run typecheck` · `npm run lint` · `npm run format:check` · `npm run grammaire` (regenerates the parser from `src/faustx.grammar`).
- Conventional commits, message by file (`git commit -F`), trailer `Co-Authored-By: Claude`. Every commit is pushed.
