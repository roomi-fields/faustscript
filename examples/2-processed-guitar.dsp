// Faust translation of `2-processed-guitar.fx`, written by hand.
// Verified: faust -lang c 2-processed-guitar.dsp -o /dev/null
//                 -I /home/romi/dev/bp/faust-upstream/faustlibraries
//
// What the translation shows:
//   - the two inputs become the two arguments of a function, in the order of
//     the `let ... _` lines: `g` is input0, `p` is input1;
//   - an instance going to two destinations becomes `<:`, and the two cables
//     coming back onto `process` become `:>`;
//   - `corps1` has to be written inside the function, because its `fc` port
//     depends on an input: FaustX cannot emit it as a top-level definition,
//     unlike every other instance.
//
// THREE DEPARTURES OWNED:
//   1. `N:3` frozen by hand (see program 1).
//   2. The bounds / the scale / the unit declared on `corps1.fc` appear
//      nowhere: a port driven by a signal emits no control, so the scaling is
//      written in hard.
//   3. Numeric-entry bounds invented (see program 1): (0, 1e6) when the
//      starting value is positive, (-1e6, 1e6) otherwise. This is no detail
//      -- with a negative minimum, `ef.echo` refuses to compile:
//      `possible negative values [...] used in delay expression`. The rule
//      the specification leaves open therefore decides whether the program
//      exists at all.

import("stdfaust.lib");

// --- the instances that depend on no input ----------------------------------

porte1 = vgroup("porte1", ef.gate_mono(nentry("thresh", -55,   -1e6, 1e6, 0.001),
                                       nentry("att[unit:s]", 0.001, 0, 1e6, 0.001),
                                       nentry("hold[unit:s]", 0.15, 0, 1e6, 0.001),
                                       nentry("rel[unit:s]", 0.05,  0, 1e6, 0.001)));

comp1  = vgroup("comp1", co.compressor_mono(nentry("ratio",  4,     0, 1e6, 0.001),
                                            nentry("thresh", -18,   -1e6, 1e6, 0.001),
                                            nentry("att[unit:s]", 0.005, 0, 1e6, 0.001),
                                            nentry("rel[unit:s]", 0.15,  0, 1e6, 0.001)));

drive1 = vgroup("drive1", ef.cubicnl(nentry("drive",  0.6, 0, 1e6, 0.001),
                                     nentry("offset", 0,   0, 1e6, 0.001)));

creux1 = vgroup("creux1", fi.resonhp(nentry("fc[unit:Hz]", 180, 0, 1e6, 0.001),
                                     nentry("Q",           0.8, 0, 1e6, 0.001),
                                     hslider("gain",       1,   0,    1,   0.001)));

// `maxDuration` sizes the delay line: the same gap as `N`, it has to be a
// constant. Emitted as a numeric entry, Faust answers
// `invalid delay parameter range: interval(1, 2.14748e+09)`.
dly1   = vgroup("dly1", ef.echo(2,
                                nentry("duration[unit:s]",    0.375, 0, 1e6, 0.001),
                                nentry("feedback",            0.42,  0, 1e6, 0.001)));

rev1   = vgroup("rev1", re.mono_freeverb(hslider("fb1",  0.86, 0, 1, 0.001),
                                         hslider("fb2",  0.66, 0, 1, 0.001),
                                         hslider("damp", 0.5,  0, 1, 0.001),
                                         nentry("spread", 17, 0, 1e6, 0.001)));

envoi1 = *(vgroup("envoi1", nentry("niveau", 0.3, 0, 1e6, 0.001)));
sortie = *(vgroup("sortie", nentry("gain",   0.8, 0, 1e6, 0.001)));

// --- the wiring -------------------------------------------------------------
// g = guitare, the guitar (input0), p = pedale, the pedal (input1)
// chaine = the chain, from the guitar to the two sends

corps1(p) = fi.lowpass(3, p * 3800 + 400);

chaine(g, p) = g : porte1 : comp1 : drive1 : creux1 : corps1(p) : dly1
                 <: (sortie, (envoi1 : rev1)) :> _;

process = chaine;
