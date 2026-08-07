// Snapshot 1/5 of `3-twenty-minute-session.fx` -- the state at load time.
// Verified: faust -lang c 3-session-t00-start.dsp -o /dev/null
//                 -I /home/romi/dev/bp/faust-upstream/faustlibraries
//
// The port translation rule, the same in all five snapshots:
//   port with declared bounds -> hslider(name, start, min, max, 0.001)
//   port with no bounds       -> nentry(name, start, 0, 1e6, 0.001)
//                                (-1e6 as the minimum if the start is negative)
//   port driven by a signal   -> no control, the signal takes its place
//
// WHAT THE SNAPSHOTS CANNOT SHOW: the specification says that `!let`, `!:`,
// `!~`, `!` and `_` never cut off abruptly and that "the tail drains". A
// Faust program describes a state, not a transition: these five files
// therefore show the state ONCE the tail has drained. The transient has no
// writing at all in Faust; it belongs to the host.
//
// The instance names are the musician's, in French: basse = bass, bruit =
// noise, sortie = master out, vcab / vcac = the amplifiers on the bass and on
// the click, envb / envc their envelopes, bat1 the beat.

import("stdfaust.lib");

bat1   = vgroup("bat1", ba.beat(nentry("t", 112, 0, 1e6, 0.001)));

envb   = vgroup("envb", en.ar(nentry("at[unit:s]", 0.004, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.16,  0, 1e6, 0.001),
                              bat1));

basse  = vgroup("basse", os.sawtooth(nentry("freq[unit:Hz]", 55, 0, 1e6, 0.001)));

vcab   = *;
sortie = *(vgroup("sortie", nentry("gain", 0.5, 0, 1e6, 0.001)));

process = (basse, envb) : vcab : sortie;
