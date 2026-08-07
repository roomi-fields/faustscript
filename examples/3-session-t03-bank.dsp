// Snapshot 2/5 of `3-twenty-minute-session.fx` -- after 03:10.
// The filter is inserted between `vcab` and `sortie`, an LFO sweeps its
// frequency, and a bank of six narrow-band resonators arrives in parallel.
// Same port translation rule as in the first snapshot.
//
// WHAT THE TRANSLATION SHOWS:
//   - `vcab : lpf1` + `lpf1 : sortie` + `vcab !: sortie`: three gestures, one
//     single series chain at the end of them. The Faust keeps no trace of the
//     intermediate state where the sound went through both paths;
//   - `lfo1 : lpf1.fc` replaces the `fc` control with the signal, and the
//     price is that the port's bounds are of no use any more: the 380/520
//     scaling is written into `lfo1`'s body;
//   - `bat1` feeds TWO envelopes. Faust is a macro language: the two uses are
//     written out twice. They do not build two circuits here because common
//     subexpression elimination merges them -- but that is an effect of the
//     compiler, not a guarantee of the notation;
//   - the bank of six becomes six numbered `vgroup`s stacked with `,`, and
//     the six `clic.N.fc` controls become six distinct starting values. It is
//     the only way to separate them: `:6` has no rank.
//
// DEPARTURE OWNED: the catalogue's declaration says of `resonlp` that it
// "takes no signal as input". That is false, `fi.resonlp` is a one-in
// one-out filter, and the chain would not hold otherwise.
//
// The instance names are the musician's, in French: basse = bass, bruit =
// noise, clic = click, sortie = master out, vcab / vcac = the amplifiers on
// the bass and on the click, envb / envc their envelopes, bat1 the beat.
// `cellule` is a cell of the bank -- one resonator, one number.

import("stdfaust.lib");

bat1   = vgroup("bat1", ba.beat(nentry("t", 112, 0, 1e6, 0.001)));

envb   = vgroup("envb", en.ar(nentry("at[unit:s]", 0.004, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.16,  0, 1e6, 0.001), bat1));
envc   = vgroup("envc", en.ar(nentry("at[unit:s]", 0.001, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.09,  0, 1e6, 0.001), bat1));

basse  = vgroup("basse", os.sawtooth(nentry("freq[unit:Hz]", 55, 0, 1e6, 0.001)));
bruit  = vgroup("bruit", no.noise);

vcab   = *;
vcac   = *;
sortie = *(vgroup("sortie", nentry("gain", 0.5, 0, 1e6, 0.001)));

lfo1   = vgroup("lfo1", os.osc(nentry("freq[unit:Hz]", 0.13, 0, 1e6, 0.001)))
         * 380 + 520;

// lpf1: `fc` is driven by lfo1, `Q` was taken up to 16 at 02:20.
lpf1   = vgroup("lpf1", fi.resonlp(lfo1,
                                   nentry("Q", 16, 0, 1e6, 0.001),
                                   hslider("gain", 0.9, 0, 1, 0.001)));

// the bank: six instances, six control paths /clic/N/...
clic   = vgroup("clic", cellule(1,  311), cellule(2,  466), cellule(3,  622),
                        cellule(4,  933), cellule(5, 1244), cellule(6, 1866))
with {
  cellule(n, f) = vgroup("%n", fi.resonbp(nentry("fc[unit:Hz]", f, 0, 1e6, 0.001),
                                          nentry("Q", 60, 0, 1e6, 0.001),
                                          hslider("gain", 1, 0, 1, 0.001)));
};

process = ( ((basse, envb) : vcab : lpf1),
            ((bruit, envc) : vcac <: clic) ) :> sortie;
