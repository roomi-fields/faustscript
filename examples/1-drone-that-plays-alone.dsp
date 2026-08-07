// Faust translation of `1-drone-that-plays-alone.fx`, written by hand.
// Verified: faust -lang c 1-drone-that-plays-alone.dsp -o /dev/null
//                 -I /home/romi/dev/bp/faust-upstream/faustlibraries
//
// What the translation shows:
//   - every instance becomes a distinct Faust definition;
//   - every port becomes a control enclosed in a `vgroup` bearing the
//     instance's name, hence the paths /osc1/freq, /rev1/damp, and so on;
//   - a BOUNDED port becomes a slider, an UNBOUNDED one a numeric entry
//     (element 6's rule);
//   - a port driven by a signal EMITS NO control at all: `lpf1.fc` receives
//     `lfo1`, so the slider disappears -- and its bounds, its scale and its
//     unit, written just above, are of no use any more;
//   - the three oscillators arriving at `lpf1` become `:>`.
//
// WHAT IT CONTRADICTS IN THE SPECIFICATION, AND IT IS VERIFIED:
//   element 1 promises that "the name prefixes the control paths" and that
//   `/lpf1/cutoff` is unique with no effort. The compiled program gives
//   `/env1/bat1/t` and `/lfo1/freq` -- `bat1` is a named instance, and its
//   control is NOT at `/bat1/t`: it lands in the group of whoever consumes
//   it, because a Faust group is lexical. An instance read by two consumers
//   would have two paths, and none under its own name.
//
// TWO DEPARTURES OWNED, both for want of a rule in the specification:
//   1. `N:3` is written as a hard `3`: Faust requires a compile-time
//      constant for a filter order, and `fi.lowpass(hslider(...), fc)`
//      answers `stack overflow in eval`.
//   2. The bounds of the numeric entries (0, 1e6, 0.001) are invented here:
//      the specification says an unbounded port becomes a numeric entry, but
//      not which four numbers Faust receives.

import("stdfaust.lib");

// --- the instances ----------------------------------------------------------

osc1 = vgroup("osc1", os.sawtooth(nentry("freq[unit:Hz]", 110,   0, 1e6, 0.001)));
osc2 = vgroup("osc2", os.sawtooth(nentry("freq[unit:Hz]", 110.6, 0, 1e6, 0.001)));
osc3 = vgroup("osc3", os.sawtooth(nentry("freq[unit:Hz]", 55,    0, 1e6, 0.001)));

lfo1 = vgroup("lfo1", os.osc(nentry("freq[unit:Hz]", 0.15, 0, 1e6, 0.001)))
       * 900 + 1100;

bat1 = vgroup("bat1", ba.beat(nentry("t", 96, 0, 1e6, 0.001)));

// lpf1: `fc` is driven by lfo1, so no control at all; the order is frozen.
lpf1 = fi.lowpass(3, lfo1);

env1 = vgroup("env1", en.adsr(nentry("at[unit:s]", 0.01, 0, 1e6, 0.001),
                              nentry("dt[unit:s]", 0.35, 0, 1e6, 0.001),
                              nentry("sl",         0.45, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 1.4,  0, 1e6, 0.001),
                              bat1));

vca1 = *;

rev1 = vgroup("rev1", re.mono_freeverb(hslider("fb1",  0.92, 0, 1, 0.001),
                                       hslider("fb2",  0.72, 0, 1, 0.001),
                                       hslider("damp", 0.45, 0, 1, 0.001),
                                       nentry("spread", 23, 0, 1e6, 0.001)));

vol1 = *(vgroup("vol1", nentry("gain", 0.35, 0, 1e6, 0.001)));

// --- the wiring -------------------------------------------------------------

process = ((osc1, osc2, osc3) :> lpf1), env1 : vca1 : rev1 : vol1;
