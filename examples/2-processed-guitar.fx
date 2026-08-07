// ============================================================================
// 2. A GUITAR THAT COMES IN AND GOES OUT
//
// Two real inputs: the guitar and an expression pedal. The guitar goes
// through a noise gate, a compressor, a saturation, a notch in the low end
// and a lowpass whose frequency the pedal opens; then a dotted-eighth delay,
// whose output goes both to the master volume and to a reverb send.
//
// What it exercises in the specification:
//   - the named input, `let guitare _` (element 7) and the declaration order
//     that decides which one is input0;
//   - the series chain between instances, just as it is (element 2);
//   - one instance broadcast to two destinations, `dly1` going to `sortie`
//     and to `envoi1` (element 1, "let shares");
//   - two cables arriving at `process` and summing there (element 7);
//   - an input signal patched into a named port (element 3).
//
// GAPS MET WHILE WRITING IT — see the report:
//   - `N:3`: the same gap as in program 1, a filter order cannot be a port
//     and nothing lets one say so.
//   - the pedal puts out 0 to 1, the `fc` port expects hertz: there is no
//     notation at all for scaling a signal to a port. The line
//     `pedale * 3800 + 400 : corps1.fc` is raw Faust written by hand, and it
//     ignores the `fc.min` / `fc.max` bounds declared two lines above, which
//     are therefore of no use.
//   - the output is necessarily mono: two cables on `process` sum.
//
// The instance names are the musician's own, and French; they are left
// untouched. guitare = guitar, pedale = pedal, porte1 = gate, creux1 = notch,
// corps1 = body, envoi1 = reverb send, sortie = master out.
// ============================================================================

let guitare _
let pedale  hslider("pedale", 0.5, 0, 1, 0.01)   // a control, not an audio input:
                                                 // Faust refuses to let an input drive a port

let porte1 gate_mono(thresh:-55, att:0.001, hold:0.15, rel:0.05)
let comp1  compressor_mono(ratio:4, thresh:-18, att:0.005, rel:0.15)
let drive1 cubicnl(drive:0.6, offset:0)
let creux1 resonhp(fc:180, Q:0.8, gain:1)

let corps1 lowpass(N:3, fc:4200)
    corps1.fc.min:400
    corps1.fc.max:4200
    corps1.fc.scale:log
    corps1.fc.unit:Hz

let dly1   echo(maxDuration:2, duration:0.375, feedback:0.42)
let rev1   mono_freeverb(fb1:0.86, fb2:0.66, damp:0.5, spread:17)

let envoi1 *(niveau:0.3)
let sortie *(gain:0.8)

// the wiring
pedale * 3800 + 400 : corps1.fc

guitare : porte1 : comp1 : drive1 : creux1 : corps1 : dly1
dly1 : sortie : process
dly1 : envoi1 : rev1 : process
