// Snapshot 4/5 of `3-twenty-minute-session.fx` -- after 15:00.
// The filter has been bypassed, the bank given back then laid down again in
// twelve, eight voices have arrived, the fifth of them also goes into the
// delay, and a stereo reverb is patched in as a send.
//
// WHAT THE TRANSLATION SHOWS, AND WHICH ARE GAPS:
//
//   1. `_ lpf1` at 09:30 makes the filter disappear from the Faust emitted:
//      it becomes a wire. The body replacement at 10:15 does not put it back
//      into the flow, and no line can. The LFO that swept it has no
//      destination left and disappears too -- two live instances of which
//      nothing remains in the program.
//      SETTLED SINCE: `!_ lpf1` puts a bypassed module back into the flow
//      (LANGUAGE.md, "The gestures"), which the session could not write.
//
//   2. `rev1` has two outputs and `process` sums them: THE PIECE IS MONO. The
//      `:>` of the last line is what the specification imposes, and nothing
//      in the notation lets one write anything else.
//      SETTLED SINCE: `process` has channels like any instance, so
//      `rev1.1 : process.1` is how a stereo piece is written
//      (LANGUAGE.md, "What sounds").
//
//   3. `voix.5` asks for one precise channel in a bank. Faust has no other
//      way than `route(8,1, 5,1)`, preceded by a `<:` that doubles the bank
//      because 8 into 9 is not a whole multiple. One channel taken out
//      therefore costs eight copies of the bus.
//
//   4. The eight voices are written one by one: `:8` has no rank.
//      SETTLED SINCE: `i` is the rank of the copy, so one `let` carries the
//      eight pitches (LANGUAGE.md, "Placing a module").
//
// The instance names are the musician's, in French: basse = bass, bruit =
// noise, clic = click, voix = voices, sortie = master out, envoi = effect
// send, vcab / vcac = the amplifiers on the bass and on the click, envb /
// envc their envelopes, bat1 the beat, fb1 = feedback and its port `retour` =
// return amount, boucle = the loop. In the wiring: `cellule` is one cell of
// the bank, `uneVoix` one voice, `tout` everything stacked, `etage` the stage
// that folds the delay back in.

import("stdfaust.lib");

bat1   = vgroup("bat1", ba.beat(nentry("t", 112, 0, 1e6, 0.001)));

envb   = vgroup("envb", en.ar(nentry("at[unit:s]", 0.004, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.16,  0, 1e6, 0.001), bat1));
envc   = vgroup("envc", en.ar(nentry("at[unit:s]", 0.001, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.09,  0, 1e6, 0.001), bat1));

basse  = vgroup("basse", os.square(nentry("freq[unit:Hz]", 55, 0, 1e6, 0.001)));
bruit  = vgroup("bruit", no.noise);

vcab   = *;
vcac   = *;
sortie = *(vgroup("sortie", nentry("gain",   0.5,  0, 1e6, 0.001)));
envoi  = *(vgroup("envoi",  nentry("niveau", 0.25, 0, 1e6, 0.001)));

lfo2   = vgroup("lfo2", os.osc(nentry("freq[unit:Hz]", 0.07, 0, 1e6, 0.001)))
         * 4000 + 9000;

// lpf1 bypassed at 09:30: only a wire is left. lfo1 has no destination any
// more and no longer figures in the program.
lpf1   = _;

dly1   = de.fdelay(96000, lfo2);
fb1    = *(vgroup("fb1", nentry("retour", 0.55, 0, 1e6, 0.001)));
boucle = (+ : dly1) ~ fb1;

// the bank given back and laid down again in twelve
clic   = vgroup("clic", cellule(1,  311), cellule(2,  900), cellule(3,  900),
                        cellule(4,  900), cellule(5,  900), cellule(6,  900),
                        cellule(7, 2489), cellule(8,  900), cellule(9,  900),
                        cellule(10, 900), cellule(11, 900), cellule(12, 900))
with {
  cellule(n, f) = vgroup("%n", fi.resonbp(nentry("fc[unit:Hz]", f, 0, 1e6, 0.001),
                                          nentry("Q", 60, 0, 1e6, 0.001),
                                          hslider("gain", 1, 0, 1, 0.001)));
};

// the eight voices, written one by one
voix   = vgroup("voix", uneVoix(1, 110), uneVoix(2, 165), uneVoix(3, 220),
                        uneVoix(4, 277), uneVoix(5, 330), uneVoix(6, 440),
                        uneVoix(7, 554), uneVoix(8, 660))
with {
  uneVoix(n, f) = vgroup("%n", os.sawtooth(nentry("freq[unit:Hz]", f, 0, 1e6, 0.001))
                               : fi.lowpass(2, nentry("fc[unit:Hz]", 1200, 0, 1e6, 0.001)));
};

rev1   = vgroup("rev1", re.stereo_freeverb(hslider("fb1",  0.88, 0, 1, 0.001),
                                           hslider("fb2",  0.7,  0, 1, 0.001),
                                           hslider("damp", 0.4,  0, 1, 0.001),
                                           nentry("spread", 23, 0, 1e6, 0.001)));

// --- the wiring -------------------------------------------------------------
// channel  1     : the bass, to sortie
// channel  2     : the bass, to the delay
// channel  3     : the 5th voice, to the delay
// channels 4-11  : the eight voices, to sortie
// channels 12-23 : the twelve resonators, to sortie

tout  = ( ((basse, envb) : vcab : lpf1) <: (_, _) ),
        ( voix <: (route(8, 1, 5, 1), si.bus(8)) ),
        ( (bruit, envc) : vcac <: clic );

etage = _ , ((_ , _) :> boucle) , si.bus(20);

process = ((tout : etage) :> sortie) <: (_ , (envoi <: rev1 :> _)) :> _;
