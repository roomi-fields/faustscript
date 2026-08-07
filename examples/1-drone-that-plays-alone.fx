// ============================================================================
// 1. A DRONE THAT PLAYS ON ITS OWN
//
// Three detuned sawtooths, a lowpass swept by a slow LFO, an envelope
// retriggered on the beat, a reverb, an output volume. No audio input at all:
// the program sounds by itself as soon as it is loaded.
//
// What it exercises in the specification:
//   - `let` and the ports the catalogue declares (elements 1 and 6)
//   - the bounds and the scale written once, at the declaration (element 6)
//   - several channels summing into one input: the three oscillators arrive
//     at a single filter (element 2, the adaptation rule)
//   - a port driven by a signal: `lfo1 : lpf1.fc` (element 3)
//   - `process` as the sink one connects to (element 7)
//
// GAP MET WHILE WRITING IT — see the report:
//   `N:3` is the filter order. Faust requires a compile-time constant there;
//   the specification gives no way of saying that a declared parameter is NOT
//   a port. Emitted as a slider, it makes the compilation fail. The
//   translation alongside therefore freezes `3` by hand.
//
// The instance names are the musician's own and are left untouched:
//   `bat1` is the beat (French *battement*), `vca1` the amplifier the
//   envelope opens, `vol1` the master volume.
// ============================================================================

let osc1 sawtooth(freq:110)
let osc2 sawtooth(freq:110.6)
let osc3 sawtooth(freq:55)

let lpf1 lowpass(N:3, fc:800)
    lpf1.fc.min:40
    lpf1.fc.max:12000
    lpf1.fc.scale:log
    lpf1.fc.unit:Hz

let lfo1 osc(freq:0.15) * 900 + 1100
let bat1 beat(t:96)
let env1 adsr(at:0.01, dt:0.35, sl:0.45, rt:1.4)

let vca1 *
let rev1 mono_freeverb(fb1:0.92, fb2:0.72, damp:0.45, spread:23)
let vol1 *(gain:0.35)

// the wiring
lfo1 : lpf1.fc
bat1 : env1.gate

(osc1, osc2, osc3) : lpf1
(lpf1, env1) : vca1 : rev1 : vol1 : process
