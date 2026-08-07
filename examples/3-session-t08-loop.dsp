// Snapshot 3/5 of `3-twenty-minute-session.fx` -- after 08:00.
// The bass has changed body (sawtooth -> square), a delay with a feedback
// loop has been grafted onto the filter's output, and a second LFO modulates
// the delay time.
//
// WHAT THE TRANSLATION SHOWS, AND WHAT THE SPECIFICATION DOES NOT SAY:
//   `dly1 ~ fb1` does NOT translate as `dly1 ~ fb1`. In Faust, `A ~ B` takes
//   A's first inputs to bring B back into them; `dly1` has only one, and it
//   is already taken by `lpf1`. The Faust written below therefore inserts a
//   summing -- `(+ : dly1) ~ fb1` -- that nothing in element 2 says must
//   exist. Without it, the musician's line unplugs the filter instead of
//   closing a loop.
//
//   `n:96000` is frozen at 96000: it sizes the delay line and cannot be a
//   port.
//
//   `lpf1` goes to two destinations, hence the `<:`.
//
// The instance names are the musician's, in French: basse = bass, bruit =
// noise, clic = click, sortie = master out, vcab / vcac = the amplifiers on
// the bass and on the click, envb / envc their envelopes, bat1 the beat,
// fb1 = feedback and its port `retour` = return amount, boucle = the loop,
// `cellule` a cell of the bank.

import("stdfaust.lib");

bat1   = vgroup("bat1", ba.beat(nentry("t", 112, 0, 1e6, 0.001)));

envb   = vgroup("envb", en.ar(nentry("at[unit:s]", 0.004, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.16,  0, 1e6, 0.001), bat1));
envc   = vgroup("envc", en.ar(nentry("at[unit:s]", 0.001, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.09,  0, 1e6, 0.001), bat1));

// 05:00: the body has changed, the `freq` port keeps its current value.
basse  = vgroup("basse", os.square(nentry("freq[unit:Hz]", 55, 0, 1e6, 0.001)));
bruit  = vgroup("bruit", no.noise);

vcab   = *;
vcac   = *;
sortie = *(vgroup("sortie", nentry("gain", 0.5, 0, 1e6, 0.001)));

lfo1   = vgroup("lfo1", os.osc(nentry("freq[unit:Hz]", 0.13, 0, 1e6, 0.001)))
         * 380 + 520;
lfo2   = vgroup("lfo2", os.osc(nentry("freq[unit:Hz]", 0.07, 0, 1e6, 0.001)))
         * 4000 + 9000;

lpf1   = vgroup("lpf1", fi.resonlp(lfo1,
                                   nentry("Q", 16, 0, 1e6, 0.001),
                                   hslider("gain", 0.9, 0, 1, 0.001)));

// dly1: `d` is driven by lfo2, so no control at all; `n` is frozen.
dly1   = de.fdelay(96000, lfo2);
fb1    = *(vgroup("fb1", nentry("retour", 0.55, 0, 1e6, 0.001)));

// the loop, with the summing FaustX has to insert
boucle = (+ : dly1) ~ fb1;

clic   = vgroup("clic", cellule(1,  311), cellule(2,  466), cellule(3,  622),
                        cellule(4,  933), cellule(5, 1244), cellule(6, 1866))
with {
  cellule(n, f) = vgroup("%n", fi.resonbp(nentry("fc[unit:Hz]", f, 0, 1e6, 0.001),
                                          nentry("Q", 60, 0, 1e6, 0.001),
                                          hslider("gain", 1, 0, 1, 0.001)));
};

process = ( ((basse, envb) : vcab : lpf1 <: (_, boucle)),
            ((bruit, envc) : vcac <: clic) ) :> sortie;
