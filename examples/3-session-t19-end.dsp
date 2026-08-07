// Snapshot 5/5 of `3-twenty-minute-session.fx` -- after 19:40, the end.
// The reverb has been given back and laid down again in mono, the delay's
// loop is open, the bass is unplugged and the master volume is at zero.
//
// WHAT THE TRANSLATION SHOWS, AND WHICH ARE GAPS:
//
//   1. `basse !: vcab` does NOT silence the branch. `vcab` is a `*` with two
//      inputs; only one cable is left, and the adaptation rule says that a
//      channel arriving at several inputs is broadcast. The envelope is
//      therefore multiplied by itself -- `envb <: vcab` below -- and the
//      branch goes on sounding. What the musician expects from a `!:`,
//      silence, does not happen.
//      SETTLED SINCE, on this very line: a cut wire does not remove the
//      input, it puts zero into it, and the expected silence happens
//      (LANGUAGE.md, "Connecting").
//
//   2. `dly1 !~ fb1` opens the loop: the summing FaustX had inserted for `~`
//      disappears with it, and `fb1` stays an instance laid down that no
//      cable touches any more. It has no trace at all left in the Faust
//      emitted, whereas the specification calls it alive.
//
//   3. `!let rev1` then `let rev1 …`: the two cables that aimed at the old
//      name had to be written out again by hand. The specification does not
//      say whether they survive the name being given back -- here we assumed
//      they do not.
//
//   4. `sortie.gain:0` is no longer a gesture in the program emitted: it is
//      the control's starting value. A snapshot does not tell what was typed
//      from what was there from the beginning.
//
// The instance names are the musician's, in French: bruit = noise, clic =
// click, voix = voices, sortie = master out, envoi = effect send, vcab / vcac
// = the amplifiers on the bass and on the click, envb / envc their envelopes,
// bat1 the beat. In the wiring: `cellule` is one cell of the bank, `uneVoix`
// one voice, `tout` everything stacked, `etage` the stage that folds the
// delay back in.

import("stdfaust.lib");

bat1   = vgroup("bat1", ba.beat(nentry("t", 112, 0, 1e6, 0.001)));

envb   = vgroup("envb", en.ar(nentry("at[unit:s]", 0.004, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.16,  0, 1e6, 0.001), bat1));
envc   = vgroup("envc", en.ar(nentry("at[unit:s]", 0.001, 0, 1e6, 0.001),
                              nentry("rt[unit:s]", 0.09,  0, 1e6, 0.001), bat1));

bruit  = vgroup("bruit", no.noise);

vcab   = *;
vcac   = *;
sortie = *(vgroup("sortie", nentry("gain",   0,    0, 1e6, 0.001)));
envoi  = *(vgroup("envoi",  nentry("niveau", 0.25, 0, 1e6, 0.001)));

lfo2   = vgroup("lfo2", os.osc(nentry("freq[unit:Hz]", 0.07, 0, 1e6, 0.001)))
         * 4000 + 9000;

lpf1   = _;
dly1   = de.fdelay(96000, lfo2);

clic   = vgroup("clic", cellule(1,  311), cellule(2,  900), cellule(3,  900),
                        cellule(4,  900), cellule(5,  900), cellule(6,  900),
                        cellule(7, 2489), cellule(8,  900), cellule(9,  900),
                        cellule(10, 900), cellule(11, 900), cellule(12, 900))
with {
  cellule(n, f) = vgroup("%n", fi.resonbp(nentry("fc[unit:Hz]", f, 0, 1e6, 0.001),
                                          nentry("Q", 60, 0, 1e6, 0.001),
                                          hslider("gain", 1, 0, 1, 0.001)));
};

voix   = vgroup("voix", uneVoix(1, 110), uneVoix(2, 165), uneVoix(3, 220),
                        uneVoix(4, 277), uneVoix(5, 330), uneVoix(6, 440),
                        uneVoix(7, 554), uneVoix(8, 660))
with {
  uneVoix(n, f) = vgroup("%n", os.sawtooth(nentry("freq[unit:Hz]", f, 0, 1e6, 0.001))
                               : fi.lowpass(2, nentry("fc[unit:Hz]", 1200, 0, 1e6, 0.001)));
};

rev1   = vgroup("rev1", re.mono_freeverb(hslider("fb1",  0.94, 0, 1, 0.001),
                                         hslider("fb2",  0.75, 0, 1, 0.001),
                                         hslider("damp", 0.3,  0, 1, 0.001),
                                         nentry("spread", 19, 0, 1e6, 0.001)));

// --- the wiring -------------------------------------------------------------

tout  = ( (envb <: vcab : lpf1) <: (_, _) ),
        ( voix <: (route(8, 1, 5, 1), si.bus(8)) ),
        ( (bruit, envc) : vcac <: clic );

etage = _ , ((_ , _) :> dly1) , si.bus(20);

process = ((tout : etage) :> sortie) <: (_ , (envoi : rev1)) :> _;
