# FaustX — principles

## Moved from the design journal, to be rewritten

<!-- moved from faustx-specification.md, "What FaustX adds" -->

**FaustX is a superset of Faust.** Every Faust program is a FaustX program. This document says **what
FaustX adds**, and nothing else.

<!-- moved from faustx-specification.md, "What Faust does" -->

**FaustX adds no computing function.** What Faust lacks in order to patch live is not a function, it
is two manipulations.

<!-- moved from faustx-specification.md, "1. The definition" -->

**`let` is the only exception to the principle of notation**, and it is justified: Faust already
carries `letrec`, and it is the most classical word there is for single binding.

<!-- moved from faustx-specification.md, "1. The definition" -->

**The `!` cancels the sign it precedes.** One rule, two uses: `saw1 !: lpf1` cancels the connection,
`!let lpf1` cancels the binding.

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**Patching without counting.** A musician patching while it plays does not work out multiples; a
width that does not come out even must not stop the music.

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**No valid Faust program changes meaning** — FaustX only accepts what Faust used to reject.

<!-- moved from faustx-specification.md, "2. The five combinators" -->

**Two decorations, learned once, valid everywhere: a `!` in front cancels, a digit after gives the
width.** That is what separates a rule from three lucky finds — the `!` already serves on binding,
`!let`.

<!-- moved from faustx-specification.md, "3. The routing primitives" -->

**This is what replaces the `on` and `off` keywords of the first draft.** A keyword decorates
nothing; `_` and `!` are primitives Faust already carries. **The gesture costs no new sign.**

<!-- moved from faustx-specification.md, "5. The iterators" -->

**`seq`, `sum` and `prod` get no decoration.** Putting eight copies in series, adding them or
multiplying them are writing constructions, not gestures: they are laid down once and do not change
while you play. They stay available exactly as they are.

<!-- moved from faustx-specification.md, "6. The interface parameters" -->

This is the only place in the language where two notations do the same thing, and it is owned:
without it, Faust's 1,002 public functions would be out of reach until a declaration covers them.

<!-- moved from faustx-specification.md, "7. The entry point" -->

**The `out` of our first drafts does not belong to FaustX.** It comes from the host stage — *"the
sink of a chain designates the actor's output, whose channel is declared elsewhere"* — and FaustX
knows neither actor nor channel. Writing it here would mean inventing a sign Faust does not have,
which the principle of notation forbids.

**A host stays free to define `out`** as another name for `process`; that is no business of the
language.

<!-- moved from faustx-specification.md, "What happens when the code is wrong" -->

**An error is reported, and the sound does not stop.** This is an absolute rule, and it is the one
that separates a live language from a studio language.

**Faust does the opposite, and it is right to**: an arity mismatch, an unknown name, a non-constant
parameter stop the compilation and produce no program at all. In the studio, that is what you want.
In concert, a compiler that refuses to return a program would leave the room in silence.

<!-- moved from faustx-specification.md, "What happens when the code is wrong" -->

**What this does not cover**: a correct line that produces a wrong sound. Feedback written without a
mistake is still feedback — FaustX checks that the code is valid, not that the music is good.
