// ============================================================================
// 2. A GUITAR THAT COMES IN AND GOES OUT
//
// One audio input, the guitar, and an expression pedal. The guitar goes
// through a noise gate, a compressor, a saturation, a notch in the low end
// and a lowpass whose frequency the pedal opens; then a dotted-eighth delay,
// whose output goes both to the master volume and to a reverb send.
//
// What it exercises in docs/LANGUAGE.md:
//   - the named input, `let guitare _` (§8);
//   - the series chain between instances, just as it is (§4.1);
//   - one instance sent to two destinations, `dly1` going to `sortie` and to
//     `envoi1` (§2.2);
//   - two wires arriving at `process` and summing there (§8);
//   - a signal patched into a named port, `pedale * 3800 + 400 : corps1.fc`
//     (§6).
//
// `N:3` is the filter order, a constant (§3.4).
// The Faust that FaustX writes for this piece is engraved in
// tests/references/examples/2-processed-guitar.fx.txt.
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
