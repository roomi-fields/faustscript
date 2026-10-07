// FaustX module declarations, generated from the Faust libraries of
// @grame/faustwasm 0.19.0: libfaust 2.90.0, libraries 2.74.2 (version.lib).
// 1172 modules.
// Each module bears Faust's name, its prefix included: fi.lowpass.
// Every declaration has been compiled with its starting values: the
// "N inputs, M outputs" line comes from the compiler, not from the text.
// A value marked GUESSED comes from no source: it is deduced from the
// parameter name or from the range the documentation announces.
// A parameter that carries a nature is not a setting.
//
// The bounds of a setting — `p.min`, `p.max` — come from the
// documentation when nothing says otherwise; failing that a BOUNDS ...
// line names the source, and says what is deduced, observed or guessed.
// A bounded setting has passed the slider test: the compiler accepts
// that it changes while the sound plays.
//
// The output range — `output.min`, `output.max` — is MEASURED:
// the module ran for 5 s at 48 kHz with its starting values, the
// first second discarded, on silence then on full-scale noise.
// `output.measure` says under which excitation. These are observed
// values, never theoretical bounds.
//
// `faustwasm.unavailable:f` marks a module that faustwasm refuses to
// compile: it calls the foreign function f, which the WebAssembly
// backend does not allow.
// Do not edit by hand: correct tools/generate-declarations.py.

aa.ADAA1(EPS:0.001, f, F1)  aa.ADAA1(EPS, f, F1, x)
  f.nature:function
  F1.nature:function
  x.nature:signal
  x.example:os.osc(110)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

aa.ADAA2(EPS:0.001, f, F1, F2)  aa.ADAA2(EPS, f, F1, F2, x)
  f.nature:function
  F1.nature:function
  F2.nature:function
  x.nature:signal
  x.example:os.osc(110)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

aa.Racos  aa.Racos(x)
  x.nature:signal
  output.min:0.0105406
  output.max:3.13757
  output.measure:silence-and-noise
  // at rest: 1.5708 to 1.5708; under noise: 0.0105406 to 3.13757
  // 1 input, 1 output

aa.Racosh  aa.Racosh(x)
  x.nature:signal
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

aa.Rasin  aa.Rasin(x)
  x.nature:signal
  output.min:-1.56677
  output.max:1.56026
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.Ratanh  aa.Ratanh(x)
  x.nature:signal
  output.min:-6.20801
  output.max:5.24566
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.Rcosh  aa.Rcosh(x)
  x.nature:signal
  output.min:1
  output.max:1.54307
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 1 to 1.54307
  // 1 input, 1 output

aa.Rlog  aa.Rlog(x)
  x.nature:signal
  output.min:-15.9424
  output.max:-5.55531e-05
  output.measure:silence-and-noise
  // at rest: -15.9424 to -15.9424; under noise: -15.9424 to -5.55531e-05
  // 1 input, 1 output

aa.Rsinh  aa.Rsinh(x)
  x.nature:signal
  output.min:-1.17519
  output.max:1.17512
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.Rsqrt  aa.Rsqrt(x)
  x.nature:signal
  output.min:0
  output.max:0.999972
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.Rtan  aa.Rtan(x)
  x.nature:signal
  output.min:-1.55738
  output.max:1.55722
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.acosh1  aa.acosh1(x)
  x.nature:signal
  x.example:1.0 + abs(sig)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

aa.acosh2  aa.acosh2(x)
  x.nature:signal
  x.example:1.0 + abs(sig)
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 3057)
  // 1 input, 1 output

aa.arccos  aa.arccos(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:0.0597649
  output.max:3.0497
  output.measure:silence-and-noise
  // at rest: 1.5708 to 1.5708; under noise: 0.0597649 to 3.0497
  // 1 input, 1 output

aa.arccos2  aa.arccos2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-67.9583
  output.max:72.9971
  output.measure:silence-and-noise
  // at rest: 1.5708 to 1.5708; under noise: -67.9583 to 72.9971
  // 1 input, 1 output

aa.arcsin  aa.arcsin(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-1.47892
  output.max:1.51099
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.arcsin2  aa.arcsin2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-1.43562
  output.max:1.39689
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.arctan  aa.arctan(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.783234
  output.max:0.784423
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.arctan2  aa.arctan2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.780807
  output.max:0.773882
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.asinh1  aa.asinh1(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.878318
  output.max:0.879952
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.asinh2  aa.asinh2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.874896
  output.max:0.865247
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.atanh1  aa.atanh1(x)
  x.nature:signal
  x.example:0.8 * sig
  output.min:-3.09218
  output.max:3.58523
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.atanh2  aa.atanh2(x)
  x.nature:signal
  x.example:0.8 * sig
  output.min:-2.69379
  output.max:2.68397
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.cosine1  aa.cosine1(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:0.541973
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.541973 to 1
  // 1 input, 1 output

aa.cosine2  aa.cosine2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:0.547971
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.547971 to 0.999969
  // 1 input, 1 output

aa.cubic1  aa.cubic1(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.66665
  output.max:0.666658
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.hardclip  aa.hardclip(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.995686
  output.max:0.998014
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.hardclip2  aa.hardclip2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.99086
  output.max:0.977525
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.hyperbolic  aa.hyperbolic(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.498923
  output.max:0.499498
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.hyperbolic2  aa.hyperbolic2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.497704
  output.max:0.494242
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.parabolic  aa.parabolic(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.747846
  output.max:0.749003
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.parabolic2  aa.parabolic2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.745409
  output.max:0.738485
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.sinarctan  aa.sinarctan(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.705567
  output.max:0.706411
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.sinarctan2  aa.sinarctan2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.703853
  output.max:0.698917
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.sine  aa.sine(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.839121
  output.max:0.840397
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.sine2  aa.sine2(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.836497
  output.max:0.828951
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.softclipQuadratic1  aa.softclipQuadratic1
  output.min:-1
  output.max:1.00001
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.softclipQuadratic2  aa.softclipQuadratic2
  output.min:-1.00004
  output.max:1.00003
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.tangent  aa.tangent(x)
  x.nature:signal
  x.example:0.25 * ma.PI * sig
  output.min:-1.54271
  output.max:1.55065
  output.measure:silence-and-noise
  // 1 input, 1 output

aa.tanh1  aa.tanh1(x)
  x.nature:signal
  x.example:os.osc(110)
  output.min:-0.759772
  output.max:0.760768
  output.measure:silence-and-noise
  // 1 input, 1 output

an.abs_envelope_rect(period:0.05)  an.abs_envelope_rect(period, x)
  period.unit:s
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.520505
  output.measure:silence-and-noise
  // 1 input, 1 output

an.abs_envelope_t19(period:0.05)  an.abs_envelope_t19(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.519646
  output.measure:silence-and-noise
  // 1 input, 1 output

an.abs_envelope_t60(period:0.05)  an.abs_envelope_t60(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.539745
  output.measure:silence-and-noise
  // 1 input, 1 output

an.abs_envelope_tau(period:0.05)  an.abs_envelope_tau(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.511298
  output.measure:silence-and-noise
  // 1 input, 1 output

an.amp_follower(rel:0.05)  an.amp_follower(rel)
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0
  output.max:0.999992
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

an.amp_follower_ar(att:0.002, rel:0.05)  an.amp_follower_ar(att, rel)
  att.unit:s
  att.min:0.0005
  att.max:0.05
  att.scale:log
  rel.unit:s
  rel.min:0.01
  rel.max:0.2
  output.min:0
  output.max:0.857318
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: att from 0.0005 to 0.05
  // BOUNDS FROM USAGE, the values the libraries pass to it: rel from 0.01 to 0.2
  // 1 input, 1 output

an.amp_follower_ud(att:0.002, rel:0.05)  an.amp_follower_ud(att, rel)
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0
  output.max:0.992285
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

an.analyzer(O:3, lfreqs)  an.analyzer(O, lfreqs)
  lfreqs.nature:table
  lfreqs.example:(500, 2000)
  output.min:-1.82954
  output.max:1.67957
  output.measure:silence-and-noise
  // 1 input, 3 outputs

an.band_center(M, ftop, N:2, i:0)  an.band_center(M, ftop, N, i)
  // GUESSED: N:2, from the parameter name
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: M has no starting value
  // TO COMPLETE: ftop has no starting value

an.band_powers(O:3, M:3, ftop:8000, N:5, T:1)  an.band_powers(O, M, ftop, N, T)
  output.min:0
  output.max:0.223468
  output.measure:silence-and-noise
  // GUESSED: T:1, from the parameter name
  // 1 input, 5 outputs

an.bit_reverse_selector(N:2, i:0)  an.bit_reverse_selector(N, i)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // GUESSED: N:2, from the parameter name
  // 0 input, 1 output

an.bit_reverse_shuffle(N:2)  an.bit_reverse_shuffle(N)
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 2 inputs, 2 outputs

an.c_bit_reverse_shuffle(N:2)  an.c_bit_reverse_shuffle(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 4 inputs, 4 outputs

an.c_magdb(N:2)  an.c_magdb(N)
  output.min:-69.2369
  output.max:3.00259
  output.measure:silence-and-noise
  // at rest: -69.2369 to -69.2369; under noise: -51.5659 to 3.00259
  // GUESSED: N:2, from the parameter name
  // 4 inputs, 2 outputs

an.c_magsq(N:2)  an.c_magsq(N)
  output.min:0
  output.max:1.99645
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 4 inputs, 2 outputs

an.c_select_pos_freqs(N:2)  an.c_select_pos_freqs(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

an.fft(N:8)  an.fft(N)
  output.min:-7.16725
  output.max:7.117
  output.measure:silence-and-noise
  // 16 inputs, 16 outputs

an.fftb(N:1)  an.fftb(N)
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

an.goertzel(freq:440, n:128)  an.goertzel(freq, n, x)
  freq.min:20
  freq.max:20000
  freq.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:0
  output.max:18.6689
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

an.goertzelComp(freq:440, n:128)  an.goertzelComp(freq, n, x)
  freq.min:20
  freq.max:20000
  freq.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:0
  output.max:227.076
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

an.goertzelOpt(freq:440, n:128)  an.goertzelOpt(freq, n, x)
  freq.min:20
  freq.max:20000
  freq.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:0
  output.max:18.6689
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

an.half_octave_analyzer(N:2)  an.half_octave_analyzer(N)
  output.min:-1.57296
  output.max:1.59762
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 1 input, 2 outputs

an.half_octave_filterbank(N:2)  an.half_octave_filterbank(N)
  // GUESSED: N:2, from the parameter name
  // DOES NOT COMPILE: ERROR : undefined symbol : mth_octave_filterbank_default

an.ifft(N:8)  an.ifft(N)
  output.min:-0.895906
  output.max:0.889625
  output.measure:silence-and-noise
  // 16 inputs, 16 outputs

an.ifftb(N:1)  an.ifftb(N)
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

an.linsweep(fs:20, fe:2000, dur:5)  an.linsweep(fs, fe, dur)
  fs.unit:Hz
  fe.unit:Hz
  dur.unit:s
  output.min:-1.00001
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

an.logsweep(fs:20, fe:2000, dur:5)  an.logsweep(fs, fe, dur)
  fs.unit:Hz
  fe.unit:Hz
  dur.unit:s
  output.min:-0.999968
  output.max:0.999968
  output.measure:no-input
  // 0 input, 1 output

an.loudness_integrated(N:2)  an.loudness_integrated(N)
  output.min:-100
  output.max:1.19876
  output.measure:silence-and-noise
  // at rest: -100 to -100; under noise: 0.4388 to 1.19876
  // 2 inputs, 1 output

an.loudness_meansquare(T:0.400, N:2)  an.loudness_meansquare(T, N)
  T.unit:s
  output.min:0
  output.max:1.3846
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 2 inputs, 1 output

an.loudness_momentary(N:2)  an.loudness_momentary(N)
  output.min:-100
  output.max:1.41323
  output.measure:silence-and-noise
  // at rest: -100 to -100; under noise: 1.334 to 1.41323
  // 2 inputs, 1 output

an.loudness_shortterm(N:2)  an.loudness_shortterm(N)
  output.min:-100
  output.max:1.3806
  output.measure:silence-and-noise
  // at rest: -100 to -100; under noise: -3.36004 to 1.3806
  // 2 inputs, 1 output

an.meansquare2lufs  an.meansquare2lufs
  output.min:-100
  output.max:-0.000241264
  output.measure:silence-and-noise
  // at rest: -100 to -100; under noise: -100 to -0.000241264
  // 1 input, 1 output

an.moment(M, ftop, N:2, K:0)  an.moment(M, ftop, N, K)
  K.min:0
  K.max:2
  // GUESSED: N:2, from the parameter name
  // BOUNDS FROM USAGE, the values the libraries pass to it: K from 0 to 2
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: M has no starting value
  // TO COMPLETE: ftop has no starting value

an.ms_envelope_rect(period:0.05)  an.ms_envelope_rect(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.355978
  output.measure:silence-and-noise
  // 1 input, 1 output

an.ms_envelope_t19(period:0.05)  an.ms_envelope_t19(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.356368
  output.measure:silence-and-noise
  // 1 input, 1 output

an.ms_envelope_t60(period:0.05)  an.ms_envelope_t60(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.371712
  output.measure:silence-and-noise
  // 1 input, 1 output

an.ms_envelope_tau(period:0.05)  an.ms_envelope_tau(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.34594
  output.measure:silence-and-noise
  // 1 input, 1 output

an.mth_octave_analyzer(O:3, M:3, ftop:8000, N:5)  an.mth_octave_analyzer(O, M, ftop, N)
  output.min:-1.43726
  output.max:1.45457
  output.measure:silence-and-noise
  // 1 input, 5 outputs

an.mth_octave_analyzer3(M, ftop, N:2)  an.mth_octave_analyzer3(M, ftop, N)
  // GUESSED: N:2, from the parameter name
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: M has no starting value
  // TO COMPLETE: ftop has no starting value

an.mth_octave_analyzer5(M, ftop, N:2)  an.mth_octave_analyzer5(M, ftop, N)
  // GUESSED: N:2, from the parameter name
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: M has no starting value
  // TO COMPLETE: ftop has no starting value

an.mth_octave_analyzer6e(M, ftop, N:2)  an.mth_octave_analyzer6e(M, ftop, N)
  // GUESSED: N:2, from the parameter name
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: M has no starting value
  // TO COMPLETE: ftop has no starting value

an.mth_octave_analyzer_default(M:3, ftop:10000, N:2)  an.mth_octave_analyzer_default(M, ftop, N)
  M.min:1
  M.max:3
  output.min:-1.57296
  output.max:1.59762
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // BOUNDS FROM USAGE, the values the libraries pass to it: M from 1 to 3
  // 1 input, 2 outputs

an.mth_octave_spectral_level6e(M:3, ftop:8000, N:5, tau:0.05, dB_offset:0)  an.mth_octave_spectral_level6e(M, ftop, N, tau, dB_offset)
  tau.unit:s
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

an.mth_octave_spectral_level_default(M, ftop:16000, N:2, tau, dB_offset)  an.mth_octave_spectral_level_default(M, ftop, N, tau, dB_offset)
  tau.unit:s
  // GUESSED: N:2, from the parameter name
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: M has no starting value
  // TO COMPLETE: tau has no starting value
  // TO COMPLETE: dB_offset has no starting value

an.octave_analyzer(N:2)  an.octave_analyzer(N)
  output.min:-1.57296
  output.max:1.59762
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 1 input, 2 outputs

an.octave_filterbank(N:2)  an.octave_filterbank(N)
  // GUESSED: N:2, from the parameter name
  // DOES NOT COMPILE: ERROR : undefined symbol : mth_octave_filterbank_default

an.peak_envelope(rel:0.1)  an.peak_envelope(rel)
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0
  output.max:0.999992
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

an.pitchTracker(N:4, t:0.02)  an.pitchTracker(N, t, x)
  t.unit:s
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:80.4252
  output.measure:silence-and-noise
  // 1 input, 1 output

an.resonator(N:2, f:440)  an.resonator(N, f)
  f.unit:Hz
  output.min:-3.14159
  output.max:3.14157
  output.measure:silence-and-noise
  // 1 input, 2 outputs

an.rfft_analyzer_c(N:2)  an.rfft_analyzer_c(N)
  output.min:-1.99402
  output.max:1.99747
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 1 input, 4 outputs

an.rfft_analyzer_db(N:8)  an.rfft_analyzer_db(N)
  output.min:-69.2369
  output.max:16.4707
  output.measure:silence-and-noise
  // at rest: -69.2369 to -69.2369; under noise: -69.2369 to 16.4707
  // 1 input, 5 outputs

an.rfft_analyzer_magsq(N:2)  an.rfft_analyzer_magsq(N)
  output.min:0
  output.max:3.98989
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 1 input, 2 outputs

an.rfft_spectral_level(N:3, tau, dB_offset)  an.rfft_spectral_level(N, tau, dB_offset)
  tau.unit:s
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: tau has no starting value
  // TO COMPLETE: dB_offset has no starting value

an.rms_envelope_rect(period:0.05)  an.rms_envelope_rect(period, x)
  period.min:0.03
  period.max:0.1
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.596639
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: period from 0.03 to 0.1
  // 1 input, 1 output

an.rms_envelope_t19(period:0.05)  an.rms_envelope_t19(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.596966
  output.measure:silence-and-noise
  // 1 input, 1 output

an.rms_envelope_t60(period:0.05)  an.rms_envelope_t60(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.609682
  output.measure:silence-and-noise
  // 1 input, 1 output

an.rms_envelope_tau(period:0.05)  an.rms_envelope_tau(period, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.588166
  output.measure:silence-and-noise
  // 1 input, 1 output

an.rtocv(N:8)  an.rtocv(N, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 16 outputs

an.rtorv(N:2)  an.rtorv(N, x)
  x.nature:signal
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 1 input, 2 outputs

an.rvtocv(N:2)  an.rvtocv(N)
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 2 inputs, 4 outputs

an.safe_div(num, den)  an.safe_div(num, den)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: num has no starting value
  // TO COMPLETE: den has no starting value

an.spectralCentroid(nonlinearity:1, t:0.001)  an.spectralCentroid(nonlinearity, t, x)
  t.unit:s
  x.nature:signal
  output.min:20
  output.max:12537.8
  output.measure:silence-and-noise
  // at rest: 20 to 20; under noise: 11335.3 to 12537.8
  // 1 input, 1 output

an.spectral_centroid(O:3, M:1, ftop:8000, N:6, T:0.1)  an.spectral_centroid(O, M, ftop, N, T)
  ftop.unit:Hz
  T.unit:s
  output.min:0
  output.max:10666.7
  output.measure:silence-and-noise
  // 1 input, 1 output

an.spectral_flux(O:3, M:1, ftop:8000, N:6, hop:0.02)  an.spectral_flux(O, M, ftop, N, hop)
  hop.unit:s
  output.min:0
  output.max:0.132632
  output.measure:silence-and-noise
  // 1 input, 1 output

an.spectral_level  an.spectral_level
  // DOES NOT COMPILE: ERROR : undefined symbol : mth_octave_spectral_level

an.spectral_spread(O:3, M:1, ftop:8000, N:6, T:0.1)  an.spectral_spread(O, M, ftop, N, T)
  ftop.unit:Hz
  T.unit:s
  output.min:0
  output.max:5060.98
  output.measure:silence-and-noise
  // 1 input, 1 output

an.third_octave_analyzer(N:2)  an.third_octave_analyzer(N)
  output.min:-1.57296
  output.max:1.59762
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // 1 input, 2 outputs

an.third_octave_filterbank(N:2)  an.third_octave_filterbank(N)
  // GUESSED: N:2, from the parameter name
  // DOES NOT COMPILE: ERROR : undefined symbol : mth_octave_filterbank_default

an.true_peak  an.true_peak(x)
  x.nature:signal
  x.example:os.osc(12000)*0.97
  // DOES NOT COMPILE: the compiler fails: Aborted(native code called abort())

an.window_bartlett  an.window_bartlett(x)
  x.nature:signal
  output.min:0
  output.max:0.999959
  output.measure:silence-and-noise
  // 1 input, 1 output

an.window_blackman  an.window_blackman(x)
  x.nature:signal
  output.min:-2.23517e-08
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

an.window_blackman_harris  an.window_blackman_harris(x)
  x.nature:signal
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // at rest: 5.99623e-05 to 5.99623e-05; under noise: 0 to 1
  // 1 input, 1 output

an.window_cosN(coeffs)  an.window_cosN(coeffs, x)
  coeffs.nature:table
  coeffs.example:(0.5, -0.5)
  x.nature:signal
  x.example:os.lf_sawpos(100)
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

an.window_flattop  an.window_flattop(x)
  x.nature:signal
  output.min:-0.0705611
  output.max:1
  output.measure:silence-and-noise
  // at rest: -0.000421047 to -0.000421047; under noise: -0.0705611 to 1
  // 1 input, 1 output

an.window_hamming  an.window_hamming(x)
  x.nature:signal
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // at rest: 0.08 to 0.08; under noise: 0 to 1
  // 1 input, 1 output

an.window_hann  an.window_hann(x)
  x.nature:signal
  x.example:os.lf_sawpos(100)
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

an.window_kaiser(beta:8.6)  an.window_kaiser(beta, x)
  beta.min:2
  beta.max:16
  x.nature:signal
  x.example:os.lf_sawpos(100)
  // OUTPUT NOT FINITE: NaN or infinity on noise (68141 samples out of 191872)
  // 1 input, 1 output

an.window_nuttall  an.window_nuttall(x)
  x.nature:signal
  output.min:-2.98023e-08
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

an.window_rect  an.window_rect(x)
  x.nature:signal
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0 to 1
  // 1 input, 1 output

an.window_tukey(a:0.5)  an.window_tukey(a, x)
  a.min:0
  a.max:1
  x.nature:signal
  x.example:os.lf_sawpos(100)
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

an.zcr(period:0.01)  an.zcr(period, x)
  period.unit:s
  x.nature:signal
  x.example:os.osc(220)
  output.min:0
  output.max:0.554072
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.automat(t:120, size:4, init:0.0)  ba.automat(t, size, init, input)
  input.nature:signal
  output.min:-0.799945
  output.max:0.712884
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.beat(t:120)  ba.beat(t)
  output.min:0
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

ba.bitcrusher(nbits:8)  ba.bitcrusher(nbits, x)
  x.nature:signal
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.bpf  ba.bpf
  // a set of definitions: start(x0, y0), point(x1, y1), end(x1, y1), step(x1, y1), step_end(x1, y1), curve(B, x1, y1), curve_end(B, x1, y1), _curve_util(x0, x1, y0, y1, b, x)

ba.bypass1(bpc:0, e)  ba.bypass1(bpc, e)
  e.nature:function
  e.example:*(0.5)
  output.min:-0.499996
  output.max:0.499972
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.bypass1to2(bpc:0)  ba.bypass1to2(bpc, e)
  e.nature:signal
  e.example:monoToStereo
  // DOES NOT COMPILE: ERROR : sequential composition inswitch:e

ba.bypass2(bpc:0, e)  ba.bypass2(bpc, e)
  e.nature:function
  e.example:par(i,2, *(0.5))
  output.min:-0.499999
  output.max:0.499988
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

ba.bypass_fade(n:128, b:0, e)  ba.bypass_fade(n, b, e)
  e.nature:function
  e.example:par(i,2, *(0.5))
  output.min:-0.499999
  output.max:0.499988
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

ba.cent2ratio(cent:100)  ba.cent2ratio(cent)
  // CONSTANT OUTPUT: the output does not move from 1.05946
  // 0 input, 1 output

ba.count(xx)  ba.count(xx)
  xx.nature:table
  xx.example:(10,20,30,40)
  // CONSTANT OUTPUT: the output does not move from 4
  // 0 input, 1 output

ba.countdown(n:8, trig:0)  ba.countdown(n, trig)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

ba.counter(trig:0)  ba.counter(trig)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

ba.countup(n:8)  ba.countup(n, trig)
  trig.nature:signal
  trig.example:ba.pulse(16)
  output.min:0
  output.max:8
  output.measure:silence-and-noise
  // at rest: 8 to 8; under noise: 0 to 8
  // 1 input, 1 output

ba.cselector(i:1, n:2)  ba.cselector(i, n)
  output.min:-0.999999
  output.max:0.999993
  output.measure:silence-and-noise
  // 4 inputs, 2 outputs

ba.cycle(n:3)  ba.cycle(n)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 3 outputs

ba.db2linear(l:-6)  ba.db2linear(l)
  l.unit:dB
  l.min:-120
  l.max:60
  // CONSTANT OUTPUT: the output does not move from 0.501187
  // BOUNDS FROM USAGE, the values the libraries pass to it: l from -120 to 60
  // 0 input, 1 output

ba.downSample(freq:11025)  ba.downSample(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.999987
  output.max:0.999842
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

ba.downSampleCV(amt:0.5)  ba.downSampleCV(amt)
  amt.min:0
  amt.max:1
  output.min:-0.999987
  output.max:0.999648
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.hz2mel(freq:440.0)  ba.hz2mel(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: the output does not move from 549.639
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

ba.hz2midikey(freq:440)  ba.hz2midikey(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: the output does not move from 69
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

ba.hz2pianokey(freq:440)  ba.hz2pianokey(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: the output does not move from 49
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

ba.if(cond:1, then:0.5, else:-0.5)  ba.if(cond, then, else)
  then.min:-4.28
  then.max:1.41
  else.min:-2.633
  else.max:1e+10
  // CONSTANT OUTPUT: the output does not move from 0.5
  // BOUNDS FROM USAGE, the values the libraries pass to it: then from -4.28 to 1.41
  // BOUNDS FROM USAGE, the values the libraries pass to it: else from -2.633 to 1e+10
  // 0 input, 1 output

ba.ifNc(n)  ba.ifNc(n)
  n.nature:table
  n.example:(1, 10, 0, 20, 30)
  // CONSTANT OUTPUT: the output does not move from 10
  // 0 input, 1 output

ba.ifNcNo(Nc:2, No:1)  ba.ifNcNo(Nc, No)
  output.min:-0.999978
  output.max:0.999985
  output.measure:silence-and-noise
  // 5 inputs, 1 output

ba.impulsify  ba.impulsify
  output.min:0
  output.max:1.99747
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.kr2ar  ba.kr2ar
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.latch  ba.latch(trig, x)
  trig.nature:signal
  trig.example:ba.pulse(32)
  x.nature:signal
  output.min:-0.999995
  output.max:0.999935
  output.measure:silence-and-noise
  // 2 inputs, 1 output

ba.lin2LogGain(n:0.5)  ba.lin2LogGain(n)
  // CONSTANT OUTPUT: the output does not move from 0.25
  // 0 input, 1 output

ba.line(n:256)  ba.line(n, x)
  x.nature:signal
  output.min:-0.0972042
  output.max:0.0904788
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.linear2db(g:0.5)  ba.linear2db(g)
  // CONSTANT OUTPUT: the output does not move from -6.0206
  // 0 input, 1 output

ba.listInterp(v)  ba.listInterp(v)
  v.nature:table
  v.example:(800,400,350,450,325)
  output.min:400.022
  output.max:800
  output.measure:silence-and-noise
  // at rest: 800 to 800; under noise: 400.022 to 800
  // 1 input, 1 output

ba.log2LinGain(n:0.25)  ba.log2LinGain(n)
  // CONSTANT OUTPUT: the output does not move from 0.5
  // 0 input, 1 output

ba.mel2hz(mel:1000.0)  ba.mel2hz(mel)
  // CONSTANT OUTPUT: the output does not move from 1000.02
  // 0 input, 1 output

ba.midikey2hz(mk:60)  ba.midikey2hz(mk)
  // CONSTANT OUTPUT: the output does not move from 261.626
  // 0 input, 1 output

ba.millisec  ba.millisec
  // CONSTANT OUTPUT: the output does not move from 48
  // 0 input, 1 output

ba.mulaw_bitcrusher(mu:2.0, nbits:8)  ba.mulaw_bitcrusher(mu, nbits, x)
  x.nature:signal
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.on_and_off(a:0, b:0)  ba.on_and_off(a, b)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

ba.parallelMax(n:3)  ba.parallelMax(n)
  output.min:-0.978719
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 1 output

ba.parallelMean(n:3)  ba.parallelMean(n)
  output.min:-0.984532
  output.max:0.974293
  output.measure:silence-and-noise
  // 3 inputs, 1 output

ba.parallelMin(n:3)  ba.parallelMin(n)
  output.min:-0.999999
  output.max:0.94525
  output.measure:silence-and-noise
  // 3 inputs, 1 output

ba.parallelOp(op, n:3)  ba.parallelOp(op, n)
  op.nature:function
  op.example:max
  output.min:-0.978719
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 1 output
  // n cannot be adjusted live: the compiler demands a constant in this place

ba.parallelRMS(n:3)  ba.parallelRMS(n)
  output.min:0
  output.max:0.989754
  output.measure:silence-and-noise
  // 3 inputs, 1 output

ba.peakhold(mode:1)  ba.peakhold(mode)
  output.min:0
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.peakholder(holdTime:ba.sec2samp(0.1))  ba.peakholder(holdTime, x)
  holdTime.unit:samples
  holdTime.min:0.001
  holdTime.max:10
  holdTime.scale:log
  x.nature:signal
  output.min:0
  output.max:0.999992
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: holdTime from 0.001 to 10
  // 1 input, 1 output

ba.period(p:64)  ba.period(p)
  output.min:0
  output.max:63
  output.measure:no-input
  // 0 input, 1 output

ba.pianokey2hz(pk:49)  ba.pianokey2hz(pk)
  // CONSTANT OUTPUT: the output does not move from 440
  // 0 input, 1 output

ba.pick(l, n:2)  ba.pick(l, n)
  l.nature:table
  l.example:(10,20,30,40)
  // CONSTANT OUTPUT: the output does not move from 30
  // 0 input, 1 output

ba.pickN(N:4, O)  ba.pickN(N, O)
  O.nature:table
  O.example:(0,2)
  output.min:-0.999991
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 2 outputs

ba.pole2tau(pole:0.9)  ba.pole2tau(pole)
  // CONSTANT OUTPUT: the output does not move from 0.000197734
  // 0 input, 1 output

ba.processArray(N:4, processor, interp, smoother, loBounds, hiBounds)  ba.processArray(N, processor, interp, smoother, loBounds, hiBounds)
  processor.nature:function
  processor.example:processArray_proc
  interp.nature:function
  interp.example:it.interpolate_linear
  smoother.nature:function
  smoother.example:si.smoo
  loBounds.nature:table
  loBounds.example:(0.1, 1.0)
  hiBounds.nature:table
  hiBounds.example:(1.0, 10.0)
  // NOT VERIFIABLE: the parameter's example relies on `processArray_proc`, defined nowhere else

ba.pulse(p:64)  ba.pulse(p)
  p.min:16
  p.max:64
  output.min:0
  output.max:1
  output.measure:no-input
  // BOUNDS FROM USAGE, the values the libraries pass to it: p from 16 to 64
  // 0 input, 1 output

ba.pulse_countdown(trig:1)  ba.pulse_countdown(trig)
  output.min:-414.636
  output.max:10.2406
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.pulse_countdown_loop(n:4, trig:1)  ba.pulse_countdown_loop(n, trig)
  output.min:-0.999944
  output.max:0.999992
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.pulse_countup(trig:1)  ba.pulse_countup(trig)
  output.min:-10.2406
  output.max:414.636
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.pulse_countup_loop(n:4, trig:1)  ba.pulse_countup_loop(n, trig)
  output.min:-220.966
  output.max:4.84078
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.pulsen(n:8, p:64)  ba.pulsen(n, p)
  output.min:0
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

ba.ramp(n:256)  ba.ramp(n)
  output.min:-0.166794
  output.max:0.165703
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.ratio2cent(ratio:1.5)  ba.ratio2cent(ratio)
  ratio.min:1
  ratio.max:20
  // CONSTANT OUTPUT: the output does not move from 701.955
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // 0 input, 1 output

ba.ratio2semi(ratio:2.0)  ba.ratio2semi(ratio)
  ratio.min:1
  ratio.max:20
  // CONSTANT OUTPUT: the output does not move from 12
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // 0 input, 1 output

ba.resetCtr(n:4, m:2)  ba.resetCtr(n, m)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

ba.sAndH  ba.sAndH(trig)
  trig.nature:signal
  trig.example:ba.pulse(32)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 2 inputs, 1 output

ba.samp2sec(n:512)  ba.samp2sec(n)
  // CONSTANT OUTPUT: the output does not move from 0.0106667
  // 0 input, 1 output

ba.sec2samp(d:0.01)  ba.sec2samp(d)
  d.unit:s
  // CONSTANT OUTPUT: the output does not move from 480
  // 0 input, 1 output

ba.select2stereo(bpc:1)  ba.select2stereo(bpc)
  output.min:-0.999999
  output.max:0.999993
  output.measure:silence-and-noise
  // 4 inputs, 2 outputs

ba.selectbus(BUS_SIZE:2, NUM_BUSES:2, id:1)  ba.selectbus(BUS_SIZE, NUM_BUSES, id)
  output.min:-0.999999
  output.max:0.999993
  output.measure:silence-and-noise
  // 4 inputs, 2 outputs
  // BUS_SIZE cannot be adjusted live: the compiler demands a constant in this place
  // NUM_BUSES cannot be adjusted live: the compiler demands a constant in this place

ba.selectmulti(n:ma.SR/100, lgen)  ba.selectmulti(n, lgen, id)
  n.unit:samples
  lgen.nature:table
  lgen.example:((_*0.5,_*0.5),(_*0.25,_*0.25))
  id.nature:signal
  id.example:int(checkbox("choice"))
  output.min:-0.499999
  output.max:0.499998
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

ba.selectn(N:4, i:2)  ba.selectn(N, i)
  i.min:0
  i.max:6
  output.min:-0.999987
  output.max:0.999993
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: i from 0 to 6
  // 4 inputs, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

ba.selectnX(N:4, i:2, sel)  ba.selectnX(N, i, sel)
  sel.nature:function
  sel.example:"\(i,j,x,y).(select2((i >= j), x, y))"
  output.min:-0.999987
  output.max:0.999993
  output.measure:silence-and-noise
  // 4 inputs, 1 output

ba.selector(i:2, n:4)  ba.selector(i, n)
  output.min:-0.999987
  output.max:0.999993
  output.measure:silence-and-noise
  // 4 inputs, 1 output
  // i cannot be adjusted live: the compiler demands a constant in this place

ba.selectoutn(N:3, s:1)  ba.selectoutn(N, s)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 3 outputs

ba.selectxbus(BUS_SIZE:2, NUM_BUSES:2, fade:16, id:0)  ba.selectxbus(BUS_SIZE, NUM_BUSES, fade, id)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 2 outputs

ba.semi2ratio(semi:7)  ba.semi2ratio(semi)
  // CONSTANT OUTPUT: the output does not move from 1.49831
  // 0 input, 1 output

ba.slidingMax(n:64, maxN:128)  ba.slidingMax(n, maxN)
  output.min:0
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.slidingMean(n:64)  ba.slidingMean(n)
  output.min:-0.278691
  output.max:0.31921
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.slidingMeanp(n:64, maxN:128)  ba.slidingMeanp(n, maxN)
  output.min:-0.27869
  output.max:0.31921
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.slidingMin(n:64, maxN:128)  ba.slidingMin(n, maxN)
  output.min:-0.999992
  output.max:0
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.slidingRMS(n:64)  ba.slidingRMS(n)
  output.min:0
  output.max:0.704404
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.slidingRMSp(n:64, maxn:128)  ba.slidingRMSp(n, maxn)
  output.min:0
  output.max:0.704422
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.slidingReduce(op, n:64, maxN:64, disabledVal:0 - ma.MAX)  ba.slidingReduce(op, n, maxN, disabledVal)
  op.nature:function
  op.example:max
  output.min:0
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output
  // maxN cannot be adjusted live: the compiler demands a constant in this place

ba.slidingSum(n:64)  ba.slidingSum(n)
  n.min:0
  output.min:-17.8362
  output.max:20.4294
  output.measure:silence-and-noise
  // BOUNDS DEDUCED, the body of the function imposes them: n at least 0
  // 1 input, 1 output

ba.slidingSump(n:64, maxN:128)  ba.slidingSump(n, maxN)
  output.min:-17.8361
  output.max:20.4295
  output.measure:silence-and-noise
  // 1 input, 1 output

ba.spulse(n:32, trig:0)  ba.spulse(n, trig)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

ba.subseq(a1, a2:1, a3:3)  ba.subseq(a1, a2, a3)
  a1.nature:table
  a1.example:(10,20,30,40,50)
  output.min:20
  output.max:40
  output.measure:no-input
  // 0 input, 3 outputs
  // a2 cannot be adjusted live: the compiler demands a constant in this place

ba.sweep(period:64, run:0)  ba.sweep(period, run)
  period.unit:samples
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

ba.tAndH  ba.tAndH(pred)
  pred.nature:signal
  pred.example:isPositive
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 2 inputs, 1 output

ba.tabulate  ba.tabulate
  // a set of definitions: mid

ba.tabulateNd  ba.tabulateNd
  // a set of definitions: val

ba.tabulate_chebychev(C:1, FX, NX:32, CD:4, r0:0, r1:127)  ba.tabulate_chebychev(C, FX, NX, CD, r0, r1, x)
  FX.nature:function
  FX.example:ba.midikey2hz
  x.nature:signal
  x.example:mk
  output.min:7.71692
  output.max:8.66193
  output.measure:silence-and-noise
  // at rest: 8.1758 to 8.1758; under noise: 7.71692 to 8.66193
  // 1 input, 1 output

ba.take(a1:3, a2)  ba.take(a1, a2)
  a2.nature:table
  a2.example:(10,20,30,40)
  // CONSTANT OUTPUT: the output does not move from 30
  // 0 input, 1 output
  // a1 cannot be adjusted live: the compiler demands a constant in this place

ba.tau2pole(tau:0.01)  ba.tau2pole(tau)
  tau.unit:s
  // CONSTANT OUTPUT: the output does not move from 0.997919
  // 0 input, 1 output

ba.tempo(t:120)  ba.tempo(t)
  // CONSTANT OUTPUT: the output does not move from 24000
  // 0 input, 1 output

ba.time  ba.time
  // OUTPUT WITHOUT RANGE: still rising after 5 s on silence (peak 2.4e+05)
  // 0 input, 1 output

ba.toggle  ba.toggle
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

co.FBFFcompressor_N_chan(strength:0.4, thresh:-12, att:0.01, rel:0.1, knee:6, prePost:0, link:0.5, FBFF:0.3, meter, N:2)  co.FBFFcompressor_N_chan(strength, thresh, att, rel, knee, prePost, link, FBFF, meter, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  meter.nature:function
  meter.example:_
  output.min:-0.565286
  output.max:0.567654
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs
  // meter is a treatment one patches in: the compiler accepts here neither value nor input

co.FBcompressor_N_chan(strength:0.5, thresh:-12, att:0.01, rel:0.1, knee:6, prePost:0, link:0.5, meter, N:2)  co.FBcompressor_N_chan(strength, thresh, att, rel, knee, prePost, link, meter, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  meter.nature:function
  meter.example:_
  output.min:-0.694228
  output.max:0.695715
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs
  // meter is a treatment one patches in: the compiler accepts here neither value nor input

co.FFcompressor_N_chan(strength:0.5, thresh:-12, att:0.01, rel:0.1, knee:6, prePost:0, link:0.5, meter, N:2)  co.FFcompressor_N_chan(strength, thresh, att, rel, knee, prePost, link, meter, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  meter.nature:function
  meter.example:_
  output.min:-0.577313
  output.max:0.578716
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs
  // meter is a treatment one patches in: the compiler accepts here neither value nor input

co.RMS_FBFFcompressor_N_chan(strength:0.4, thresh:-18, att:0.02, rel:0.12, knee:6, prePost:0, link:0.5, FBFF:0.3, meter, N:2)  co.RMS_FBFFcompressor_N_chan(strength, thresh, att, rel, knee, prePost, link, FBFF, meter, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  meter.nature:function
  meter.example:_
  output.min:-0.501369
  output.max:0.501336
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs
  // meter is a treatment one patches in: the compiler accepts here neither value nor input

co.RMS_FBcompressor_peak_limiter_N_chan(strength:0.4, thresh:-18, threshLim:-2, att:0.02, rel:0.12, knee:6, link:0.5, N:2)  co.RMS_FBcompressor_peak_limiter_N_chan(strength, thresh, threshLim, att, rel, knee, link, meter, meterLim, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  meter.nature:signal
  meterLim.nature:signal
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // DOES NOT COMPILE: ERROR : sequential composition A:B

co.RMS_compression_gain_N_chan(strength:0.5, thresh:-18, att:0.02, rel:0.12, knee:6, prePost:0, link:0.5, N:2)  co.RMS_compression_gain_N_chan(strength, thresh, att, rel, knee, prePost, link, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0.464097
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.464097 to 0.469639
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs

co.RMS_compression_gain_N_chan_db(strength:0.5, thresh:-18, att:0.02, rel:0.12, knee:6, prePost:0, link:0.5, N:2)  co.RMS_compression_gain_N_chan_db(strength, thresh, att, rel, knee, prePost, link, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:-6.66782
  output.max:0
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs

co.RMS_compression_gain_mono(strength:0.5, thresh:-18, att:0.02, rel:0.12, knee:6, prePost:0)  co.RMS_compression_gain_mono(strength, thresh, att, rel, knee, prePost)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0.463959
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.463959 to 0.4727
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

co.RMS_compression_gain_mono_db(strength:0.5, thresh:-18, att:0.02, rel:0.12, knee:6, prePost:0)  co.RMS_compression_gain_mono_db(strength, thresh, att, rel, knee, prePost)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:-6.6704
  output.max:0
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

co.compression_gain_mono(ratio:4, thresh:-9, att:0.01, rel:0.2)  co.compression_gain_mono(ratio, thresh, att, rel)
  ratio.min:1
  ratio.max:20
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0.530821
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.530821 to 0.539569
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

co.compressor_lad_mono(lad:0.005, ratio:4, thresh:-9, att:0.01, rel:0.1)  co.compressor_lad_mono(lad, ratio, thresh, att, rel, x)
  lad.unit:s
  ratio.min:1
  ratio.max:20
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  x.nature:signal
  output.min:-0.571527
  output.max:0.571067
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

co.compressor_mono(ratio:4, thresh:-9, att:0.01, rel:0.2)  co.compressor_mono(ratio, thresh, att, rel, x)
  ratio.min:1
  ratio.max:20
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  x.nature:signal
  output.min:-0.538918
  output.max:0.538161
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

co.compressor_stereo(ratio:4, thresh:-9, att:0.01, rel:0.2)  co.compressor_stereo(ratio, thresh, att, rel, x, y)
  ratio.min:1
  ratio.max:20
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  x.nature:signal
  y.nature:signal
  output.min:-0.346446
  output.max:0.346301
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs

co.expanderSC_N_chan(strength:0.5, thresh:-40, range:20, att:0.05, hold:0.02, rel:0.2, knee:6, prePost:0, link:0.5, maxHold:4096, N:2, SCfunction, SCswitch:1)  co.expanderSC_N_chan(strength, thresh, range, att, hold, rel, knee, prePost, link, meter, maxHold, N, SCfunction, SCswitch, SCsignal)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  range.unit:dB
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  hold.min:0.001
  hold.max:10
  hold.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  maxHold.unit:samples
  meter.nature:signal
  SCfunction.nature:function
  SCsignal.nature:signal
  SCsignal.example:os.osc(880)
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

co.expander_N_chan(strength:0.5, thresh:-40, range:20, att:0.05, hold:0.02, rel:0.2, knee:6, prePost:0, link:0.5, meter, maxHold:4096, N:2)  co.expander_N_chan(strength, thresh, range, att, hold, rel, knee, prePost, link, meter, maxHold, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  range.unit:dB
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  hold.min:0.001
  hold.max:10
  hold.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  maxHold.unit:samples
  meter.nature:function
  meter.example:_
  output.min:-9.99999
  output.max:9.99977
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs
  // meter is a treatment one patches in: the compiler accepts here neither value nor input

co.limiter_1176_R4_mono  co.limiter_1176_R4_mono(x)
  x.nature:signal
  x.example:os.osc(440)
  output.min:-0.616571
  output.max:0.61662
  output.measure:silence-and-noise
  // 1 input, 1 output

co.limiter_1176_R4_stereo  co.limiter_1176_R4_stereo(x, y)
  x.nature:signal
  x.example:os.osc(440)
  y.nature:signal
  y.example:os.osc(660)
  output.min:-0.386047
  output.max:0.385808
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

co.limiter_lad_N(N:2, LD:0.01, ceiling:1, attack:0.01, hold:0.05, release:0.2)  co.limiter_lad_N(N, LD, ceiling, attack, hold, release)
  LD.unit:s
  attack.unit:s
  attack.min:0.001
  attack.max:10
  attack.scale:log
  hold.unit:s
  hold.min:0.001
  hold.max:10
  hold.scale:log
  release.unit:s
  release.min:0.001
  release.max:10
  release.scale:log
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: attack from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: release from 0.001 to 10
  // 2 inputs, 2 outputs
  // N cannot be adjusted live: the compiler demands a constant in this place

co.limiter_lad_bw  co.limiter_lad_bw
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

co.limiter_lad_mono(LD:0.01)  co.limiter_lad_mono(LD)
  LD.unit:s
  output.min:-0.986331
  output.max:1.00864
  output.measure:silence-and-noise
  // 5 inputs, 1 output

co.limiter_lad_quad(LD:0.01)  co.limiter_lad_quad(LD)
  LD.unit:s
  output.min:-0.0239385
  output.max:0.022116
  output.measure:silence-and-noise
  // 8 inputs, 4 outputs

co.limiter_lad_stereo(LD:0.01)  co.limiter_lad_stereo(LD)
  LD.unit:s
  output.min:-0.0216512
  output.max:0.0219021
  output.measure:silence-and-noise
  // 6 inputs, 2 outputs

co.peak_compression_gain_N_chan(strength:0.5, thresh:-12, att:0.01, rel:0.1, knee:6, prePost:0, link:0.5, N:2)  co.peak_compression_gain_N_chan(strength, thresh, att, rel, knee, prePost, link, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0.569861
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.569861 to 0.579099
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs

co.peak_compression_gain_N_chan_db(strength:0.5, thresh:-12, att:0.01, rel:0.1, knee:6, prePost:0, link:0.5, N:2)  co.peak_compression_gain_N_chan_db(strength, thresh, att, rel, knee, prePost, link, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:-4.88463
  output.max:0
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs

co.peak_compression_gain_mono(strength:0.5, thresh:-12, att:0.01, rel:0.1, knee:6, prePost:0)  co.peak_compression_gain_mono(strength, thresh, att, rel, knee, prePost)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:0.569896
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.569896 to 0.581066
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

co.peak_compression_gain_mono_db(strength:0.5, thresh:-12, att:0.01, rel:0.1, knee:6, prePost:0)  co.peak_compression_gain_mono_db(strength, thresh, att, rel, knee, prePost)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  output.min:-4.88409
  output.max:0
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

co.peak_expansion_gain_N_chan_db(strength:0.5, thresh:-40, range:20, att:0.05, hold:0.01, rel:0.2, knee:6, prePost:0, link:0.5, maxHold:2048, N:2)  co.peak_expansion_gain_N_chan_db(strength, thresh, range, att, hold, rel, knee, prePost, link, maxHold, N)
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  range.unit:dB
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  hold.unit:s
  hold.min:0.001
  hold.max:10
  hold.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  maxHold.unit:samples
  // CONSTANT OUTPUT: the output does not move from 20
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs

co.peak_expansion_gain_mono_db(maxHold:2048, strength:0.5, thresh:-40, range:20, attack:0.05, hold:0.01, release:0.2, knee:6, prePost:0)  co.peak_expansion_gain_mono_db(maxHold, strength, thresh, range, attack, hold, release, knee, prePost)
  maxHold.unit:samples
  strength.min:0
  strength.max:2
  thresh.min:-80
  thresh.max:0
  range.unit:dB
  attack.unit:s
  attack.min:0.001
  attack.max:10
  attack.scale:log
  hold.unit:s
  hold.min:0.001
  hold.max:10
  hold.scale:log
  release.unit:s
  release.min:0.001
  release.max:10
  release.scale:log
  // CONSTANT OUTPUT: the output does not move from 20
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: attack from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: release from 0.001 to 10
  // 1 input, 1 output

co.ratio2strength(ratio:4)  co.ratio2strength(ratio)
  ratio.min:1
  ratio.max:20
  // CONSTANT OUTPUT: the output does not move from 0.75
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // 0 input, 1 output

co.strength2ratio(strength:0.75)  co.strength2ratio(strength)
  strength.min:0
  strength.max:2
  // CONSTANT OUTPUT: the output does not move from 4
  // BOUNDS GUESSED, from the parameter name: strength from 0 to 2
  // 0 input, 1 output

db.DEBUG  db.DEBUG
  // CONSTANT OUTPUT: the output does not move from 1
  // 0 input, 1 output

db.probe_attack_state(id:41, hide:1, floor_db:-60)  db.probe_attack_state(id, hide, floor_db, x)
  floor_db.unit:dB
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_band_hi(id:15, hide:1)  db.probe_band_hi(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_band_lo(id:13, hide:1)  db.probe_band_lo(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_band_mid(id:14, hide:1)  db.probe_band_mid(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_below_threshold(id:40, hide:1, thresh_db:-40)  db.probe_below_threshold(id, hide, thresh_db, x)
  thresh_db.unit:dB
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_bool(id:12, hide:1)  db.probe_bool(id, hide, x)
  x.nature:signal
  x.example:mono > 0
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_crest_db(id:4, hide:1)  db.probe_crest_db(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_dc(id:8, hide:1)  db.probe_dc(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_dc_precise(id:56, hide:1)  db.probe_dc_precise(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_env(id:5, hide:1)  db.probe_env(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_env_db(id:38, hide:1, att:0.001, rel:0.1)  db.probe_env_db(id, hide, att, rel, x)
  att.unit:s
  rel.unit:s
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output
  // att cannot be adjusted live: the compiler demands a constant in this place
  // rel cannot be adjusted live: the compiler demands a constant in this place

db.probe_env_lin(id:37, hide:1, att:0.001, rel:0.1)  db.probe_env_lin(id, hide, att, rel, x)
  att.unit:s
  rel.unit:s
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output
  // att cannot be adjusted live: the compiler demands a constant in this place
  // rel cannot be adjusted live: the compiler demands a constant in this place

db.probe_freq_db(id:35, hide:1, freq:440, q:10)  db.probe_freq_db(id, hide, freq, q, x)
  freq.unit:Hz
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output
  // freq cannot be adjusted live: the compiler demands a constant in this place
  // q cannot be adjusted live: the compiler demands a constant in this place

db.probe_freq_lin(id:34, hide:1, freq:440, q:10)  db.probe_freq_lin(id, hide, freq, q, x)
  freq.unit:Hz
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output
  // freq cannot be adjusted live: the compiler demands a constant in this place
  // q cannot be adjusted live: the compiler demands a constant in this place

db.probe_freq_ratio(id:36, hide:1, f1:440, f2:660, q:12)  db.probe_freq_ratio(id, hide, f1, f2, q, x)
  f1.unit:Hz
  f2.unit:Hz
  q.min:0.5
  q.max:50
  q.scale:log
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: q from 0.5 to 50
  // 1 input, 1 output

db.probe_max(id:7, hide:1)  db.probe_max(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_min(id:6, hide:1)  db.probe_min(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_multiband(id:44, hide:1)  db.probe_multiband(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_onset(id:42, hide:1, thresh_db:-40, holdoff_ms:50)  db.probe_onset(id, hide, thresh_db, holdoff_ms, x)
  holdoff_ms.unit:ms
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_peak_db(id:2, hide:1)  db.probe_peak_db(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_peak_hold(id:39, hide:1, decay_s:2.0)  db.probe_peak_hold(id, hide, decay_s, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_peak_lin(id:3, hide:1)  db.probe_peak_lin(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_rms_db(id:0, hide:1)  db.probe_rms_db(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output
  // id cannot be adjusted live: the compiler demands a constant in this place

db.probe_rms_lin(id:1, hide:1)  db.probe_rms_lin(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_sample_count(id:58, hide:1)  db.probe_sample_count(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_silence(id:57, hide:1, thresh_db:-60)  db.probe_silence(id, hide, thresh_db, x)
  thresh_db.unit:dB
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_slew(id:9, hide:1)  db.probe_slew(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_spectral_centroid(id:43, hide:1)  db.probe_spectral_centroid(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_tap(f)  db.probe_tap(f, x)
  f.nature:expression
  f.example:db.probe_rms_db(16, 1)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output
  // f is not an input: the compiler accepts it only in the form of its example

db.probe_tap_n(n:2, f)  db.probe_tap_n(n, f)
  f.nature:function
  f.example:+ : db.probe_rms_db(100, 1)
  output.min:-0.999991
  output.max:0.999953
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

db.probe_time_ms(id:59, hide:1)  db.probe_time_ms(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_value(id:11, hide:1)  db.probe_value(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

db.probe_zcr(id:10, hide:1)  db.probe_zcr(id, hide, x)
  x.nature:signal
  x.example:os.osc(220)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

de.delay(n:44100, d:22050)  de.delay(n, d, x)
  n.unit:samples
  n.min:4096
  n.max:2.09715e+06
  n.scale:log
  d.unit:samples
  d.min:0
  x.nature:signal
  output.min:-0.999992
  output.max:0.999928
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: n from 4096 to 2.09715e+06
  // BOUNDS DEDUCED, the body of the function imposes them: d at least 0
  // 1 input, 1 output

de.fdelay(n:44100, d:22050.5)  de.fdelay(n, d, x)
  n.unit:samples
  n.min:512
  n.max:2.09715e+06
  n.scale:log
  d.unit:samples
  x.nature:signal
  output.min:-0.995684
  output.max:0.998017
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: n from 512 to 2.09715e+06
  // 1 input, 1 output

de.fdelaylti(N:3, n:44100, d:22050.5)  de.fdelaylti(N, n, d, x)
  n.unit:samples
  d.unit:samples
  x.nature:signal
  output.min:-1.22112
  output.max:1.2174
  output.measure:silence-and-noise
  // 1 input, 1 output

de.fdelayltv(N:2, n:2, d)  de.fdelayltv(N, n, d, x)
  N.min:1
  N.max:5
  n.unit:samples
  d.unit:samples
  x.nature:signal
  // GUESSED: n:2, from the parameter name
  // BOUNDS FROM USAGE, the values the libraries pass to it: N from 1 to 5
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: d has no starting value

de.multiTapSincDelay(K:2, MaxDelay:4096, tau1:1024.0, tau2:1536.0, alpha:0.5)  de.multiTapSincDelay(K, MaxDelay, tau1, tau2, alpha, input)
  MaxDelay.unit:samples
  tau1.unit:samples
  tau2.unit:samples
  alpha.min:0
  alpha.max:1
  input.nature:signal
  output.min:-1.78848
  output.max:1.71282
  output.measure:silence-and-noise
  // 1 input, 1 output

de.prime_power_delays(N:4, pathmin:1, pathmax:10)  de.prime_power_delays(N, pathmin, pathmax)
  output.min:128
  output.max:2401
  output.measure:no-input
  // 0 input, 4 outputs

de.sdelay(n:44100, it:1024, d:22050.5)  de.sdelay(n, it, d)
  n.unit:samples
  it.unit:samples
  d.unit:samples
  output.min:-0.999992
  output.max:0.999928
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.colored_noise_demo  dm.colored_noise_demo
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

dm.compressor_demo  dm.compressor_demo
  output.min:-4.91815
  output.max:4.91384
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.crybaby_demo  dm.crybaby_demo
  output.min:-1.78878
  output.max:1.86324
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.cubicnl_demo  dm.cubicnl_demo
  output.min:-0.746181
  output.max:0.741989
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.dattorro_rev_demo  dm.dattorro_rev_demo
  output.min:-0.562392
  output.max:0.557099
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.envelopes_demo  dm.envelopes_demo
  output.min:0
  output.max:0.250002
  output.measure:no-input
  // 0 input, 8 outputs

dm.exciter  dm.exciter
  output.min:-0.556077
  output.max:0.559463
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.fdnrev0_demo(N:16, NB:5, BBSO:3)  dm.fdnrev0_demo(N, NB, BBSO, x, y)
  x.nature:signal
  y.nature:signal
  output.min:-0.141418
  output.max:0.124513
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.fft_spectral_level_demo(N:256)  dm.fft_spectral_level_demo(N)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.filterbank_demo  dm.filterbank_demo
  output.min:-0.813359
  output.max:0.744256
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.flanger_demo  dm.flanger_demo
  output.min:-0.991484
  output.max:0.98313
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.freeverb_demo  dm.freeverb_demo
  output.min:-1.07313
  output.max:1.1026
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.gate_demo  dm.gate_demo
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.greyhole_demo  dm.greyhole_demo
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 6.011)
  // 2 inputs, 2 outputs

dm.ja_transformer_demo  dm.ja_transformer_demo
  output.min:-1.158
  output.max:1.14465
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.jprev_demo  dm.jprev_demo
  output.min:-2.62015
  output.max:2.68627
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.kb_rom_rev1_demo  dm.kb_rom_rev1_demo
  output.min:-2.72746
  output.max:2.87784
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.latch_demo  dm.latch_demo
  output.min:-1.00191
  output.max:1.00191
  output.measure:no-input
  // 0 input, 3 outputs

dm.moog_vcf_demo  dm.moog_vcf_demo
  output.min:-0.1521
  output.max:0.166385
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.motion_wrapper_demo  dm.motion_wrapper_demo
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 18 inputs, 92 outputs

dm.mth_octave_filterbank_demo(O:1)  dm.mth_octave_filterbank_demo(O)
  output.min:-0.813359
  output.max:0.744256
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.mth_octave_spectral_level_demo(BPO:1.5)  dm.mth_octave_spectral_level_demo(BPO)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.orientation6_demo  dm.orientation6_demo
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 6 outputs

dm.oscr_demo  dm.oscr_demo
  output.min:-0.100486
  output.max:0.100484
  output.measure:no-input
  // 0 input, 1 output

dm.oscrs_demo  dm.oscrs_demo
  output.min:-0.100486
  output.max:0.100484
  output.measure:no-input
  // 0 input, 1 output

dm.parametric_eq_demo  dm.parametric_eq_demo
  output.min:-2.18179
  output.max:2.16934
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.phaser2_demo  dm.phaser2_demo
  output.min:-1.55499
  output.max:1.56477
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.pospass_demo  dm.pospass_demo(x)
  x.nature:signal
  x.example:monoOsc(440)
  output.min:-0.117809
  output.max:0.117809
  output.measure:silence-and-noise
  // at rest: -0.117809 to 0.117809; under noise: -0.117809 to 0.117809
  // 1 input, 2 outputs

dm.projected_gravity_demo  dm.projected_gravity_demo
  output.min:-0.0953039
  output.max:0.0973182
  output.measure:no-input
  // 0 input, 1 output

dm.reverbTank_demo  dm.reverbTank_demo
  output.min:-0.251942
  output.max:0.248141
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.reverse_echo_demo(nChans:3)  dm.reverse_echo_demo(nChans)
  output.min:-1.33807
  output.max:1.34105
  output.measure:silence-and-noise
  // 1 input, 2 outputs

dm.sawtooth_demo  dm.sawtooth_demo
  output.min:-0.00988535
  output.max:0.00985706
  output.measure:silence-and-noise
  // at rest: -0.00988535 to 0.00985706; under noise: -0.00988535 to 0.00985706
  // 1 input, 1 output

dm.shock_trigger_demo  dm.shock_trigger_demo
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

dm.spectral_level_demo  dm.spectral_level_demo
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.spectral_tilt_demo(N:4)  dm.spectral_tilt_demo(N)
  output.min:-0.309624
  output.max:0.33301
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.springreverb_demo  dm.springreverb_demo
  output.min:-1.12893
  output.max:1.12379
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.stereo_reverb_tester(revin_group)  dm.stereo_reverb_tester(revin_group, x, y)
  revin_group.nature:function
  x.nature:signal
  y.nature:signal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

dm.tapeStop_demo  dm.tapeStop_demo
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.total_accel_demo  dm.total_accel_demo
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

dm.twin_osc_demo  dm.twin_osc_demo
  output.min:-0.786652
  output.max:0.383445
  output.measure:no-input
  // 0 input, 2 outputs

dm.velvet_noise_demo  dm.velvet_noise_demo
  output.min:-0.316228
  output.max:0.316228
  output.measure:no-input
  // 0 input, 1 output

dm.virtual_analog_oscillator_demo  dm.virtual_analog_oscillator_demo
  output.min:-0.0986835
  output.max:0.0986355
  output.measure:silence-and-noise
  // at rest: -0.0986835 to 0.0986355; under noise: -0.0986835 to 0.0986355
  // 1 input, 1 output

dm.vital_rev_demo  dm.vital_rev_demo
  output.min:-0.813256
  output.max:0.767928
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.vocoder_demo  dm.vocoder_demo
  output.min:-1.13841
  output.max:1.82771
  output.measure:silence-and-noise
  // 1 input, 2 outputs

dm.wah4_demo  dm.wah4_demo
  output.min:-0.5263
  output.max:0.526713
  output.measure:silence-and-noise
  // 1 input, 1 output

dm.zita_light  dm.zita_light
  output.min:-0.530035
  output.max:0.500878
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.zita_rev1  dm.zita_rev1(x, y)
  x.nature:signal
  x.example:stereoOsc(440, 442)
  y.nature:signal
  output.min:-0.105761
  output.max:0.099943
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

dm.zita_rev_fdn_demo  dm.zita_rev_fdn_demo
  output.min:-8.02948
  output.max:8.13812
  output.measure:silence-and-noise
  // 8 inputs, 8 outputs

dx.algorithm(algo:1)  dx.algorithm(algo)
  output.min:-6.37372e-05
  output.max:6.37373e-05
  output.measure:no-input
  // 0 input, 1 output
  // algo cannot be adjusted live: the compiler demands a constant in this place

dx.algorithms  dx.algorithms
  // DOES NOT COMPILE: the compiler fails: Aborted(native code called abort())

dx.env(rates, levels, outlevel:80, rate_scaling:90, gate:0)  dx.env(rates, levels, outlevel, rate_scaling, gate)
  rates.nature:table
  rates.example:(60,61,62,63)
  levels.nature:table
  levels.example:(60,61,62,63)
  // CONSTANT OUTPUT: the output does not move from 1.04858e+06
  // 0 input, 1 output

dx.fdbkscalef(feedback:0.5)  dx.fdbkscalef(feedback)
  feedback.min:0
  feedback.max:1
  // CONSTANT OUTPUT: the output does not move from 0.0110485
  // BOUNDS GUESSED, from the parameter name: feedback from 0 to 1
  // 0 input, 1 output

dx.fdbkscalef2(feedback:0.5)  dx.fdbkscalef2(feedback)
  feedback.min:0
  feedback.max:1
  // CONSTANT OUTPUT: the output does not move from 0.00276214
  // BOUNDS GUESSED, from the parameter name: feedback from 0 to 1
  // 0 input, 1 output

dx.lfo(lfoWave:1, lfoDelay:50, lfoSync:0, lfoSpeed:35, gate:0)  dx.lfo(lfoWave, lfoDelay, lfoSync, lfoSpeed, gate)
  lfoWave.min:0
  lfoWave.max:5
  lfoDelay.min:0
  lfoDelay.max:99
  lfoSync.min:0
  lfoSync.max:1
  lfoSpeed.min:0
  lfoSpeed.max:99
  output.min:7.39098e-06
  output.max:1
  output.measure:no-input
  // 0 input, 2 outputs

dx.operator(mode:0, freqCoarse:1, freqFine:0, detune:0, outLev:99, R1:99, R2:99, R3:99, R4:99, L1:0, L2:0, L3:0, L4:0, keyVelSens:0, ampModSens:0, rateScale:0, breakpoint:4, breakpointLDepth:35, breakpointRDepth:0, breakpointLCurve:0, breakpointRCurve:0, lfoWave:1, lfoSpeed:3, lfoDelay:99, lfoPMD:99, lfoAMD:99, lfoSync:99, lfoPitchModSens:0, oscKeySync:0, pitch_egR1:0, pitch_egR2:0, pitch_egR3:50, pitch_egR4:0, pitch_egL1:0, pitch_egL2:0, pitch_egL3:0, pitch_egL4:0, transpose:-12, phaseMod:0, base_freq_:440.0, gain:1.0, gate:0)  dx.operator(mode, freqCoarse, freqFine, detune, outLev, R1, R2, R3, R4, L1, L2, L3, L4, keyVelSens, ampModSens, rateScale, breakpoint, breakpointLDepth, breakpointRDepth, breakpointLCurve, breakpointRCurve, lfoWave, lfoSpeed, lfoDelay, lfoPMD, lfoAMD, lfoSync, lfoPitchModSens, oscKeySync, pitch_egR1, pitch_egR2, pitch_egR3, pitch_egR4, pitch_egL1, pitch_egL2, pitch_egL3, pitch_egL4, transpose, phaseMod, base_freq_, gain, gate)
  freqCoarse.min:0
  freqCoarse.max:31
  freqFine.min:0
  freqFine.max:99
  detune.min:-7
  detune.max:7
  outLev.min:0
  outLev.max:99
  R1.min:0
  R1.max:99
  R2.min:0
  R2.max:99
  R3.min:0
  R3.max:99
  R4.min:0
  R4.max:99
  L1.min:0
  L1.max:99
  L2.min:0
  L2.max:99
  L3.min:0
  L3.max:99
  L4.min:0
  L4.max:99
  keyVelSens.min:0
  keyVelSens.max:7
  ampModSens.min:0
  ampModSens.max:3
  rateScale.min:0
  rateScale.max:7
  breakpoint.min:0
  breakpoint.max:99
  breakpointLDepth.min:0
  breakpointLDepth.max:99
  breakpointRDepth.min:0
  breakpointRDepth.max:99
  breakpointLCurve.min:0
  breakpointLCurve.max:3
  breakpointRCurve.min:0
  breakpointRCurve.max:3
  lfoWave.min:0
  lfoWave.max:5
  lfoSpeed.min:0
  lfoSpeed.max:99
  lfoDelay.min:0
  lfoDelay.max:99
  lfoPMD.min:0
  lfoPMD.max:99
  lfoAMD.min:0
  lfoAMD.max:99
  lfoPitchModSens.min:0
  lfoPitchModSens.max:7
  oscKeySync.min:0
  oscKeySync.max:1
  pitch_egR1.min:0
  pitch_egR1.max:99
  pitch_egR2.min:0
  pitch_egR2.max:99
  pitch_egR3.min:0
  pitch_egR3.max:99
  pitch_egR4.min:0
  pitch_egR4.max:99
  pitch_egL1.min:0
  pitch_egL1.max:99
  pitch_egL2.min:0
  pitch_egL2.max:99
  pitch_egL3.min:0
  pitch_egL3.max:99
  pitch_egL4.min:0
  pitch_egL4.max:99
  transpose.min:-24
  transpose.max:24
  phaseMod.min:-1
  phaseMod.max:1
  base_freq_.min:50
  base_freq_.max:1000
  gain.min:0
  gain.max:1
  output.min:-3.18687e-05
  output.max:3.18687e-05
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: base_freq_ from 50 to 1000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 1
  // 0 input, 1 output
  // the bounds stated for lfoSync (0 to 1) are not kept: lfoSync:99 falls outside

dx.pitchenv(rates, levels, gate:0)  dx.pitchenv(rates, levels, gate)
  rates.nature:table
  rates.example:(60,61,62,63)
  levels.nature:table
  levels.example:(60,61,62,63)
  // CONSTANT OUTPUT: the output does not move from 6.81574e+06
  // 0 input, 1 output

ef.cubicnl(drive:0.5, offset:0.0)  ef.cubicnl(drive, offset)
  drive.min:0
  drive.max:1
  output.min:-0.666667
  output.max:0.666667
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.cubicnl_nodc(drive:0.0, offset:0)  ef.cubicnl_nodc(drive, offset)
  drive.min:0
  drive.max:1
  output.min:-0.74618
  output.max:0.741989
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.dither(nbits:16)  ef.dither(nbits)
  output.min:-1
  output.max:0.999969
  output.measure:silence-and-noise
  // at rest: -3.05176e-05 to 3.05176e-05; under noise: -1 to 0.999969
  // 1 input, 1 output

ef.dither_shaped(K:2, nbits:16)  ef.dither_shaped(K, nbits)
  output.min:-1.00003
  output.max:0.999908
  output.measure:silence-and-noise
  // at rest: -0.00012207 to 0.00012207; under noise: -1.00003 to 0.999908
  // 1 input, 1 output

ef.doppler_shift(freq:220, ratio:1.5)  ef.doppler_shift(freq, ratio, sig)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  ratio.min:1
  ratio.max:20
  sig.nature:signal
  output.min:-1.36083
  output.max:1.34739
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // 1 input, 1 output

ef.dryWetMixer(wetAmount:0.5, FX)  ef.dryWetMixer(wetAmount, FX)
  wetAmount.min:0
  wetAmount.max:1
  FX.nature:function
  FX.example:fi.dcblocker
  output.min:-1.04898
  output.max:1.04229
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.dryWetMixerConstantPower(wetAmount:0.5, FX)  ef.dryWetMixerConstantPower(wetAmount, FX)
  wetAmount.min:0
  wetAmount.max:1
  FX.nature:function
  FX.example:fi.dcblocker
  output.min:-1.04898
  output.max:1.04229
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.echo(maxDuration:0.5, duration:0.25, feedback:0.4)  ef.echo(maxDuration, duration, feedback)
  maxDuration.unit:s
  duration.unit:s
  feedback.min:0
  feedback.max:1
  output.min:-1.58294
  output.max:1.58513
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: feedback from 0 to 1
  // 1 input, 1 output

ef.fibonacci(order:2)  ef.fibonacci(order)
  // OUTPUT NOT FINITE: NaN or infinity on noise (191872 samples out of 191872)
  // 1 input, 1 output

ef.fibonacciGeneral(wave)  ef.fibonacciGeneral(wave)
  wave.nature:table
  wave.example:"waveform{2, 3}"
  // OUTPUT NOT FINITE: NaN or infinity on noise (191872 samples out of 191872)
  // 1 input, 1 output

ef.fibonacciSeq(N:5)  ef.fibonacciSeq(N)
  output.min:1
  output.max:5
  output.measure:no-input
  // 0 input, 5 outputs

ef.gate_gain_mono(thresh:-60, att:0.0001, hold:0.1, rel:0.02)  ef.gate_gain_mono(thresh, att, hold, rel, x)
  thresh.min:-80
  thresh.max:0
  att.unit:s
  hold.unit:s
  hold.min:0.001
  hold.max:10
  hold.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  x.nature:signal
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

ef.gate_mono(thresh:-60, att:0.0001, hold:0.1, rel:0.02)  ef.gate_mono(thresh, att, hold, rel, x)
  thresh.min:-80
  thresh.max:0
  att.unit:s
  hold.unit:s
  hold.min:0.001
  hold.max:10
  hold.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  x.nature:signal
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

ef.gate_stereo(thresh:-60, att:0.0001, hold:0.1, rel:0.02)  ef.gate_stereo(thresh, att, hold, rel, x, y)
  thresh.min:-80
  thresh.max:0
  att.unit:s
  hold.unit:s
  hold.min:0.001
  hold.max:10
  hold.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  x.nature:signal
  y.nature:signal
  output.min:-0.999998
  output.max:0.999977
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: thresh from -80 to 0
  // BOUNDS GUESSED, from the parameter name: hold from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 2 outputs

ef.granular(P:4, dur:0.05, ratio:1.5, pos:0.2, jit:0.1)  ef.granular(P, dur, ratio, pos, jit, sig)
  dur.unit:s
  ratio.min:1
  ratio.max:20
  pos.unit:s
  jit.unit:s
  sig.nature:signal
  output.min:-0.92216
  output.max:0.912656
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: ratio from 1 to 20
  // 1 input, 1 output

ef.mesh_square(N:1)  ef.mesh_square(N)
  output.min:-1.94538
  output.max:1.92895
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ef.mixLinearClamp(N:4, C:1, mix:1.2)  ef.mixLinearClamp(N, C, mix)
  mix.min:1
  mix.max:1.2
  output.min:-0.999462
  output.max:0.998584
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: mix from 1 to 1.2
  // 4 inputs, 1 output

ef.mixLinearLoop(N:4, C:1, mix:-0.3)  ef.mixLinearLoop(N, C, mix)
  mix.min:-4
  mix.max:4
  output.min:-0.99806
  output.max:0.99776
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: mix from -4 to 4
  // 4 inputs, 1 output

ef.mixPowerClamp(N:4, C:1, mix:1.5)  ef.mixPowerClamp(N, C, mix)
  output.min:-0.999447
  output.max:0.998161
  output.measure:silence-and-noise
  // 4 inputs, 1 output

ef.mixPowerLoop(N:4, C:1, mix:-0.5)  ef.mixPowerLoop(N, C, mix)
  mix.min:-4
  mix.max:4
  output.min:-0.997765
  output.max:0.997099
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: mix from -4 to 4
  // 4 inputs, 1 output

ef.ms_dec  ef.ms_dec
  output.min:-1.99822
  output.max:1.9936
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

ef.ms_enc  ef.ms_enc
  output.min:-0.999112
  output.max:0.996798
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

ef.piano_dispersion_filter(M:4, B:0.0001, f0:110)  ef.piano_dispersion_filter(M, B, f0)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  output.min:-30.5064
  output.max:2.23613
  output.measure:silence-and-noise
  // at rest: -30.5064 to 0; under noise: -30.5064 to 2.23613
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // 1 input, 2 outputs

ef.reverseDelayRamped(delMax:32, phs:0.6)  ef.reverseDelayRamped(delMax, phs)
  phs.min:0
  phs.max:1
  output.min:-0.996068
  output.max:0.996008
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.reverseEchoN(N:2, delMax:32)  ef.reverseEchoN(N, delMax)
  output.min:-0.999924
  output.max:0.999916
  output.measure:silence-and-noise
  // 1 input, 2 outputs

ef.softclipQuadratic  ef.softclipQuadratic(x)
  x.nature:signal
  x.example:os.osc(440)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.speakerbp(f1:100.0, f2:5000.0)  ef.speakerbp(f1, f2)
  f1.unit:Hz
  f2.unit:Hz
  output.min:-0.963327
  output.max:1.03783
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.stereo_width(w:0.5)  ef.stereo_width(w)
  w.min:0
  w.max:1
  output.min:-1.49706
  output.max:1.49498
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

ef.tapeStop(C:2, LAGRANGE_ORDER:3, MAX_TIME_SAMP:44100, crossfade:128, gainAlpha:1.0, stopAlpha:1.0, stopTime:22050, stop:0)  ef.tapeStop(C, LAGRANGE_ORDER, MAX_TIME_SAMP, crossfade, gainAlpha, stopAlpha, stopTime, stop)
  MAX_TIME_SAMP.unit:samples
  crossfade.unit:samples
  gainAlpha.min:0.01
  gainAlpha.max:2
  gainAlpha.scale:log
  stopAlpha.min:0.01
  stopAlpha.max:2
  stopAlpha.scale:log
  stopTime.unit:samples
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

ef.transpose(w:1024, s:7)  ef.transpose(w, x, s, sig)
  w.unit:samples
  x.nature:signal
  sig.nature:signal
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 5.114e+06)
  // 2 inputs, 1 output

ef.transpose_windowed(P:2, w:1024, s:7)  ef.transpose_windowed(P, w, s, sig)
  w.unit:samples
  sig.nature:signal
  output.min:-0.993726
  output.max:0.993117
  output.measure:silence-and-noise
  // 1 input, 1 output

ef.uniformPanToStereo(N:3)  ef.uniformPanToStereo(N)
  output.min:-1.49916
  output.max:1.49739
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

ef.wavefold(width:0.5)  ef.wavefold(width)
  width.min:0
  width.max:1
  output.min:-0.999993
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

en.adsr(at:0.05, dt:0.1, sl:0.6, rt:0.3, gate:0)  en.adsr(at, dt, sl, rt, gate)
  at.unit:s
  dt.unit:s
  sl.min:0
  sl.max:1
  rt.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.adsr_bias(att:0.05, dec:0.1, sus:0.6, rel:0.4, bias_att:0.4, bias_dec:0.6, bias_rel:0.5, legato:0, gate:0)  en.adsr_bias(att, dec, sus, rel, bias_att, bias_dec, bias_rel, legato, gate)
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  dec.unit:s
  dec.min:0.001
  dec.max:10
  dec.scale:log
  sus.min:0
  sus.max:1
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  bias_att.min:0
  bias_att.max:1
  bias_dec.min:0
  bias_dec.max:1
  bias_rel.min:0
  bias_rel.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: dec from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 0 input, 1 output

en.adsre(attT60:0.2, decT60:0.1, susLvl:0.6, relT60:0.4, gate:0)  en.adsre(attT60, decT60, susLvl, relT60, gate)
  attT60.unit:s
  decT60.unit:s
  susLvl.min:0
  susLvl.max:1
  relT60.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.adsrf_bias(att:0.05, dec:0.1, sus:0.6, rel:0.4, final:0.2, bias_att:0.4, bias_dec:0.6, bias_rel:0.5, legato:0, gate:0)  en.adsrf_bias(att, dec, sus, rel, final, bias_att, bias_dec, bias_rel, legato, gate)
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  dec.unit:s
  dec.min:0.001
  dec.max:10
  dec.scale:log
  sus.min:0
  sus.max:1
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  final.min:0
  final.max:1
  bias_att.min:0
  bias_att.max:1
  bias_dec.min:0
  bias_dec.max:1
  bias_rel.min:0
  bias_rel.max:1
  // CONSTANT OUTPUT: the output does not move from 0.2
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: dec from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 0 input, 1 output

en.ahdsr_bias(att:0.05, hol:0.05, dec:0.1, sus:0.6, rel:0.4, bias_att:0.4, bias_dec:0.6, bias_rel:0.5, legato:0, gate:0)  en.ahdsr_bias(att, hol, dec, sus, rel, bias_att, bias_dec, bias_rel, legato, gate)
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  hol.unit:s
  dec.unit:s
  dec.min:0.001
  dec.max:10
  dec.scale:log
  sus.min:0
  sus.max:1
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  bias_att.min:0
  bias_att.max:1
  bias_dec.min:0
  bias_dec.max:1
  bias_rel.min:0
  bias_rel.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: dec from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 0 input, 1 output

en.ahdsre(attT60:0.2, htT60:0.05, decT60:0.1, susLvl:0.6, relT60:0.4, gate:0)  en.ahdsre(attT60, htT60, decT60, susLvl, relT60, gate)
  attT60.unit:s
  htT60.unit:s
  decT60.unit:s
  susLvl.min:0
  susLvl.max:1
  relT60.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.ahdsrf_bias(att:0.05, hol:0.05, dec:0.1, sus:0.6, rel:0.4, final:0.2, bias_att:0.4, bias_dec:0.6, bias_rel:0.5, legato:0, gate:0)  en.ahdsrf_bias(att, hol, dec, sus, rel, final, bias_att, bias_dec, bias_rel, legato, gate)
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  hol.unit:s
  dec.unit:s
  dec.min:0.001
  dec.max:10
  dec.scale:log
  sus.min:0
  sus.max:1
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  final.min:0
  final.max:1
  bias_att.min:0
  bias_att.max:1
  bias_dec.min:0
  bias_dec.max:1
  bias_rel.min:0
  bias_rel.max:1
  // CONSTANT OUTPUT: the output does not move from 0.2
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: dec from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 0 input, 1 output

en.ar(at:0.02, rt:0.3, gate:0)  en.ar(at, rt, gate)
  at.unit:s
  at.min:0.001
  at.max:0.1
  at.scale:log
  rt.unit:s
  rt.min:0.001
  rt.max:0.8
  rt.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM USAGE, the values the libraries pass to it: at from 0.001 to 0.1
  // BOUNDS FROM USAGE, the values the libraries pass to it: rt from 0.001 to 0.8
  // 0 input, 1 output

en.are(attT60:0.2, relT60:0.4, gate:0)  en.are(attT60, relT60, gate)
  attT60.unit:s
  relT60.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.arfe(attT60:0.2, relT60:0.4, fv:0, gate:0)  en.arfe(attT60, relT60, fv, gate)
  attT60.unit:s
  relT60.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.asr(at:0.05, sl:0.7, rt:0.4, gate:0)  en.asr(at, sl, rt, gate)
  at.unit:s
  sl.min:0
  sl.max:1
  rt.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.asre(attT60:0.2, susLvl:0.6, relT60:0.4, gate:0)  en.asre(attT60, susLvl, relT60, gate)
  attT60.unit:s
  susLvl.min:0
  susLvl.max:1
  relT60.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.asrfe(attT60:0.02, susLvl:0.8, relT60:0.4, finLvl:0, gate:0)  en.asrfe(attT60, susLvl, relT60, finLvl, gate)
  attT60.unit:s
  relT60.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.dx7envelope(R1:0.05, R2:0.1, R3:0.1, R4:0.2, L1:1, L2:0.8, L3:0.6, L4:0, t:0)  en.dx7envelope(R1, R2, R3, R4, L1, L2, L3, L4, t)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

en.smoothEnvelope(ar:0.2, t:0)  en.smoothEnvelope(ar, t)
  ar.unit:s
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

fd.bow(coeff:0.05, alpha:2.0, k:1.0/48000, vb:0.1)  fd.bow(coeff, alpha, k, vb)
  output.min:-0.0700551
  output.max:0.0701654
  output.measure:silence-and-noise
  // at rest: 0.0227867 to 0.0227867; under noise: -0.0700551 to 0.0701654
  // 1 input, 1 output

fd.buildScheme1D(points:1, R:0, T:0)  fd.buildScheme1D(points, R, T)
  output.min:-1.96907
  output.max:1.96753
  output.measure:silence-and-noise
  // 3 inputs, 1 output

fd.buildScheme2D(pointsX:1, pointsY:1, R:0, T:0)  fd.buildScheme2D(pointsX, pointsY, R, T)
  output.min:-1.96907
  output.max:1.96753
  output.measure:silence-and-noise
  // 3 inputs, 1 output

fd.hammer(coeff:0.1, omega0Sqr:1000, sigma0:0.01, kH:1e5, alpha:2.0, k:1.0/48000, offset:0.001, fIn:0)  fd.hammer(coeff, omega0Sqr, sigma0, kH, alpha, k, offset, fIn)
  output.min:-13702.9
  output.max:0
  output.measure:silence-and-noise
  // 1 input, 1 output

fd.linInterp1D(points:4, point:1.25)  fd.linInterp1D(points, point)
  output.min:-0.749999
  output.max:0.749997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

fd.linInterp1DOut(points:4, point:1.5)  fd.linInterp1DOut(points, point)
  output.min:-0.999447
  output.max:0.998161
  output.measure:silence-and-noise
  // 4 inputs, 1 output

fd.linInterp2D(pointsX:2, pointsY:2, pointX:0.6, pointY:1.2)  fd.linInterp2D(pointsX, pointsY, pointX, pointY)
  output.min:-0.479999
  output.max:0.479989
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

fd.linInterp2DOut(pointsX:2, pointsY:2, pointX:0.6, pointY:1.2)  fd.linInterp2DOut(pointsX, pointsY, pointX, pointY)
  output.min:-0.798636
  output.max:0.797887
  output.measure:silence-and-noise
  // 4 inputs, 1 output

fd.model1D(points:2, R:0, T:0, scheme:1, 0.5)  fd.model1D(points, R, T, scheme)
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 283.7)
  // 2 inputs, 2 outputs

fd.model2D(pointsX:2, pointsY:2, R:0, T:0, scheme:1, 0.5, 0.25, 0.125)  fd.model2D(pointsX, pointsY, R, T, scheme)
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 134.4)
  // 4 inputs, 4 outputs

fd.route1D(points:1, R:0, T:0)  fd.route1D(points, R, T)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

fd.route2D(pointsX:1, pointsY:1, R:0, T:0)  fd.route2D(pointsX, pointsY, R, T)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

fd.schemePoint(R:0, T:0, D:1)  fd.schemePoint(R, T, D)
  output.min:-1.96907
  output.max:1.96753
  output.measure:silence-and-noise
  // 3 inputs, 1 output

fd.stairsInterp1D(points:4, point:1)  fd.stairsInterp1D(points, point)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

fd.stairsInterp1DOut(points:4, point:2)  fd.stairsInterp1DOut(points, point)
  output.min:-0.999987
  output.max:0.999993
  output.measure:silence-and-noise
  // 4 inputs, 1 output

fd.stairsInterp2D(pointsX:2, pointsY:2, pointX:1, pointY:0)  fd.stairsInterp2D(pointsX, pointsY, pointX, pointY)
  output.min:-0.999987
  output.max:0.999993
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

fd.stairsInterp2DOut(pointsX:2, pointsY:2, pointX:1, pointY:0)  fd.stairsInterp2DOut(pointsX, pointsY, pointX, pointY)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 1 output

fi.SVFTPT  fi.SVFTPT
  // a set of definitions: SVF(CF, Q, x), LP2(CF, Q, x), HP2(CF, Q, x), BP2(CF, Q, x), BP2Norm(CF, Q, x), Notch2(CF, Q, x), AP2(CF, Q, x), Peaking2(CF, Q, x)

fi.TF2(b0:0.2, b1:0.4, b2:0.2, a1:-0.5, a2:0.3)  fi.TF2(b0, b1, b2, a1, a2)
  output.min:-1.18318
  output.max:1.15719
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.adaptFIR(N:8, step:0.01)  fi.adaptFIR(N, step, x, d)
  x.nature:signal
  d.nature:signal
  output.min:-1.22093
  output.max:1.30475
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

fi.allpass_comb(maxdel:2048, N:64, aN:0.6)  fi.allpass_comb(maxdel, N, aN)
  output.min:-1.86878
  output.max:1.88661
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.allpass_fcomb(maxdel:2048, N:64.5, aN:0.6)  fi.allpass_fcomb(maxdel, N, aN)
  output.min:-1.54466
  output.max:1.58916
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.allpass_fcomb1a(maxdel, N:2, aN)  fi.allpass_fcomb1a(maxdel, N, aN)
  aN.nature:function
  // GUESSED: N:2, from the parameter name
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: maxdel has no starting value

fi.allpass_fcomb5(maxdel:2048, N:64.5, aN:0.6)  fi.allpass_fcomb5(maxdel, N, aN)
  output.min:-1.88391
  output.max:1.79412
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.allpassn(n:3, sv)  fi.allpassn(n, sv)
  sv.nature:table
  sv.example:(0.3, 0.2, 0.1)
  output.min:-1.75799
  output.max:1.72293
  output.measure:silence-and-noise
  // 1 input, 1 output
  // n cannot be adjusted live: the compiler demands a constant in this place

fi.allpassn1m(n:3, sv)  fi.allpassn1m(n, sv)
  sv.nature:table
  sv.example:(0.3, 0.2, 0.1)
  output.min:-1.75799
  output.max:1.72293
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.allpassn1mt(n:2, sv)  fi.allpassn1mt(n, sv)
  sv.nature:table
  sv.example:(0.3, -0.2)
  output.min:-1.76283
  output.max:1.69936
  output.measure:silence-and-noise
  // 1 input, 3 outputs

fi.allpassnkl(n:3, sv)  fi.allpassnkl(n, sv)
  sv.nature:table
  sv.example:(0.3, 0.2, 0.1)
  output.min:-1.75799
  output.max:1.72293
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.allpassnklt(n:2, sv)  fi.allpassnklt(n, sv)
  sv.nature:table
  sv.example:(0.3, -0.2)
  output.min:-1.76283
  output.max:1.69936
  output.measure:silence-and-noise
  // 1 input, 3 outputs

fi.allpassnn(n:3, tv)  fi.allpassnn(n, tv)
  tv.nature:table
  tv.example:(0.3, 0.2, 0.1)
  output.min:-1.75542
  output.max:1.7173
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.allpassnnlt(n:2, sv)  fi.allpassnnlt(n, sv)
  sv.nature:function
  sv.example:(0.3, -0.2)
  output.min:-1.76283
  output.max:1.65969
  output.measure:silence-and-noise
  // 1 input, 3 outputs

fi.allpassnt(n:2, sv)  fi.allpassnt(n, sv)
  sv.nature:table
  sv.example:(0.3, -0.2)
  output.min:-1.76283
  output.max:1.65969
  output.measure:silence-and-noise
  // 1 input, 3 outputs

fi.apnl(a1:0.5, a2:-0.5)  fi.apnl(a1, a2, x)
  x.nature:signal
  x.example:os.osc(440)
  output.min:-1.75953
  output.max:1.71026
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.av2sv(av)  fi.av2sv(av)
  av.nature:table
  av.example:(-0.4, 0.1)
  output.min:-0.363636
  output.max:0.1
  output.measure:no-input
  // 0 input, 2 outputs

fi.avg_rect(period:1)  fi.avg_rect(period, x)
  period.unit:s
  x.nature:signal
  output.min:-0.00318833
  output.max:0.00728948
  output.measure:silence-and-noise
  // GUESSED: period:1, from the parameter name
  // 1 input, 1 output

fi.avg_t19(period:0.2)  fi.avg_t19(period, x)
  period.unit:s
  x.nature:signal
  output.min:-0.0159342
  output.max:0.0229924
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.avg_t60(period:0.3)  fi.avg_t60(period, x)
  period.unit:s
  x.nature:signal
  output.min:-0.0298306
  output.max:0.0338365
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.avg_tau(period:0.1)  fi.avg_tau(period, x)
  period.unit:s
  x.nature:signal
  output.min:-0.0147687
  output.max:0.0218168
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.bandpass(Nh:2, fl:500, fu:1500)  fi.bandpass(Nh, fl, fu)
  fl.unit:Hz
  fl.min:200
  fl.max:8000
  fu.unit:Hz
  fu.min:400
  fu.max:12000
  output.min:-0.528388
  output.max:0.526289
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: fl from 200 to 8000
  // BOUNDS FROM USAGE, the values the libraries pass to it: fu from 400 to 12000
  // 1 input, 1 output

fi.bandpass0_bandstop1(s:0, Nh:2, fl:500, fu:1500)  fi.bandpass0_bandstop1(s, Nh, fl, fu)
  fl.unit:Hz
  fl.min:20
  fl.max:20000
  fl.scale:log
  fu.unit:Hz
  fu.min:20
  fu.max:20000
  fu.scale:log
  output.min:-0.528388
  output.max:0.526289
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fl from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: fu from 20 to 20000
  // 1 input, 1 output

fi.bandpass12e(fl:500, fu:2000)  fi.bandpass12e(fl, fu)
  fl.unit:Hz
  fl.min:20
  fl.max:20000
  fl.scale:log
  fu.unit:Hz
  fu.min:20
  fu.max:20000
  fu.scale:log
  output.min:-0.557909
  output.max:0.635851
  output.measure:silence-and-noise
  // GUESSED: fl:500, from the parameter name
  // GUESSED: fu:2000, from the parameter name
  // BOUNDS GUESSED, from the parameter name: fl from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: fu from 20 to 20000
  // 1 input, 1 output

fi.bandpass6e(fl:500, fu:2000)  fi.bandpass6e(fl, fu)
  fl.unit:Hz
  fl.min:20
  fl.max:20000
  fl.scale:log
  fu.unit:Hz
  fu.min:20
  fu.max:20000
  fu.scale:log
  output.min:-0.749298
  output.max:0.72753
  output.measure:silence-and-noise
  // GUESSED: fl:500, from the parameter name
  // GUESSED: fu:2000, from the parameter name
  // BOUNDS GUESSED, from the parameter name: fl from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: fu from 20 to 20000
  // 1 input, 1 output

fi.bandstop(Nh:2, fl:500, fu:1500)  fi.bandstop(Nh, fl, fu)
  fl.unit:Hz
  fl.min:20
  fl.max:20000
  fl.scale:log
  fu.unit:Hz
  fu.min:20
  fu.max:20000
  fu.scale:log
  output.min:-1.66199
  output.max:1.52456
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fl from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: fu from 20 to 20000
  // 1 input, 1 output

fi.bvav2nuv(bv, av)  fi.bvav2nuv(bv, av)
  bv.nature:table
  bv.example:(0.1, 0.2, 0.3)
  av.nature:table
  av.example:(-0.4, 0.1)
  output.min:0.186364
  output.max:0.32
  output.measure:no-input
  // 0 input, 3 outputs

fi.conv(kv)  fi.conv(kv)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: kv has no starting value

fi.convN(N:3, kv)  fi.convN(N, kv)
  kv.nature:table
  kv.example:"(k1,k2,k3,...)"
  // DOES NOT COMPILE: ERROR : syntax error, unexpected DOT

fi.crossover2LR4(cf:1000)  fi.crossover2LR4(cf, x)
  cf.unit:Hz
  cf.min:20
  cf.max:20000
  cf.scale:log
  x.nature:signal
  output.min:-1.81028
  output.max:1.68511
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: cf from 20 to 20000
  // 1 input, 2 outputs

fi.crossover3LR4(cf1:500, cf2:2000)  fi.crossover3LR4(cf1, cf2, x)
  cf1.unit:Hz
  cf2.unit:Hz
  x.nature:signal
  output.min:-1.75836
  output.max:1.8109
  output.measure:silence-and-noise
  // 1 input, 3 outputs

fi.crossover4LR4(cf1:300, cf2:1000, cf3:3000)  fi.crossover4LR4(cf1, cf2, cf3, x)
  cf1.unit:Hz
  cf2.unit:Hz
  cf3.unit:Hz
  x.nature:signal
  output.min:-1.70632
  output.max:1.88637
  output.measure:silence-and-noise
  // 1 input, 4 outputs

fi.crossover8LR4(cf1:100, cf2:200, cf3:400, cf4:800, cf5:1600, cf6:3200, cf7:6400)  fi.crossover8LR4(cf1, cf2, cf3, cf4, cf5, cf6, cf7, x)
  cf1.unit:Hz
  cf2.unit:Hz
  cf3.unit:Hz
  cf4.unit:Hz
  cf5.unit:Hz
  cf6.unit:Hz
  cf7.unit:Hz
  x.nature:signal
  output.min:-1.6419
  output.max:1.57186
  output.measure:silence-and-noise
  // 1 input, 8 outputs

fi.dcblocker  fi.dcblocker
  output.min:-1.10112
  output.max:1.08626
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.dcblockerat(fb:30)  fi.dcblockerat(fb)
  fb.unit:Hz
  fb.min:10
  fb.max:30
  output.min:-1.08536
  output.max:1.07736
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: fb from 10 to 30
  // 1 input, 1 output

fi.dynamicSmoothing(sensitivity:0.5, baseCF:500)  fi.dynamicSmoothing(sensitivity, baseCF, x)
  baseCF.unit:Hz
  x.nature:signal
  x.example:os.osc(440)
  output.min:-0.601438
  output.max:0.709838
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.fb_comb(maxdel:2048, N:64, b0:0.7, aN:0.6)  fi.fb_comb(maxdel, N, b0, aN)
  b0.min:0.7
  b0.max:1
  output.min:-1.55855
  output.max:1.51596
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: b0 from 0.7 to 1
  // 1 input, 1 output

fi.fb_comb_common(dop, N:64, b0:0.8, aN:0.6)  fi.fb_comb_common(dop, N, b0, aN)
  dop.nature:function
  dop.example:@
  output.min:-1.76544
  output.max:1.81448
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.fb_fcomb(maxdel:2048, N:64.5, b0:0.7, aN:0.6)  fi.fb_fcomb(maxdel, N, b0, aN)
  output.min:-1.25668
  output.max:1.33761
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.fbcombfilter(maxdel:2048, intdel:64, g:0.6)  fi.fbcombfilter(maxdel, intdel, g)
  output.min:-2.17694
  output.max:2.15422
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.ff_comb(maxdel:2048, M:64, b0:1, bM:0.7)  fi.ff_comb(maxdel, M, b0, bM)
  output.min:-1.69457
  output.max:1.69308
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.ff_fcomb(maxdel:2048, M:64.5, b0:1, bM:0.7)  fi.ff_fcomb(maxdel, M, b0, bM)
  output.min:-1.67762
  output.max:1.67282
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.ffbcombfilter(maxdel:65536, del:22050.5, g:1)  fi.ffbcombfilter(maxdel, del, g)
  output.min:-3.68274
  output.max:3.61313
  output.measure:silence-and-noise
  // GUESSED: g:1, from the parameter name
  // 1 input, 1 output

fi.ffcombfilter(maxdel:2048, del:64, g:0.7)  fi.ffcombfilter(maxdel, del, g)
  output.min:-1.69457
  output.max:1.69308
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.filterbank(O:3, lfreqs)  fi.filterbank(O, lfreqs)
  lfreqs.nature:table
  lfreqs.example:(500, 2000)
  output.min:-1.93502
  output.max:1.7642
  output.measure:silence-and-noise
  // 1 input, 3 outputs

fi.filterbanki(O:3, lfreqs)  fi.filterbanki(O, lfreqs)
  lfreqs.nature:table
  lfreqs.example:(500, 2000)
  output.min:-1.76072
  output.max:1.9303
  output.measure:silence-and-noise
  // 1 input, 3 outputs

fi.fir(b0:0.2,0.2,0.2,0.2,0.2)  fi.fir(b0)
  output.min:-0.911777
  output.max:0.936937
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.high_shelf(Lpi:6, fx:2000)  fi.high_shelf(Lpi, fx)
  Lpi.unit:dB
  Lpi.min:-60
  Lpi.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  output.min:-3.98682
  output.max:3.56043
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Lpi from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.high_shelf1(Lpi:6, fx:2000)  fi.high_shelf1(Lpi, fx, x)
  Lpi.unit:dB
  Lpi.min:-60
  Lpi.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:-2.42728
  output.max:2.40251
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Lpi from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.high_shelf1_l(Gpi:2, fx:2000)  fi.high_shelf1_l(Gpi, fx, x)
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:-2.43408
  output.max:2.40928
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.highpass(N:4, fc:500)  fi.highpass(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:12000
  fc.scale:log
  output.min:-1.73512
  output.max:1.6426
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: fc from 20 to 12000
  // 1 input, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

fi.highpass3e(fc:1000)  fi.highpass3e(fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.83387
  output.max:1.67295
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output

fi.highpass6e(fc:1000)  fi.highpass6e(fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.88727
  output.max:1.8376
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output

fi.highpassLR4(cf:1000)  fi.highpassLR4(cf, x)
  cf.unit:Hz
  cf.min:20
  cf.max:20000
  cf.scale:log
  x.nature:signal
  output.min:-1.81028
  output.max:1.68511
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: cf from 20 to 20000
  // 1 input, 1 output

fi.highpass_minus_lowpass(N:3, fc:1000)  fi.highpass_minus_lowpass(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.816
  output.max:1.88046
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output

fi.highpass_minus_lowpass_even(N:4, fc:1000)  fi.highpass_minus_lowpass_even(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.94936
  output.max:1.85373
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 2 inputs, 1 output

fi.highpass_minus_lowpass_odd(N:3, fc:1000)  fi.highpass_minus_lowpass_odd(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.91461
  output.max:1.83799
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 2 inputs, 1 output

fi.highpass_plus_lowpass(N:3, fc:1000)  fi.highpass_plus_lowpass(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.88835
  output.max:1.77466
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

fi.highpass_plus_lowpass_even(N:4, fc:1000)  fi.highpass_plus_lowpass_even(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.94936
  output.max:1.85843
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 2 inputs, 1 output

fi.highpass_plus_lowpass_odd(N:3, fc:1000)  fi.highpass_plus_lowpass_odd(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.92336
  output.max:1.82748
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 2 inputs, 1 output

fi.highshelf(N:3, Lpi:6, fx:2000)  fi.highshelf(N, Lpi, fx)
  Lpi.unit:dB
  Lpi.min:-60
  Lpi.max:12
  fx.min:20
  fx.max:20000
  fx.scale:log
  output.min:-3.98682
  output.max:3.56043
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Lpi from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.highshelf_other_freq(N:3, Lpi:6, fx:2000)  fi.highshelf_other_freq(N, Lpi, fx)
  Lpi.unit:dB
  Lpi.min:-60
  Lpi.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  // CONSTANT OUTPUT: the output does not move from 1588.66
  // BOUNDS GUESSED, from the parameter name: Lpi from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 0 input, 1 output

fi.hilbert(N:4, fc:20)  fi.hilbert(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.41698
  output.max:1.37668
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output

fi.iir(bv, av:0.3)  fi.iir(bv, av)
  bv.nature:table
  bv.example:(0.5, 0.5)
  output.min:-0.948327
  output.max:0.968682
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.iir_kl(bv, av)  fi.iir_kl(bv, av)
  bv.nature:table
  bv.example:(0.1, 0.2, 0.3)
  av.nature:table
  av.example:(-0.4, 0.1)
  output.min:-0.822099
  output.max:0.820375
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.iir_lat1(bv, av)  fi.iir_lat1(bv, av)
  bv.nature:table
  bv.example:(0.1, 0.2, 0.3)
  av.nature:table
  av.example:(-0.4, 0.1)
  output.min:-0.822099
  output.max:0.820375
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.iir_lat2(bv, av)  fi.iir_lat2(bv, av)
  bv.nature:table
  bv.example:(0.1, 0.2, 0.3)
  av.nature:table
  av.example:(-0.4, 0.1)
  output.min:-0.822099
  output.max:0.820375
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.iir_nl(bv, av)  fi.iir_nl(bv, av)
  bv.nature:table
  bv.example:(0.1, 0.2, 0.3)
  av.nature:table
  av.example:(-0.4, 0.1)
  output.min:-0.822099
  output.max:0.820375
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.integrator  fi.integrator
  output.min:-10.2406
  output.max:414.636
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.itu_r_bs_1770_4_kfilter  fi.itu_r_bs_1770_4_kfilter
  output.min:-1.79423
  output.max:1.80574
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.kalman(N:1, M:1, B, R, H, Q, F, reset, u:0.0)  fi.kalman(N, M, B, R, H, Q, F, reset, u, z)
  B.nature:table
  R.nature:table
  H.nature:table
  Q.nature:table
  F.nature:table
  F.example:la.identity(N)
  reset.nature:table
  z.nature:signal
  z.example:trueState + measurementNoise
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

fi.levelfilter(L:0.1, freq:200)  fi.levelfilter(L, freq, x)
  L.unit:dB
  freq.min:20
  freq.max:20000
  freq.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:-0.156164
  output.max:0.165444
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

fi.levelfilterN(N:3, freq:200, L:0.1)  fi.levelfilterN(N, freq, L)
  freq.min:20
  freq.max:20000
  freq.scale:log
  L.unit:dB
  output.min:-0.0147657
  output.max:0.0166586
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

fi.lms(N:8, mu:0.01)  fi.lms(N, mu, x, d)
  x.nature:signal
  d.nature:signal
  output.min:-1.22093
  output.max:1.30475
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

fi.low_shelf(L0:6, fx:500)  fi.low_shelf(L0, fx)
  L0.unit:dB
  L0.min:-60
  L0.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  output.min:-1.85083
  output.max:1.84963
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: L0 from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.low_shelf1(L0:2, fx:500)  fi.low_shelf1(L0, fx, x)
  L0.unit:dB
  L0.min:-60
  L0.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:-1.07827
  output.max:1.09887
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: L0 from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.low_shelf1_l(G0:2, fx:500)  fi.low_shelf1_l(G0, fx, x)
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  x.nature:signal
  x.example:os.osc(440)
  output.min:-1.34276
  output.max:1.39353
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.lowpass(N:4, fc:2000)  fi.lowpass(N, fc)
  fc.unit:Hz
  fc.min:2
  fc.max:8000
  fc.scale:log
  output.min:-0.621311
  output.max:0.667865
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: fc from 2 to 8000
  // 1 input, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

fi.lowpass0_highpass1(s:0, N:2, fc:1000)  fi.lowpass0_highpass1(s, N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-0.487418
  output.max:0.499594
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output

fi.lowpass3e(fc:1000)  fi.lowpass3e(fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-0.526225
  output.max:0.570387
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output

fi.lowpass6e(fc:1000)  fi.lowpass6e(fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-0.484354
  output.max:0.501723
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 1 output

fi.lowpassLR4(cf:1000)  fi.lowpassLR4(cf, x)
  cf.unit:Hz
  cf.min:20
  cf.max:20000
  cf.scale:log
  x.nature:signal
  output.min:-0.374832
  output.max:0.468997
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: cf from 20 to 20000
  // 1 input, 1 output

fi.lowshelf(N:3, L0:6, fx:500)  fi.lowshelf(N, L0, fx)
  L0.unit:dB
  L0.min:-60
  L0.max:12
  fx.min:20
  fx.max:20000
  fx.scale:log
  output.min:-1.85083
  output.max:1.84963
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: L0 from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.lowshelf_other_freq(N:3, L0:6, fx:500)  fi.lowshelf_other_freq(N, L0, fx)
  L0.unit:dB
  L0.min:-60
  L0.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  // CONSTANT OUTPUT: the output does not move from 629.463
  // BOUNDS GUESSED, from the parameter name: L0 from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 0 input, 1 output

fi.lpt19(tN:0.2)  fi.lpt19(tN, x)
  tN.unit:s
  x.nature:signal
  output.min:-0.0159342
  output.max:0.0229924
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.lpt60(tN:0.3)  fi.lpt60(tN, x)
  tN.unit:s
  x.nature:signal
  output.min:-0.0298306
  output.max:0.0338365
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.lptN(N:60, tN:0.1)  fi.lptN(N, tN, x)
  N.unit:dB
  N.min:8.68589
  N.max:60
  tN.unit:s
  x.nature:signal
  output.min:-0.0588366
  output.max:0.0520735
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: N from 8.68589 to 60
  // 1 input, 1 output

fi.lptau(tN:0.1)  fi.lptau(tN, x)
  tN.unit:s
  x.nature:signal
  output.min:-0.0147687
  output.max:0.0218168
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.mth_octave_filterbank(O:3, M:2, ftop:8000, N:2)  fi.mth_octave_filterbank(O, M, ftop, N)
  output.min:-1.43726
  output.max:1.45457
  output.measure:silence-and-noise
  // 1 input, 2 outputs

fi.mth_octave_filterbank3(M:2, ftop:8000, N:2)  fi.mth_octave_filterbank3(M, ftop, N)
  output.min:-1.43726
  output.max:2
  output.measure:silence-and-noise
  // at rest: 0 to 2; under noise: -1.43726 to 2
  // 1 input, 3 outputs

fi.mth_octave_filterbank5(M:2, ftop:8000, N:2)  fi.mth_octave_filterbank5(M, ftop, N)
  output.min:-1.61905
  output.max:1.55313
  output.measure:silence-and-noise
  // 1 input, 2 outputs

fi.mth_octave_filterbank_alt(O:3, M:2, ftop:8000, N:2)  fi.mth_octave_filterbank_alt(O, M, ftop, N)
  output.min:-1.43726
  output.max:2
  output.measure:silence-and-noise
  // at rest: 0 to 2; under noise: -1.43726 to 2
  // 1 input, 3 outputs

fi.mth_octave_filterbank_default(M:2, ftop:8000, N:2)  fi.mth_octave_filterbank_default(M, ftop, N)
  M.min:1
  M.max:3
  ftop.unit:Hz
  output.min:-1.61905
  output.max:1.55313
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: M from 1 to 3
  // 1 input, 2 outputs

fi.nlf2(f:440, r:0.995)  fi.nlf2(f, r, x)
  f.unit:Hz
  x.nature:signal
  x.example:os.osc(440)
  output.min:-23.2545
  output.max:22.694
  output.measure:silence-and-noise
  // 1 input, 2 outputs

fi.nlms(N:8, mu:0.5)  fi.nlms(N, mu, x, d)
  x.nature:signal
  d.nature:signal
  output.min:-2.53575
  output.max:2.5787
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

fi.notchw(width:200, freq:1000)  fi.notchw(width, freq)
  width.unit:Hz
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1.20263
  output.max:1.20758
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

fi.oneEuro(derivativeCutoff:1, beta:0.5, minCutoff:5)  fi.oneEuro(derivativeCutoff, beta, minCutoff)
  minCutoff.unit:Hz
  output.min:-0.120294
  output.max:0.132318
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.peak_eq(Lfx:6, fx:1000, B:200)  fi.peak_eq(Lfx, fx, B)
  Lfx.unit:dB
  Lfx.min:-60
  Lfx.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  B.unit:Hz
  output.min:-1.1592
  output.max:1.15709
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Lfx from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 1 input, 1 output

fi.peak_eq_cq(Lfx:6, fx:1000, Q:4)  fi.peak_eq_cq(Lfx, fx, Q)
  Lfx.unit:dB
  Lfx.min:-60
  Lfx.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  Q.unit:Hz
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-1.17614
  output.max:1.17019
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Lfx from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

fi.peak_eq_rm(Lfx:6, fx:1000)  fi.peak_eq_rm(Lfx, fx, tanPiBT)
  Lfx.unit:dB
  Lfx.min:-60
  Lfx.max:12
  fx.unit:Hz
  fx.min:20
  fx.max:20000
  fx.scale:log
  tanPiBT.nature:signal
  tanPiBT.example:tan(ma.PI*200/ma.SR)
  // OUTPUT NOT FINITE: NaN or infinity on noise (191872 samples out of 191872)
  // BOUNDS GUESSED, from the parameter name: Lfx from -60 to 12
  // BOUNDS GUESSED, from the parameter name: fx from 20 to 20000
  // 2 inputs, 1 output

fi.pole(p:0.9)  fi.pole(p)
  p.min:0.9
  p.max:1
  output.min:-4.97341
  output.max:5.61106
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: p from 0.9 to 1
  // 1 input, 1 output

fi.pospass(N:2, fc:1000)  fi.pospass(N, fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-0.600773
  output.max:0.608117
  output.measure:silence-and-noise
  // GUESSED: N:2, from the parameter name
  // GUESSED: fc:1000, from the parameter name
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 2 outputs

fi.pospass6e(fc:100)  fi.pospass6e(fc)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  output.min:-1.08605
  output.max:1.13216
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // 1 input, 2 outputs

fi.resonbp(fc:1000, Q:2, gain:0.8)  fi.resonbp(fc, Q, gain)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  gain.min:0
  gain.max:1
  output.min:-0.666912
  output.max:0.719332
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

fi.resonhp(fc:1000, Q:2, gain:0.8)  fi.resonhp(fc, Q, gain, x)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  gain.min:0
  gain.max:1
  x.nature:signal
  x.example:os.osc(440)
  output.min:-1.3937
  output.max:1.42903
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

fi.resonlp(fc:1000, Q:2, gain:0.8)  fi.resonlp(fc, Q, gain)
  fc.unit:Hz
  fc.min:20
  fc.max:20000
  fc.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  gain.min:0
  gain.max:1
  output.min:-0.656265
  output.max:0.696171
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fc from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

fi.rev1(maxdel:2048, N:64, g:0.6)  fi.rev1(maxdel, N, g)
  N.unit:samples
  output.min:-2.2068
  output.max:2.2681
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.rev2(maxlen:2048, len:64, g:0.6)  fi.rev2(maxlen, len, g)
  maxlen.min:64
  maxlen.max:2048
  len.unit:samples
  len.min:37
  len.max:347
  output.min:-1.91829
  output.max:1.89955
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: maxlen from 64 to 2048
  // BOUNDS FROM USAGE, the values the libraries pass to it: len from 37 to 347
  // 1 input, 1 output

fi.scat(s:0.5, r)  fi.scat(s, r)
  s.min:-1
  s.max:1
  r.nature:function
  r.example:_
  output.min:-1.82469
  output.max:1.8011
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.scatN(N:2, av, filter)  fi.scatN(N, av, filter)
  av.nature:table
  av.example:(1, 1)
  filter.nature:function
  filter.example:_
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

fi.spectral_tilt(N:4, f0:200, bw:2000, alpha:-0.5)  fi.spectral_tilt(N, f0, bw, alpha)
  f0.unit:Hz
  f0.min:20
  f0.max:10000
  f0.scale:log
  bw.unit:Hz
  bw.min:100
  bw.max:10000
  bw.scale:log
  alpha.min:-1
  alpha.max:1
  output.min:-0.448744
  output.max:0.475242
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: f0 from 20 to 10000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: bw from 100 to 10000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: alpha from -1 to 1
  // 1 input, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

fi.svf  fi.svf
  // a set of definitions: svf(T, F, Q, G), lp(f, q), bp(f, q), hp(f, q), notch(f, q), peak(f, q), ap(f, q), bell(f, q, g), ls(f, q, g), hs(f, q, g)

fi.svf_morph(f:1000, q:0.707, _b:1)  fi.svf_morph(f, q, _b, x)
  q.min:0.5
  q.max:50
  q.scale:log
  _b.min:0
  _b.max:2
  x.nature:signal
  x.example:os.osc(440)
  output.min:-0.455599
  output.max:0.480845
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: q from 0.5 to 50
  // 1 input, 1 output

fi.svf_notch_morph(f:1000, q:0.707, _b:1)  fi.svf_notch_morph(f, q, _b, x)
  q.min:0.5
  q.max:50
  q.scale:log
  _b.min:0
  _b.max:2
  x.nature:signal
  x.example:os.osc(440)
  output.min:-1.45055
  output.max:1.408
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: q from 0.5 to 50
  // 1 input, 1 output

fi.tf1(b0:0.5, b1:0.25, a1:-0.4)  fi.tf1(b0, b1, a1)
  output.min:-1.1766
  output.max:1.16994
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf1s(b1:0, b0:1, a0:1, w1:ma.PI*ma.SR/2)  fi.tf1s(b1, b0, a0, w1)
  b1.min:-1
  b1.max:1
  b0.min:-1
  b0.max:1
  output.min:-0.995684
  output.max:0.998017
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: b1 from -1 to 1
  // BOUNDS FROM USAGE, the values the libraries pass to it: b0 from -1 to 1
  // 1 input, 1 output

fi.tf1sb(b1:0, b0:1, a0:1, w1:2*ma.PI*200, wc:2*ma.PI*1000)  fi.tf1sb(b1, b0, a0, w1, wc)
  output.min:-0.272012
  output.max:0.266174
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf1snp(b1:0, b0:1, a0:1, w1:ma.PI*ma.SR/2)  fi.tf1snp(b1, b0, a0, w1)
  output.min:-0.995725
  output.max:0.99797
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf2(b0:1, b1:-1, b2:0, a1:0.823765146386639, a2:0.117420665547108)  fi.tf2(b0, b1, b2, a1, a2)
  b1.min:-1
  b1.max:0.745184
  b2.min:0
  b2.max:1
  output.min:-5.82958
  output.max:5.6701
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: b1 from -1 to 0.745184
  // BOUNDS FROM USAGE, the values the libraries pass to it: b2 from 0 to 1
  // 1 input, 1 output

fi.tf21(b0:0.1, b1:0.2, b2:0.1, a1:-0.5, a2:0.06)  fi.tf21(b0, b1, b2, a1, a2)
  output.min:-0.637171
  output.max:0.653043
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf21t(b0, b1, b2, a1, a2)  fi.tf21t(b0, b1, b2, a1, a2)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: b0 has no starting value
  // TO COMPLETE: b1 has no starting value
  // TO COMPLETE: b2 has no starting value
  // TO COMPLETE: a1 has no starting value
  // TO COMPLETE: a2 has no starting value

fi.tf22(b0, b1, b2, a1, a2)  fi.tf22(b0, b1, b2, a1, a2)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: b0 has no starting value
  // TO COMPLETE: b1 has no starting value
  // TO COMPLETE: b2 has no starting value
  // TO COMPLETE: a1 has no starting value
  // TO COMPLETE: a2 has no starting value

fi.tf22t(b0:1, b1:0, b2:0, a1:0, a2:0)  fi.tf22t(b0, b1, b2, a1, a2)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf2np(b0:0.6, b1:0.3, b2:0.2, a1:-0.5, a2:0.2)  fi.tf2np(b0, b1, b2, a1, a2)
  output.min:-1.59842
  output.max:1.60587
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf2s(b2:0, b1:0, b0:1, a1:sqrt(2), a0:1, w1:ma.PI*ma.SR/2)  fi.tf2s(b2, b1, b0, a1, a0, w1)
  output.min:-1.21422
  output.max:1.18838
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf2sb(b2:0, b1:0, b0:1, a1:sqrt(2), a0:1, w1:2*ma.PI*200, wc:2*ma.PI*1000)  fi.tf2sb(b2, b1, b0, a1, a0, w1, wc)
  output.min:-0.21573
  output.max:0.22056
  output.measure:silence-and-noise
  // 1 input, 1 output

fi.tf2snp(b2:0, b1:0, b0:1, a1, a0:1, w1)  fi.tf2snp(b2, b1, b0, a1, a0, w1)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: a1 has no starting value
  // TO COMPLETE: w1 has no starting value

fi.tf3(b0, b1, b2, b3, a1, a2, a3)  fi.tf3(b0, b1, b2, b3, a1, a2, a3)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter
  // TO COMPLETE: b0 has no starting value
  // TO COMPLETE: b1 has no starting value
  // TO COMPLETE: b2 has no starting value
  // TO COMPLETE: b3 has no starting value
  // TO COMPLETE: a1 has no starting value
  // TO COMPLETE: a2 has no starting value
  // TO COMPLETE: a3 has no starting value

fi.tf3slf(b3:0, b2:0, b1:0, b0:1, a3:1, a2:2, a1:2, a0:1)  fi.tf3slf(b3, b2, b1, b0, a3, a2, a1, a0)
  // OUTPUT NOT FINITE: NaN or infinity on noise (191872 samples out of 191872)
  // 1 input, 1 output

fi.wgr(f:440, r:0.995)  fi.wgr(f, r, x)
  f.unit:Hz
  x.nature:signal
  x.example:os.osc(440)
  output.min:-23.2551
  output.max:22.694
  output.measure:silence-and-noise
  // 1 input, 2 outputs

fi.zero  fi.zero(z)
  z.nature:signal
  output.min:-1.95118
  output.max:1.97338
  output.measure:silence-and-noise
  // 2 inputs, 1 output

ho.circularScaledVBAP(l, t:60)  ho.circularScaledVBAP(l, t)
  l.nature:table
  l.example:(0, 120, 240)
  output.min:-0.707101
  output.max:0.707067
  output.measure:silence-and-noise
  // 1 input, 3 outputs

ho.decoder(N:1, P:4)  ho.decoder(N, P)
  output.min:-0.749521
  output.max:0.748662
  output.measure:silence-and-noise
  // 3 inputs, 4 outputs

ho.decoderStereo(N:1)  ho.decoderStereo(N)
  output.min:-1.1256
  output.max:1.11097
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

ho.encoder(N:1, a:0.0)  ho.encoder(N, x, a)
  x.nature:signal
  x.example:monoSignal(440)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 3 outputs

ho.encoder3D(N:1, theta:0.0, phi:0.0)  ho.encoder3D(N, x, theta, phi)
  x.nature:signal
  x.example:monoSignal(440)
  output.min:-0.999992
  output.max:0.999992
  output.measure:silence-and-noise
  // 1 input, 4 outputs

ho.fxDecorrelation(N:1, d:64, wf:5, fa:0.5, fd:0.2, tf:0)  ho.fxDecorrelation(N, d, wf, fa, fd, tf)
  d.unit:samples
  wf.unit:Hz
  fa.min:0
  fa.max:1
  fd.min:0
  fd.max:1
  tf.min:0
  tf.max:21
  output.min:-1.23128
  output.max:1.23761
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.fxRingMod(N:1, f0:200, fa:0.5, tf:0)  ho.fxRingMod(N, f0, fa, tf)
  f0.unit:samples
  f0.min:20
  f0.max:20000
  f0.scale:log
  fa.min:0
  fa.max:1
  tf.min:0
  tf.max:21
  output.min:-0.999992
  output.max:0.999967
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // 3 inputs, 3 outputs

ho.iBasicDecoder(N:1, la, direct:1, shift:0)  ho.iBasicDecoder(N, la, direct, shift)
  la.nature:table
  la.example:(0, 120, 240)
  output.min:-1.23227
  output.max:1.22697
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.iDecoder(N:1, la, direct:1, shift:0, st:0, g:0.8)  ho.iDecoder(N, la, direct, shift, st, g)
  g.min:0
  g.max:1
  la.nature:table
  la.example:(0, 120, 240)
  output.min:-0.951718
  output.max:0.94977
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.imlsDecoder(N:1, la, direct:1, shift:0)  ho.imlsDecoder(N, la, direct, shift)
  la.nature:table
  la.example:(0, 90, 180, 270)
  output.min:-0.749521
  output.max:0.748662
  output.measure:silence-and-noise
  // 3 inputs, 4 outputs

ho.map(N:1, r:0.5, a:0.0)  ho.map(N, x, r, a)
  x.nature:signal
  x.example:monoSignal(440)
  output.min:-1.34656
  output.max:1.3465
  output.measure:silence-and-noise
  // 1 input, 3 outputs

ho.mirror(N:1, fa:-1)  ho.mirror(N, fa)
  output.min:-0.999997
  output.max:0.999999
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.multiEncoder(N:1, lspeed, langle, it:0.05)  ho.multiEncoder(N, lspeed, langle, it)
  it.unit:ms
  lspeed.nature:table
  lspeed.example:(0.0, 0.0)
  langle.nature:table
  langle.example:(0.0, 1.57)
  output.min:-1.99553
  output.max:1.99259
  output.measure:silence-and-noise
  // 2 inputs, 3 outputs

ho.optim(N:1, ot:1)  ho.optim(N, ot)
  output.min:-0.999959
  output.max:0.999935
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.optim3D(N:1, ot:2)  ho.optim3D(N, ot)
  output.min:-0.999959
  output.max:0.999964
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ho.optimBasic(N:1)  ho.optimBasic(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.optimBasic3D(N:1)  ho.optimBasic3D(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ho.optimInPhase(N:1)  ho.optimInPhase(N)
  output.min:-0.999992
  output.max:0.999967
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.optimInPhase3D(N:1)  ho.optimInPhase3D(N)
  output.min:-0.999991
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ho.optimMaxRe(N:1)  ho.optimMaxRe(N)
  output.min:-0.999992
  output.max:0.999967
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.optimMaxRe3D(N:1)  ho.optimMaxRe3D(N)
  output.min:-0.999991
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ho.rEncoder(N:1, sp:0.5, a:0.0, it:0.05)  ho.rEncoder(N, sp, a, it)
  it.unit:ms
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 3 outputs

ho.rEncoder3D(N:1, azsp:0.5, elsp:0.3, az:0.0, el:0.0, it:0.05)  ho.rEncoder3D(N, azsp, elsp, az, el, it)
  it.unit:ms
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 4 outputs

ho.rotate(N:1, a:0.78)  ho.rotate(N, a)
  output.min:-1.41341
  output.max:1.41037
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

ho.scope(N:1, rt:0.1)  ho.scope(N, rt)
  rt.unit:ms
  output.min:-0.999594
  output.max:1
  output.measure:silence-and-noise
  // at rest: 0 to 1; under noise: -0.999594 to 1
  // 3 inputs, 3 outputs

ho.stereoEncoder(N:1, a:1.0)  ho.stereoEncoder(N, a)
  output.min:-1.99553
  output.max:1.99259
  output.measure:silence-and-noise
  // 2 inputs, 3 outputs

ho.synDecorrelation(N:1, d:64, wf:5, fa:0.5, fd:0.2, tf:0)  ho.synDecorrelation(N, d, wf, fa, fd, tf)
  d.unit:samples
  wf.unit:Hz
  fa.min:0
  fa.max:1
  fd.min:0
  fd.max:1
  tf.min:0
  tf.max:21
  output.min:-1.22989
  output.max:1.23968
  output.measure:silence-and-noise
  // 1 input, 3 outputs

ho.synRingMod(N:1, f0:200, fa:0.5, tf:0)  ho.synRingMod(N, f0, fa, tf)
  f0.unit:samples
  f0.min:20
  f0.max:20000
  f0.scale:log
  fa.min:0
  fa.max:1
  tf.min:0
  tf.max:21
  output.min:-0.999985
  output.max:0.999937
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // 1 input, 3 outputs

ho.wider(N:1, w:0.5)  ho.wider(N, w)
  output.min:-1.34656
  output.max:1.34653
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

hy.ja_hysteresis(Ms:380, a:720, alpha:0.015, k:380, c:0.25)  hy.ja_hysteresis(Ms, a, alpha, k, c)
  Ms.min:100
  Ms.max:1000
  a.min:100
  a.max:2000
  alpha.min:0.001
  alpha.max:0.1
  alpha.scale:log
  k.min:50
  k.max:1000
  c.min:0
  c.max:1
  output.min:-0.384186
  output.max:0.383799
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: Ms from 100 to 1000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: a from 100 to 2000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: alpha from 0.001 to 0.1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: k from 50 to 1000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: c from 0 to 1
  // 1 input, 1 output

hy.ja_processor(Ms:380, a:720, alpha:0.015, k:380, c:0.25, drive:ba.db2linear(10), trim:1.0)  hy.ja_processor(Ms, a, alpha, k, c, drive, trim)
  Ms.min:100
  Ms.max:1000
  a.min:100
  a.max:2000
  alpha.min:0.001
  alpha.max:0.1
  alpha.scale:log
  k.min:50
  k.max:1000
  c.min:0
  c.max:1
  output.min:-1.2576
  output.max:1.31315
  output.measure:silence-and-noise
  // 1 input, 1 output

hy.ja_processor_stereo(Ms:380, a:720, alpha:0.015, k:380, c:0.25, drive:ba.db2linear(10), trim:1.0)  hy.ja_processor_stereo(Ms, a, alpha, k, c, drive, trim)
  Ms.min:100
  Ms.max:1000
  a.min:100
  a.max:2000
  alpha.min:0.001
  alpha.max:0.1
  alpha.scale:log
  k.min:50
  k.max:1000
  c.min:0
  c.max:1
  output.min:-1.29999
  output.max:1.34613
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

hy.ja_processor_stereo_ui  hy.ja_processor_stereo_ui
  output.min:-1.15801
  output.max:1.14465
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

hy.ja_processor_ui  hy.ja_processor_ui
  output.min:-1.13242
  output.max:1.15239
  output.measure:silence-and-noise
  // 1 input, 1 output

it.MAX_INTER  it.MAX_INTER
  // CONSTANT OUTPUT: the output does not move from 4
  // 0 input, 1 output

it.cosine  it.cosine
  // CONSTANT OUTPUT: the output does not move from 1
  // 0 input, 1 output

it.cubic  it.cubic
  // CONSTANT OUTPUT: the output does not move from 2
  // 0 input, 1 output

it.frdtable(N:3, S:16, init)  it.frdtable(N, S, init, idx)
  S.unit:samples
  init.nature:table
  init.example:os.sinwaveform(16)
  idx.nature:signal
  idx.example:os.phasor(16, 200)
  output.min:0
  output.max:0.382683
  output.measure:silence-and-noise
  // 1 input, 1 output

it.frwtable(N:3, S:16, init)  it.frwtable(N, S, init, w_idx, x, r_idx)
  S.unit:samples
  init.nature:expression
  init.example:os.sinwaveform(16)
  w_idx.nature:signal
  w_idx.example:ba.period(16)
  x.nature:signal
  x.example:os.osc(220)
  r_idx.nature:signal
  r_idx.example:os.phasor(16, 150)
  output.min:-0.998955
  output.max:0.999274
  output.measure:silence-and-noise
  // 3 inputs, 1 output
  // init is not an input: the compiler accepts it only in the form of its example

it.interpolate_cosine(dv:0.5, v0:0.0, v1:1.0)  it.interpolate_cosine(dv, v0, v1)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 0.5
  // 0 input, 1 output

it.interpolate_cubic(dv:0.5, v0:-1.0, v1:2.0, v2:1.0, v3:4.0)  it.interpolate_cubic(dv, v0, v1, v2, v3)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 1.5
  // 0 input, 1 output

it.interpolate_exponential(k:3.0, dv:0.5, v0:0.0, v1:1.0)  it.interpolate_exponential(k, dv, v0, v1)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 0.182426
  // 0 input, 1 output

it.interpolate_linear(dv:0.5, v0:0.0, v1:1.0)  it.interpolate_linear(dv, v0, v1)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 0.5
  // 0 input, 1 output

it.interpolate_logarithmic(dv:0.5, v0:100.0, v1:10000.0)  it.interpolate_logarithmic(dv, v0, v1)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 1000
  // 0 input, 1 output

it.interpolate_mel(dv:0.5, v0:100.0, v1:8000.0)  it.interpolate_mel(dv, v0, v1)
  dv.min:0
  dv.max:1
  v0.unit:Hz
  v1.unit:Hz
  // CONSTANT OUTPUT: the output does not move from 1938.18
  // 0 input, 1 output

it.interpolate_power(p:2.0, dv:0.5, v0:0.0, v1:1.0)  it.interpolate_power(p, dv, v0, v1)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 0.25
  // 0 input, 1 output

it.interpolate_smootherstep(dv:0.5, v0:0.0, v1:1.0)  it.interpolate_smootherstep(dv, v0, v1)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 0.5
  // 0 input, 1 output

it.interpolate_smoothstep(dv:0.5, v0:0.0, v1:1.0)  it.interpolate_smoothstep(dv, v0, v1)
  dv.min:0
  dv.max:1
  // CONSTANT OUTPUT: the output does not move from 0.5
  // 0 input, 1 output

it.interpolator_cosine(idv)  it.interpolator_cosine(gen, idv)
  gen.nature:signal
  idv.nature:function
  idv.example:it.make_idv(idxFloat)
  // NOT VERIFIABLE: the parameter's example relies on `idxFloat`, defined nowhere else

it.interpolator_cubic(idv)  it.interpolator_cubic(gen, idv)
  gen.nature:signal
  idv.nature:function
  idv.example:it.make_idv(idxFloat)
  // NOT VERIFIABLE: the parameter's example relies on `idxFloat`, defined nowhere else

it.interpolator_four_points(gen, idv, interpolate_four_points)  it.interpolator_four_points(gen, idv, interpolate_four_points)
  gen.nature:function
  idv.nature:function
  idv.example:it.make_idv(idxFloat)
  interpolate_four_points.nature:function
  interpolate_four_points.example:it.interpolate_cubic
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

it.interpolator_linear(idv)  it.interpolator_linear(gen, idv)
  gen.nature:signal
  idv.nature:function
  idv.example:it.make_idv(idxFloat)
  // NOT VERIFIABLE: the parameter's example relies on `idxFloat`, defined nowhere else

it.interpolator_null(gen, idv)  it.interpolator_null(gen, idv)
  gen.nature:function
  idv.nature:function
  idv.example:it.make_idv(idxFloat)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

it.interpolator_select(idv, sel:2)  it.interpolator_select(gen, idv, sel)
  sel.min:0
  sel.max:3
  gen.nature:signal
  idv.nature:function
  idv.example:it.make_idv(idxFloat)
  // NOT VERIFIABLE: the parameter's example relies on `idxFloat`, defined nowhere else

it.interpolator_two_points(gen, idv, interpolate_two_points)  it.interpolator_two_points(gen, idv, interpolate_two_points)
  gen.nature:function
  idv.nature:function
  idv.example:it.make_idv(idxFloat)
  interpolate_two_points.nature:function
  interpolate_two_points.example:it.interpolate_linear
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

it.lagrangeCoeffs(N:2, xCoords)  it.lagrangeCoeffs(N, xCoords, x)
  xCoords.nature:table
  xCoords.example:(0.0, 0.5, 1.0)
  x.nature:signal
  output.min:-7.9999
  output.max:5.99994
  output.measure:silence-and-noise
  // at rest: 0 to 1; under noise: -7.9999 to 5.99994
  // 1 input, 3 outputs

it.lagrangeInterpolation(N:3, xCoords)  it.lagrangeInterpolation(N, xCoords, x)
  xCoords.nature:table
  x.nature:signal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

it.lagrangeN(N:3)  it.lagrangeN(N, x)
  x.nature:signal
  x.example:N / 2.0
  output.min:-12.5219
  output.max:13.7982
  output.measure:silence-and-noise
  // 5 inputs, 1 output

it.lagrange_h(N:2)  it.lagrange_h(N, x)
  x.nature:signal
  output.min:-2.99997
  output.max:2.99998
  output.measure:silence-and-noise
  // at rest: 0 to 1; under noise: -2.99997 to 2.99998
  // GUESSED: N:2, from the parameter name
  // 1 input, 3 outputs

it.lerp  it.lerp(x0, x1, y0, y1, x)
  x0.nature:signal
  x1.nature:signal
  y0.nature:signal
  y1.nature:signal
  x.nature:signal
  output.min:-228621
  output.max:155160
  output.measure:silence-and-noise
  // 5 inputs, 1 output

it.linear  it.linear
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

it.nointerp  it.nointerp
  // CONSTANT OUTPUT: the output does not move from 3
  // 0 input, 1 output

it.piecewise(xList, yList)  it.piecewise(xList, yList, x)
  xList.nature:table
  xList.example:(-5, -2, 0, 3)
  yList.nature:table
  yList.example:(1, 0, 4, -1)
  x.nature:signal
  x.example:os.osc(0.1)
  output.min:2.00002
  output.max:4
  output.measure:silence-and-noise
  // at rest: 4 to 4; under noise: 2.00002 to 4
  // 1 input, 1 output

it.remap(from1:-1.0, from2:1.0, to1:100.0, to2:1000.0)  it.remap(from1, from2, to1, to2, x)
  from1.min:-6
  from1.max:16
  from2.min:0
  from2.max:135
  to1.min:-72
  to1.max:102000
  to2.min:-6
  to2.max:2000
  x.nature:signal
  x.example:os.osc(0.5)
  output.min:100.004
  output.max:999.975
  output.measure:silence-and-noise
  // at rest: 550 to 550; under noise: 100.004 to 999.975
  // BOUNDS FROM USAGE, the values the libraries pass to it: from1 from -6 to 16
  // BOUNDS FROM USAGE, the values the libraries pass to it: from2 from 0 to 135
  // BOUNDS FROM USAGE, the values the libraries pass to it: to1 from -72 to 102000
  // BOUNDS FROM USAGE, the values the libraries pass to it: to2 from -6 to 2000
  // 1 input, 1 output

la.determinant(N:2)  la.determinant(N)
  output.min:-1.89194
  output.max:1.86172
  output.measure:silence-and-noise
  // 4 inputs, 1 output

la.diag(N:3)  la.diag(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 9 outputs

la.identity(N:3)  la.identity(N)
  output.min:0
  output.max:1
  output.measure:no-input
  // 0 input, 9 outputs

la.inverse(N:2)  la.inverse(N)
  // OUTPUT NOT FINITE: NaN or infinity on silence (767488 samples out of 767488)
  // 4 inputs, 4 outputs

la.matMul(J:2, K:2, L:2, M:2)  la.matMul(J, K, L, M)
  output.min:-1.96727
  output.max:1.86604
  output.measure:silence-and-noise
  // 8 inputs, 4 outputs

la.minor(N:3, ROW:1, COL:1)  la.minor(N, ROW, COL)
  output.min:-1.82377
  output.max:1.85261
  output.measure:silence-and-noise
  // 9 inputs, 1 output

la.transpose2(N:2, M:3)  la.transpose2(N, M)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 6 inputs, 6 outputs

ma.BS  ma.BS
  // CONSTANT OUTPUT: the output does not move from 512
  // 0 input, 1 output

ma.E  ma.E
  // CONSTANT OUTPUT: the output does not move from 2.71828
  // 0 input, 1 output

ma.EPSILON  ma.EPSILON
  // CONSTANT OUTPUT: the output does not move from 1.19209e-07
  // 0 input, 1 output

ma.FTZ  ma.FTZ(x)
  x.nature:signal
  x.example:"FTZ_test = ((ma.MIN * 0.5)"
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.INFINITY  ma.INFINITY
  // CONSTANT OUTPUT: the output does not move from 3.40282e+38
  // 0 input, 1 output

ma.J0  ma.J0
  faustwasm.unavailable:j0
  // DOES NOT COMPILE: ERROR : calling foreign function 'j0' is not allowed in this compilation mode

ma.J1  ma.J1
  faustwasm.unavailable:j1
  // DOES NOT COMPILE: ERROR : calling foreign function 'j1' is not allowed in this compilation mode

ma.Jn  ma.Jn
  faustwasm.unavailable:jn
  // DOES NOT COMPILE: ERROR : calling foreign function 'jn' is not allowed in this compilation mode

ma.MAX  ma.MAX
  // CONSTANT OUTPUT: the output does not move from 3.40282e+38
  // 0 input, 1 output

ma.MIN  ma.MIN
  // CONSTANT OUTPUT: the output does not move from 1.17549e-38
  // 0 input, 1 output

ma.PI  ma.PI
  // CONSTANT OUTPUT: the output does not move from 3.14159
  // 0 input, 1 output

ma.SR  ma.SR
  // CONSTANT OUTPUT: the output does not move from 48000
  // 0 input, 1 output

ma.T  ma.T
  // CONSTANT OUTPUT: the output does not move from 2.08333e-05
  // 0 input, 1 output

ma.Y0  ma.Y0
  faustwasm.unavailable:y0
  // DOES NOT COMPILE: ERROR : calling foreign function 'y0' is not allowed in this compilation mode

ma.Y1  ma.Y1
  faustwasm.unavailable:y1
  // DOES NOT COMPILE: ERROR : calling foreign function 'y1' is not allowed in this compilation mode

ma.Yn  ma.Yn
  faustwasm.unavailable:yn
  // DOES NOT COMPILE: ERROR : calling foreign function 'yn' is not allowed in this compilation mode

ma.acosh  ma.acosh
  // OUTPUT NOT FINITE: NaN or infinity on silence (191872 samples out of 191872)
  // 1 input, 1 output

ma.asinh  ma.asinh
  output.min:-0.881368
  output.max:0.881334
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.atanh  ma.atanh
  output.min:-6.20801
  output.max:5.24566
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.cbrt  ma.cbrt
  faustwasm.unavailable:cbrtf
  // DOES NOT COMPILE: ERROR : calling foreign function 'cbrtf' is not allowed in this compilation mode

ma.chebychev(n:3)  ma.chebychev(n, x)
  x.nature:signal
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output
  // n cannot be adjusted live: the compiler demands a constant in this place

ma.chebychevpoly(lcoef)  ma.chebychevpoly(lcoef)
  lcoef.nature:table
  lcoef.example:(1, 0, 1)
  output.min:0
  output.max:1.99997
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.copysign  ma.copysign
  output.min:-0.999991
  output.max:0.999974
  output.measure:silence-and-noise
  // 2 inputs, 1 output

ma.cosh  ma.cosh
  output.min:1
  output.max:1.54307
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 1 to 1.54307
  // 1 input, 1 output

ma.decimal  ma.decimal(x)
  x.nature:signal
  x.example:n
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.deg2rad  ma.deg2rad
  output.min:-0.0174532
  output.max:0.0174523
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.diffn  ma.diffn(x)
  x.nature:signal
  x.example:os.osc(440)
  output.min:-1.99747
  output.max:1.99402
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.erf  ma.erf
  faustwasm.unavailable:erff
  // DOES NOT COMPILE: ERROR : calling foreign function 'erff' is not allowed in this compilation mode

ma.erfc  ma.erfc
  faustwasm.unavailable:erfcf
  // DOES NOT COMPILE: ERROR : calling foreign function 'erfcf' is not allowed in this compilation mode

ma.expm1  ma.expm1
  faustwasm.unavailable:expm1f
  // DOES NOT COMPILE: ERROR : calling foreign function 'expm1f' is not allowed in this compilation mode

ma.fabs  ma.fabs
  output.min:0
  output.max:0.999992
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.fmax  ma.fmax
  output.min:-0.996924
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 1 output

ma.fmin  ma.fmin
  output.min:-0.999999
  output.max:0.995626
  output.measure:silence-and-noise
  // 2 inputs, 1 output

ma.frac(n:3.75)  ma.frac(n)
  // CONSTANT OUTPUT: the output does not move from 0.75
  // 0 input, 1 output

ma.gamma  ma.gamma
  faustwasm.unavailable:tgammaf
  // DOES NOT COMPILE: ERROR : calling foreign function 'tgammaf' is not allowed in this compilation mode

ma.hypot  ma.hypot
  faustwasm.unavailable:hypotf
  // DOES NOT COMPILE: ERROR : calling foreign function 'hypotf' is not allowed in this compilation mode

ma.ilogb  ma.ilogb
  faustwasm.unavailable:ilogbf
  // DOES NOT COMPILE: ERROR : calling foreign function 'ilogbf' is not allowed in this compilation mode

ma.inv  ma.inv(x)
  x.nature:signal
  // OUTPUT NOT FINITE: NaN or infinity on silence (191872 samples out of 191872)
  // 1 input, 1 output

ma.isinf  ma.isinf(x)
  x.nature:signal
  x.example:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

ma.isnan  ma.isnan(x)
  x.nature:signal
  x.example:sqrt
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

ma.ldexp  ma.ldexp
  faustwasm.unavailable:ldexpf
  // DOES NOT COMPILE: ERROR : calling foreign function 'ldexpf' is not allowed in this compilation mode

ma.lgamma  ma.lgamma
  faustwasm.unavailable:lgammaf
  // DOES NOT COMPILE: ERROR : calling foreign function 'lgammaf' is not allowed in this compilation mode

ma.log1p  ma.log1p
  faustwasm.unavailable:log1pf
  // DOES NOT COMPILE: ERROR : calling foreign function 'log1pf' is not allowed in this compilation mode

ma.log2  ma.log2(x)
  x.nature:signal
  // OUTPUT NOT FINITE: NaN or infinity on silence (191872 samples out of 191872)
  // 1 input, 1 output

ma.logb  ma.logb
  faustwasm.unavailable:logbf
  // DOES NOT COMPILE: ERROR : calling foreign function 'logbf' is not allowed in this compilation mode

ma.modulo  ma.modulo(x, y)
  x.nature:signal
  y.nature:signal
  // OUTPUT NOT FINITE: NaN or infinity on silence (191872 samples out of 191872)
  // 2 inputs, 1 output

ma.neg  ma.neg(x)
  x.nature:signal
  output.min:-0.999944
  output.max:0.999992
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.nextafter  ma.nextafter
  faustwasm.unavailable:nextafter
  // DOES NOT COMPILE: ERROR : calling foreign function 'nextafter' is not allowed in this compilation mode

ma.nextpow2  ma.nextpow2(x)
  x.nature:signal
  // OUTPUT NOT FINITE: NaN or infinity on silence (191872 samples out of 191872)
  // 1 input, 1 output

ma.not  ma.not(x)
  x.nature:signal
  // CONSTANT OUTPUT: the output does not move from -1
  // 1 input, 1 output

ma.np2(n:5)  ma.np2(n)
  // CONSTANT OUTPUT: the output does not move from 8
  // 0 input, 1 output

ma.primes  ma.primes(x)
  x.nature:signal
  // CONSTANT OUTPUT: the output does not move from 2
  // 1 input, 1 output

ma.rad2deg  ma.rad2deg
  output.min:-57.2953
  output.max:57.2926
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.scalb  ma.scalb
  faustwasm.unavailable:scalbnf
  // DOES NOT COMPILE: ERROR : calling foreign function 'scalbnf' is not allowed in this compilation mode

ma.signum  ma.signum(x)
  x.nature:signal
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.sinh  ma.sinh
  output.min:-1.17519
  output.max:1.17512
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.sub  ma.sub(x, y)
  x.nature:signal
  y.nature:signal
  output.min:-1.9936
  output.max:1.99822
  output.measure:silence-and-noise
  // 2 inputs, 1 output

ma.tanh  ma.tanh
  output.min:-0.761591
  output.max:0.761571
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.unwrap(pi:ma.PI)  ma.unwrap(pi, x)
  x.nature:signal
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

ma.zc  ma.zc
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

mi.collision(k:5.0, thres:0.01, x1r0:0.0, x2r0:0.0)  mi.collision(k, z, thres, x1r0, x2r0, x1, x2)
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-12.5773
  output.max:12.5773
  output.measure:silence-and-noise
  // at rest: -0.05 to 0.05; under noise: -12.5773 to 12.5773
  // 3 inputs, 2 outputs

mi.damper(x1r0:0.0, x2r0:0.0)  mi.damper(z, x1r0, x2r0, x1, x2)
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-3.39717
  output.max:3.39717
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

mi.ground  mi.ground(x0)
  x0.nature:signal
  output.min:-0.432201
  output.max:0
  output.measure:silence-and-noise
  // 2 inputs, 1 output

mi.initState(init:1.0)  mi.initState(init)
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

mi.mass(m:1.0, grav:0.0)  mi.mass(m, grav, x0, x1)
  x0.nature:signal
  x1.nature:signal
  x1.example:xr0
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 5.221e+07)
  // 3 inputs, 1 output

mi.nlBow(scale:0.1, type:1.0, x1r0:0.0, x2r0:0.0)  mi.nlBow(z, scale, type, x1r0, x2r0, x1, x2)
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-0.0222351
  output.max:0.0222351
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

mi.nlCollisionClipped(s:3.0, c:0.5, k:6.0, thres:0.01, x1r0:0.0, x2r0:0.0)  mi.nlCollisionClipped(s, c, k, z, thres, x1r0, x2r0, x1, x2)
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-12.4019
  output.max:12.4019
  output.measure:silence-and-noise
  // at rest: -0.0300005 to 0.0300005; under noise: -12.4019 to 12.4019
  // 3 inputs, 2 outputs

mi.nlPluck(k:5.0, scale:0.4, x1r0:0.2, x2r0:-0.2)  mi.nlPluck(k, scale, z, x1r0, x2r0, x1, x2)
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-2.25824
  output.max:2.25824
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

mi.nlSpringDamper2(k:5.0, q:1.0, x1r0:0.0, x2r0:0.0)  mi.nlSpringDamper2(k, q, z, x1r0, x2r0, x1, x2)
  q.min:0.5
  q.max:50
  q.scale:log
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-16.4753
  output.max:16.4753
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: q from 0.5 to 50
  // 3 inputs, 2 outputs

mi.nlSpringDamper3(k:5.0, q:0.5, x1r0:0.0, x2r0:0.0)  mi.nlSpringDamper3(k, q, z, x1r0, x2r0, x1, x2)
  q.min:0.5
  q.max:50
  q.scale:log
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-16.4479
  output.max:16.4479
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: q from 0.5 to 50
  // 3 inputs, 2 outputs

mi.nlSpringDamperClipped(s:5.0, c:0.5, k:8.0, x1r0:0.0, x2r0:0.0)  mi.nlSpringDamperClipped(s, c, k, z, x1r0, x2r0, x1, x2)
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-16.4479
  output.max:16.4479
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

mi.oscil(m:1.0, k:0.5, grav:0.0)  mi.oscil(m, k, z, grav, x0, x1)
  z.nature:signal
  x0.nature:signal
  x1.nature:signal
  x1.example:xr0
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 9.516e+06)
  // 4 inputs, 1 output

mi.posInput(init:0.0)  mi.posInput(init)
  output.min:-0.999999
  output.max:0.999977
  output.measure:silence-and-noise
  // 2 inputs, 1 output

mi.spring(k:10.0, x1r0:0.0, x2r0:0.0)  mi.spring(k, x1r0, x2r0, x1, x2)
  x1.nature:signal
  x2.nature:signal
  output.min:-19.9822
  output.max:19.9822
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

mi.springDamper(k:5.0, x1r0:0.0, x2r0:0.0)  mi.springDamper(k, z, x1r0, x2r0, x1, x2)
  z.nature:signal
  x1.nature:signal
  x2.nature:signal
  output.min:-12.5722
  output.max:12.5722
  output.measure:silence-and-noise
  // 3 inputs, 2 outputs

mo.accelEnvelopeAbs(thr:0.1, gain:1.2, envUpMs:10, envDownMs:12)  mo.accelEnvelopeAbs(thr, gain, envUpMs, envDownMs, sig)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  sig.nature:signal
  sig.example:os.sawtooth(0.5)
  output.min:0
  output.max:0.545731
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 1 input, 1 output

mo.accelEnvelopeNeg(thr:0.05, gain:1.35, envUpMs:10, envDownMs:10)  mo.accelEnvelopeNeg(thr, gain, envUpMs, envDownMs, sig)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  sig.nature:signal
  sig.example:os.triangle(2) * (-0.8)
  output.min:0
  output.max:0.340026
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 1 input, 1 output

mo.accelEnvelopePos(thr:0.05, gain:1.35, envUpMs:10, envDownMs:10)  mo.accelEnvelopePos(thr, gain, envUpMs, envDownMs, sig)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  sig.nature:signal
  sig.example:os.triangle(2) * 0.8
  output.min:0
  output.max:0.337029
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 1 input, 1 output

mo.envelopeAbs(thr:0.05, gain:1.25, envUpMs:15, envDownMs:25)  mo.envelopeAbs(thr, gain, envUpMs, envDownMs, sig)
  gain.min:0
  gain.max:2
  sig.nature:signal
  output.min:0
  output.max:0.650098
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 1 input, 1 output

mo.envelopeNeg(thr:0.05, gain:1.25, envUpMs:15, envDownMs:25)  mo.envelopeNeg(thr, gain, envUpMs, envDownMs, sig)
  gain.min:0
  gain.max:2
  sig.nature:signal
  output.min:0
  output.max:0.393516
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 1 input, 1 output

mo.envelopePos(thr:0.05, gain:1.25, envUpMs:15, envDownMs:25)  mo.envelopePos(thr, gain, envUpMs, envDownMs, sig)
  gain.min:0
  gain.max:2
  sig.nature:signal
  output.min:0
  output.max:0.395245
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 1 input, 1 output

mo.gyroEnvelopeAbs(thr:0.02, gain:0.9, envUpMs:25, envDownMs:30)  mo.gyroEnvelopeAbs(thr, gain, envUpMs, envDownMs, sig)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  sig.nature:signal
  sig.example:os.sawtooth(0.5) * 0.2
  output.min:0
  output.max:0.468953
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 1 input, 1 output

mo.gyroEnvelopeNeg(thr:0.02, gain:0.9, envUpMs:25, envDownMs:30)  mo.gyroEnvelopeNeg(thr, gain, envUpMs, envDownMs, sig)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  sig.nature:signal
  sig.example:os.triangle(3) * (-0.8)
  output.min:0
  output.max:0.258688
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 1 input, 1 output

mo.gyroEnvelopePos(thr:0.02, gain:0.9, envUpMs:25, envDownMs:30)  mo.gyroEnvelopePos(thr, gain, envUpMs, envDownMs, sig)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  sig.nature:signal
  sig.example:os.triangle(3) * 0.8
  output.min:0
  output.max:0.260457
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 1 input, 1 output

mo.inclineBalance(lpHz:1.5)  mo.inclineBalance(lpHz, posSig, negSig)
  lpHz.unit:Hz
  lpHz.min:0.1
  lpHz.max:20
  lpHz.scale:log
  posSig.nature:signal
  posSig.example:os.sawtooth(0.2) * 0.5 + 0.5
  negSig.nature:signal
  negSig.example:os.sawtooth(0.2) * (-0.5)
  output.min:0.493914
  output.max:0.506343
  output.measure:silence-and-noise
  // at rest: 0.5 to 0.5; under noise: 0.493914 to 0.506343
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: lpHz from 0.1 to 20
  // 2 inputs, 1 output

mo.inclineSymmetric(lpHz:1.5)  mo.inclineSymmetric(lpHz, posSig, negSig)
  lpHz.unit:Hz
  lpHz.min:0.1
  lpHz.max:20
  lpHz.scale:log
  posSig.nature:signal
  posSig.example:os.triangle(0.3) * 0.5 + 0.5
  negSig.nature:signal
  negSig.example:os.triangle(0.3) * (-0.5)
  output.min:0.485859
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.485859 to 0.515776
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: lpHz from 0.1 to 20
  // 2 inputs, 1 output

mo.inclinometer(lpHz:2)  mo.inclinometer(lpHz, sig)
  lpHz.unit:Hz
  lpHz.min:0.1
  lpHz.max:20
  lpHz.scale:log
  sig.nature:signal
  sig.example:os.sawtooth(1)
  output.min:0
  output.max:0.263542
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: lpHz from 0.1 to 20
  // 1 input, 1 output

mo.motionEnvelope(thr:0.05, gain:1.25, envUpMs:15, envDownMs:25)  mo.motionEnvelope(thr, gain, envUpMs, envDownMs, sig)
  gain.min:0
  gain.max:2
  envUpMs.unit:ms
  envDownMs.unit:ms
  sig.nature:signal
  output.min:0
  output.max:0.395245
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 1 input, 1 output

mo.motionEnvelopeRange(lo:0.2, hi:0.5, envUpMs:15, envDownMs:25)  mo.motionEnvelopeRange(lo, hi, envUpMs, envDownMs, sig)
  lo.min:0
  lo.max:1
  envUpMs.unit:ms
  envDownMs.unit:ms
  sig.nature:signal
  sig.example:os.sawtooth(0.5) * 0.5 + 0.5
  output.min:0
  output.max:0.476278
  output.measure:silence-and-noise
  // 1 input, 1 output

mo.motionEnvelopeUD(thr:0.05, gain:1.25, envUpMs:120, envDownMs:40)  mo.motionEnvelopeUD(thr, gain, envUpMs, envDownMs, sig)
  gain.min:0
  gain.max:2
  envUpMs.unit:ms
  envDownMs.unit:ms
  sig.nature:signal
  sig.example:os.triangle(0.4) * 0.5 + 0.5
  output.min:0
  output.max:0.995651
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 1 input, 1 output

mo.orientation6(shapeCour:1, shapeRear:1, shapeJardin:1, shapeFront:1, shapeDown:1, shapeUp:1, smoothMs:10)  mo.orientation6(xs, ys, zs, shapeCour, shapeRear, shapeJardin, shapeFront, shapeDown, shapeUp, smoothMs)
  shapeCour.min:0
  shapeCour.max:4
  shapeRear.min:0
  shapeRear.max:4
  shapeJardin.min:0
  shapeJardin.max:4
  shapeFront.min:0
  shapeFront.max:4
  shapeDown.min:0
  shapeDown.max:4
  shapeUp.min:0
  shapeUp.max:4
  smoothMs.unit:ms
  smoothMs.min:0
  smoothMs.max:200
  xs.nature:signal
  xs.example:os.triangle(0.05)
  ys.nature:signal
  ys.example:os.sawtooth(0.08)
  zs.nature:signal
  zs.example:os.triangle(0.03)
  output.min:0
  output.max:0.0870246
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: shapeCour from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: shapeRear from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: shapeJardin from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: shapeFront from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: shapeDown from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: shapeUp from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: smoothMs from 0 to 200
  // 3 inputs, 6 outputs

mo.orientationWeight(targetX:0, targetY:1, targetZ:0, shape:1, xs:0, ys:1, zs:0, smoothMs:10)  mo.orientationWeight(targetX, targetY, targetZ, shape, xs, ys, zs, smoothMs)
  targetX.min:-1
  targetX.max:1
  targetY.min:-1
  targetY.max:1
  targetZ.min:-1
  targetZ.max:1
  smoothMs.unit:ms
  // CONSTANT OUTPUT: the output does not move from 0.999986
  // 0 input, 1 output

mo.pita3  mo.pita3(x, y, z)
  x.nature:signal
  y.nature:signal
  z.nature:signal
  output.min:0
  output.max:1.7143
  output.measure:silence-and-noise
  // 3 inputs, 1 output

mo.projectedGravity(lpHz:2, offset:0.05)  mo.projectedGravity(lpHz, offset, sig)
  lpHz.unit:Hz
  lpHz.min:0.1
  lpHz.max:20
  lpHz.scale:log
  offset.min:0
  offset.max:0.33
  sig.nature:signal
  sig.example:os.triangle(0.1)
  output.min:0.466413
  output.max:0.480785
  output.measure:silence-and-noise
  // at rest: 0.4725 to 0.4725; under noise: 0.466413 to 0.480785
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: lpHz from 0.1 to 20
  // 1 input, 1 output

mo.scale(ilow:0.2, ihigh:0.8, olow:0, ohigh:1)  mo.scale(ilow, ihigh, olow, ohigh)
  ilow.min:0
  ilow.max:1
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

mo.shockTrigger(hpHz:50, threshold:0.5, debounceMs:50)  mo.shockTrigger(hpHz, threshold, debounceMs, sig)
  hpHz.unit:Hz
  hpHz.min:1
  hpHz.max:200
  hpHz.scale:log
  threshold.min:0
  threshold.max:3
  debounceMs.unit:ms
  debounceMs.min:0
  debounceMs.max:1000
  sig.nature:signal
  sig.example:os.pulsetrain(2, 0.5)
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: hpHz from 1 to 200
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: threshold from 0 to 3
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: debounceMs from 0 to 1000
  // 1 input, 1 output

mo.totalAccel(thr:0.05, gain:1.2, envUpMs:8, envDownMs:12)  mo.totalAccel(thr, gain, envUpMs, envDownMs, ax, ay, az)
  thr.min:0
  thr.max:3
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  ax.nature:signal
  ax.example:os.sawtooth(0.2) * 0.2
  ay.nature:signal
  ay.example:os.triangle(0.15) * 0.1
  az.nature:signal
  az.example:os.sawtooth(0.12) * 0.3
  output.min:0
  output.max:0.94457
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 3
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 3 inputs, 1 output

mo.totalAccelRange(lo:0.1, hi:0.4, envUpMs:8, envDownMs:12)  mo.totalAccelRange(lo, hi, envUpMs, envDownMs, ax, ay, az)
  lo.min:0
  lo.max:1
  hi.min:0.4
  hi.max:1
  envUpMs.unit:ms
  envDownMs.unit:ms
  ax.nature:signal
  ax.example:os.sawtooth(0.2) * 0.2
  ay.nature:signal
  ay.example:os.triangle(0.15) * 0.1
  az.nature:signal
  az.example:os.sawtooth(0.12) * 0.3
  output.min:0
  output.max:0.997642
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: hi from 0.4 to 1
  // 3 inputs, 1 output

mo.totalAccelUD(thr:0.05, gain:1.2, envUpMs:120, envDownMs:40)  mo.totalAccelUD(thr, gain, envUpMs, envDownMs, ax, ay, az)
  gain.min:0
  gain.max:2
  envUpMs.unit:ms
  envDownMs.unit:ms
  ax.nature:signal
  ax.example:os.sawtooth(0.2) * 0.2
  ay.nature:signal
  ay.example:os.triangle(0.15) * 0.1
  az.nature:signal
  az.example:os.sawtooth(0.12) * 0.3
  output.min:0
  output.max:0.999828
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 3 inputs, 1 output

mo.totalEnvelope(thr:0.01, gain:0.79, envUpMs:50, envDownMs:50)  mo.totalEnvelope(thr, gain, envUpMs, envDownMs, x, y, z)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  x.nature:signal
  y.nature:signal
  z.nature:signal
  output.min:0
  output.max:0.750319
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 3 inputs, 1 output

mo.totalGyro(thr:0.02, gain:0.9, envUpMs:25, envDownMs:30)  mo.totalGyro(thr, gain, envUpMs, envDownMs, gx, gy, gz)
  thr.min:0
  thr.max:1
  gain.min:0
  gain.max:5
  envUpMs.unit:ms
  envUpMs.min:0
  envUpMs.max:5000
  envDownMs.unit:ms
  envDownMs.min:0
  envDownMs.max:5000
  gx.nature:signal
  gx.example:os.sawtooth(0.2) * 0.2
  gy.nature:signal
  gy.example:os.triangle(0.15) * 0.1
  gz.nature:signal
  gz.example:os.sawtooth(0.12) * 0.3
  output.min:0
  output.max:0.837618
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: thr from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envUpMs from 0 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: envDownMs from 0 to 5000
  // 3 inputs, 1 output

no.colored_noise(N:4, alpha:0.0)  no.colored_noise(N, alpha)
  alpha.min:-1
  alpha.max:1
  output.min:-1
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

no.dnoise(sx:10.0)  no.dnoise(t, sx)
  t.nature:signal
  t.example:1 : ba.impulsify
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

no.gnoise(N:8)  no.gnoise(N)
  output.min:-3.96741
  output.max:3.75055
  output.measure:no-input
  // 0 input, 1 output

no.gnoisem(N:2)  no.gnoisem(N)
  output.min:-1.52774
  output.max:1.52335
  output.measure:no-input
  // GUESSED: N:2, from the parameter name
  // 0 input, 1 output

no.lfnoise(freq:10.1)  no.lfnoise(freq)
  output.min:-0.859927
  output.max:0.842526
  output.measure:no-input
  // 0 input, 1 output

no.lfnoise0(freq:10.1)  no.lfnoise0(freq)
  output.min:-0.979363
  output.max:0.925248
  output.measure:no-input
  // 0 input, 1 output

no.lfnoiseN(N:3, freq:10.1)  no.lfnoiseN(N, freq)
  output.min:-0.929113
  output.max:0.898254
  output.measure:no-input
  // 0 input, 1 output

no.multinoise(n:3)  no.multinoise(n)
  output.min:-0.999991
  output.max:0.999996
  output.measure:no-input
  // 0 input, 3 outputs

no.multirandom(n:3)  no.multirandom(n)
  output.min:-2.14747e+09
  output.max:2.14747e+09
  output.measure:no-input
  // 0 input, 3 outputs

no.noise  no.noise
  output.min:-0.999986
  output.max:0.99998
  output.measure:no-input
  // 0 input, 1 output

no.noises(N:4, i:2)  no.noises(N, i)
  output.min:-0.999991
  output.max:0.999985
  output.measure:no-input
  // 0 input, 1 output
  // i cannot be adjusted live: the compiler demands a constant in this place

no.pink_filter  no.pink_filter
  output.min:-0.193047
  output.max:0.198784
  output.measure:silence-and-noise
  // 1 input, 1 output

no.pink_noise  no.pink_noise
  output.min:-0.206333
  output.max:0.207954
  output.measure:no-input
  // 0 input, 1 output

no.pink_noise_m  no.pink_noise_m
  output.min:-2.57916
  output.max:2.59943
  output.measure:no-input
  // 0 input, 1 output

no.pink_noise_vm(N:4)  no.pink_noise_vm(N)
  output.min:-4.7693
  output.max:4.75865
  output.measure:no-input
  // 0 input, 1 output

no.randomseed  no.randomseed
  faustwasm.unavailable:arc4random
  // DOES NOT COMPILE: ERROR : calling foreign function 'arc4random' is not allowed in this compilation mode

no.rmultinoise(N:3)  no.rmultinoise(N)
  faustwasm.unavailable:arc4random
  // DOES NOT COMPILE: ERROR : calling foreign function 'arc4random' is not allowed in this compilation mode

no.rmultirandom(N:3)  no.rmultirandom(N)
  faustwasm.unavailable:arc4random
  // DOES NOT COMPILE: ERROR : calling foreign function 'arc4random' is not allowed in this compilation mode

no.rnoise  no.rnoise
  faustwasm.unavailable:arc4random
  // DOES NOT COMPILE: ERROR : calling foreign function 'arc4random' is not allowed in this compilation mode

no.rnoises(N:4, i:1)  no.rnoises(N, i)
  faustwasm.unavailable:arc4random
  // DOES NOT COMPILE: ERROR : calling foreign function 'arc4random' is not allowed in this compilation mode

no.sparse_noise(f0:5.0)  no.sparse_noise(f0)
  output.min:-0.998832
  output.max:0.850182
  output.measure:no-input
  // 0 input, 1 output

no.velvet_noise(amp:0.5, f0:5.0)  no.velvet_noise(amp, f0)
  amp.min:0
  amp.max:2
  output.min:-0.5
  output.max:0.5
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: amp from 0 to 2
  // 0 input, 1 output

os.CZhalfSine(index:0.5)  os.CZhalfSine(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: -1 to 1
  // 1 input, 1 output

os.CZhalfSineP(index:0.5)  os.CZhalfSineP(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

os.CZpulse(index:0.5)  os.CZpulse(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: -1 to 1
  // 1 input, 1 output

os.CZpulseP(index:0.5)  os.CZpulseP(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

os.CZresSaw(res:2.5)  os.CZresSaw(fund, res)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-2.99998
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: -2.99998 to 1
  // 1 input, 1 output

os.CZresTrap(res:2.5)  os.CZresTrap(fund, res)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

os.CZresTriangle(res:2.5)  os.CZresTriangle(fund, res)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-4.22006
  output.max:0.638958
  output.measure:silence-and-noise
  // at rest: -1 to -1; under noise: -4.22006 to 0.638958
  // 1 input, 1 output

os.CZsaw(index:0.5)  os.CZsaw(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: -1 to 1
  // 1 input, 1 output

os.CZsawP(index:0.5)  os.CZsawP(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

os.CZsinePulse(index:0.5)  os.CZsinePulse(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: -1 to 1
  // 1 input, 1 output

os.CZsinePulseP(index:0.5)  os.CZsinePulseP(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // at rest: -0.010542 to -0.010542; under noise: -1 to 1
  // 1 input, 1 output

os.CZsquare(index:0.5)  os.CZsquare(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: -1 to 1
  // 1 input, 1 output

os.CZsquareP(index:0.5)  os.CZsquareP(fund, index)
  fund.nature:signal
  fund.example:os.lf_sawpos(110)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

os.MAX_SAW_ORDER  os.MAX_SAW_ORDER
  // CONSTANT OUTPUT: the output does not move from 4
  // 0 input, 1 output

os.SAFE  os.SAFE
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

os.coswaveform(tablesize:1024)  os.coswaveform(tablesize)
  output.min:-1
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

os.dsf  os.dsf
  // a set of definitions: qo, co, so, Nq(f0, df), oscc(f0, df, a), oscs(f0, df, a), osccN(f0, df, a, n), oscsN(f0, df, a, n), osccNq(f0, df, a), oscsNq(f0, df, a)

os.hs_osccos(freq:440, reset:0)  os.hs_osccos(freq, reset)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.hs_oscsin(freq:440)  os.hs_oscsin(freq, reset)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  reset.nature:signal
  reset.example:ba.pulse(32)
  output.min:-1
  output.max:1
  output.measure:silence-and-noise
  // at rest: -1 to 1; under noise: -1 to 1
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

os.hs_phasor(tablesize:1024, freq:330)  os.hs_phasor(tablesize, freq, reset)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  reset.nature:signal
  reset.example:ba.pulse(32)
  output.min:0.00439453
  output.max:1024
  output.measure:silence-and-noise
  // at rest: 0.00439453 to 1024; under noise: 0.00439453 to 1024
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

os.hsp_phasor(tablesize:1024, freq:330, reset:0, phase:0.25)  os.hsp_phasor(tablesize, freq, reset, phase)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  phase.min:0
  phase.max:1
  output.min:0.000244141
  output.max:1023.99
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.imptrain(freq:220)  os.imptrain(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.00459064
  output.max:0.994477
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.imptrainN(N:3, freq:220)  os.imptrainN(N, freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.00502452
  output.max:0.745698
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.impulse  os.impulse
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

os.lf_imptrain(freq:3)  os.lf_imptrain(freq)
  freq.unit:Hz
  freq.min:0
  freq.max:10
  output.min:0
  output.max:1
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: freq from 0 to 10
  // 0 input, 1 output

os.lf_pulsetrain(freq:3, duty:0.35)  os.lf_pulsetrain(freq, duty)
  freq.unit:Hz
  duty.min:0
  duty.max:1
  output.min:-1
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

os.lf_pulsetrainpos(freq:3, duty:0.35)  os.lf_pulsetrainpos(freq, duty)
  freq.unit:Hz
  duty.min:0
  duty.max:1
  output.min:0
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

os.lf_rawsaw(periodsamps:128)  os.lf_rawsaw(periodsamps)
  output.min:0
  output.max:127
  output.measure:no-input
  // 0 input, 1 output

os.lf_saw(freq:3)  os.lf_saw(freq)
  freq.unit:Hz
  output.min:-0.999998
  output.max:0.999983
  output.measure:no-input
  // 0 input, 1 output

os.lf_sawpos(freq:3)  os.lf_sawpos(freq)
  freq.unit:Hz
  freq.min:3
  freq.max:220
  output.min:9.53674e-07
  output.max:0.999992
  output.measure:no-input
  // BOUNDS FROM USAGE, the values the libraries pass to it: freq from 3 to 220
  // 0 input, 1 output

os.lf_sawpos_phase(phase:3, freq:0.25)  os.lf_sawpos_phase(phase, freq)
  freq.unit:Hz
  output.min:7.7486e-06
  output.max:0.999998
  output.measure:no-input
  // 0 input, 1 output
  // the bounds stated for phase (0 to 1) are not kept: phase:3 falls outside

os.lf_sawpos_phase_reset(freq:3, phase:0.75, reset:0)  os.lf_sawpos_phase_reset(freq, phase, reset)
  freq.unit:Hz
  phase.min:0
  phase.max:1
  output.min:7.7486e-06
  output.max:0.999998
  output.measure:no-input
  // 0 input, 1 output

os.lf_sawpos_reset(freq:3)  os.lf_sawpos_reset(freq, reset)
  freq.unit:Hz
  reset.nature:signal
  reset.example:ba.pulse(32)
  output.min:9.53674e-07
  output.max:0.999992
  output.measure:silence-and-noise
  // at rest: 9.53674e-07 to 0.999992; under noise: 9.53674e-07 to 0.999992
  // 1 input, 1 output

os.lf_squarewave(freq:3)  os.lf_squarewave(freq)
  freq.unit:Hz
  output.min:-1
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

os.lf_squarewavepos(freq:3)  os.lf_squarewavepos(freq)
  freq.unit:Hz
  output.min:0
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

os.lf_triangle(freq:3)  os.lf_triangle(freq)
  freq.unit:Hz
  output.min:-0.999996
  output.max:0.99999
  output.measure:no-input
  // 0 input, 1 output

os.lf_trianglepos(freq:3)  os.lf_trianglepos(freq)
  freq.unit:Hz
  output.min:1.90735e-06
  output.max:0.999995
  output.measure:no-input
  // 0 input, 1 output

os.m_osccos(freq:440)  os.m_osccos(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.m_oscsin(freq:440)  os.m_oscsin(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.osc(freq:440)  os.osc(freq)
  freq.unit:Hz
  freq.min:0.1
  freq.max:12000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS FROM USAGE, the values the libraries pass to it: freq from 0.1 to 12000
  // 0 input, 1 output

os.oscb(f:440)  os.oscb(f)
  f.unit:Hz
  output.min:-17.3721
  output.max:17.3722
  output.measure:no-input
  // 0 input, 1 output

os.osccos(freq:440)  os.osccos(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.osci(freq:440)  os.osci(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.oscp(freq:440, p:ma.PI/3)  os.oscp(freq, p)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.oscq(fr:440)  os.oscq(fr)
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-0.999785
  output.max:0.999791
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 0 input, 2 outputs

os.oscr(f:440)  os.oscr(f)
  f.unit:Hz
  output.min:-0.999137
  output.max:0.999126
  output.measure:no-input
  // 0 input, 1 output

os.oscrc(f:440)  os.oscrc(f)
  f.unit:Hz
  f.min:100
  f.max:1000
  output.min:-0.999132
  output.max:0.99912
  output.measure:no-input
  // BOUNDS FROM USAGE, the values the libraries pass to it: f from 100 to 1000
  // 0 input, 1 output

os.oscrp(f:440, p:0.5)  os.oscrp(f, p)
  f.unit:Hz
  output.min:-0.99912
  output.max:0.999131
  output.measure:no-input
  // 0 input, 1 output

os.oscrq(f:440)  os.oscrq(f)
  f.unit:Hz
  output.min:-0.999137
  output.max:0.999126
  output.measure:no-input
  // 0 input, 2 outputs

os.oscrs(f:440)  os.oscrs(f)
  f.unit:Hz
  output.min:-0.999137
  output.max:0.999126
  output.measure:no-input
  // 0 input, 1 output

os.oscs(f:440)  os.oscs(f)
  f.unit:Hz
  output.min:-1.00042
  output.max:1.00042
  output.measure:no-input
  // 0 input, 1 output

os.oscsin(freq:440)  os.oscsin(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.oscw(fr:440)  os.oscw(fr)
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-0.999776
  output.max:0.999791
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 0 input, 1 output

os.oscwc(fr:440)  os.oscwc(fr)
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-0.999776
  output.max:0.999791
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 0 input, 1 output

os.oscws(fr:440)  os.oscws(fr)
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-0.999785
  output.max:0.999778
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 0 input, 1 output

os.phasor(tablesize:1024, freq:440)  os.phasor(tablesize, freq)
  tablesize.min:1
  tablesize.max:1024
  tablesize.scale:log
  freq.unit:Hz
  freq.min:-0.001
  freq.max:1000
  output.min:0.00439453
  output.max:1024
  output.measure:no-input
  // BOUNDS FROM USAGE, the values the libraries pass to it: tablesize from 1 to 1024
  // BOUNDS FROM USAGE, the values the libraries pass to it: freq from -0.001 to 1000
  // 0 input, 1 output

os.polyblep(Q:0.2)  os.polyblep(Q, phase)
  phase.nature:signal
  phase.example:os.lf_sawpos(220)
  output.min:-35.9995
  output.max:0.999445
  output.measure:silence-and-noise
  // at rest: -1 to -1; under noise: -35.9995 to 0.999445
  // 1 input, 1 output

os.polyblep_saw(freq:220)  os.polyblep_saw(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.990854
  output.max:0.990851
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.polyblep_square(freq:220)  os.polyblep_square(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1
  output.max:1
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.polyblep_triangle(freq:220)  os.polyblep_triangle(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.994991
  output.max:0.994877
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.pulsetrain(freq:220, duty:0.25)  os.pulsetrain(freq, duty)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  duty.min:0
  duty.max:1
  output.min:-1.50001
  output.max:0.500009
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.pulsetrainN(N:3, freq:220, duty:0.25)  os.pulsetrainN(N, freq, duty)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  duty.min:0
  duty.max:1
  output.min:-1.5006
  output.max:0.500503
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.quadosc(f:440)  os.quadosc(f)
  f.unit:Hz
  output.min:-1
  output.max:1
  output.measure:no-input
  // 0 input, 2 outputs

os.rpm  os.rpm
  // a set of definitions: sawtooth(freq, beta), square(freq, beta)

os.saw1(freq:440)  os.saw1(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.999991
  output.max:0.999995
  output.measure:no-input
  // GUESSED: freq:440, from the parameter name
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.saw2(freq:220)  os.saw2(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.990817
  output.max:0.999994
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.saw2dpw(freq:220)  os.saw2dpw(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.995408
  output.max:0.995395
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.saw2f2(freq:220)  os.saw2f2(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1.30532
  output.max:0.9965
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.saw2f4(freq:220)  os.saw2f4(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1.30537
  output.max:0.996503
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.saw2ptr(freq:220)  os.saw2ptr(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.990817
  output.max:0.999994
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.saw3(freq:220)  os.saw3(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.990836
  output.max:0.990954
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.saw4(freq:220)  os.saw4(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1.01565
  output.max:1.01565
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.sawN(N:3, freq:440)  os.sawN(N, freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.981792
  output.max:0.98191
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

os.sawNp(N:3, freq:330, phase:0.5)  os.sawNp(N, freq, phase)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  phase.min:0
  phase.max:1
  output.min:-0.986462
  output.max:0.986409
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: phase from 0 to 1
  // 0 input, 1 output

os.sawtooth(freq:220)  os.sawtooth(freq)
  freq.unit:Hz
  freq.min:0.08
  freq.max:220
  freq.scale:log
  output.min:-0.990817
  output.max:0.999994
  output.measure:no-input
  // BOUNDS FROM USAGE, the values the libraries pass to it: freq from 0.08 to 220
  // 0 input, 1 output

os.sidebands(vs)  os.sidebands(vs, c0, s0)
  vs.nature:table
  vs.example:(1, 0.5, 0.25)
  c0.nature:signal
  s0.nature:signal
  output.min:-2.73171
  output.max:2.72858
  output.measure:silence-and-noise
  // at rest: -0.5 to 0; under noise: -2.73171 to 2.72858
  // 2 inputs, 2 outputs

os.sidebands_list(N:3)  os.sidebands_list(N, c0, s0)
  c0.nature:signal
  s0.nature:signal
  output.min:-2.97272
  output.max:2.98652
  output.measure:silence-and-noise
  // at rest: -1 to 0; under noise: -2.97272 to 2.98652
  // 2 inputs, 6 outputs

os.sinwaveform(tablesize:1024)  os.sinwaveform(tablesize)
  output.min:-1
  output.max:1
  output.measure:no-input
  // 0 input, 1 output

os.square(freq:220)  os.square(freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1.00001
  output.max:1.00001
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.squareN(N:3, freq:220)  os.squareN(N, freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-1.00067
  output.max:1.00063
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.triangle(freq:220)  os.triangle(freq)
  freq.unit:Hz
  freq.min:0.03
  freq.max:220
  freq.scale:log
  output.min:-0.997925
  output.max:0.999481
  output.measure:no-input
  // BOUNDS FROM USAGE, the values the libraries pass to it: freq from 0.03 to 220
  // 0 input, 1 output

os.triangleN(N:3, freq:220)  os.triangleN(N, freq)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.993779
  output.max:0.994935
  output.measure:no-input
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

os.twin_osc(f:220, amt:0.5, detune:0, m:0)  os.twin_osc(f, amt, detune, m)
  f.unit:Hz
  amt.min:0
  amt.max:1
  detune.unit:samples
  output.min:-1.57338
  output.max:0.766514
  output.measure:no-input
  // 0 input, 1 output

pf.flanger_mono(dmax:4096, curdel:1024, depth:0.7, fb:0.25, invert:0)  pf.flanger_mono(dmax, curdel, depth, fb, invert)
  depth.min:0
  depth.max:1
  fb.min:0
  fb.max:1
  output.min:-0.93674
  output.max:0.945233
  output.measure:silence-and-noise
  // 1 input, 1 output

pf.flanger_stereo(dmax:4096, curdel1:1024, curdel2:1536, depth:0.7, fb:0.25, invert:0)  pf.flanger_stereo(dmax, curdel1, curdel2, depth, fb, invert)
  depth.min:0
  depth.max:1
  fb.min:0
  fb.max:1
  output.min:-0.940961
  output.max:0.938788
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

pf.phaser2_mono(Notches:4, phase01:0.0, width:50, frqmin:200, fratio:1.5, frqmax:4000, speed:0.5, depth:0.8, fb:0.2, invert:0)  pf.phaser2_mono(Notches, phase01, width, frqmin, fratio, frqmax, speed, depth, fb, invert)
  phase01.min:0
  phase01.max:1
  width.unit:Hz
  width.min:10
  width.max:5000
  width.scale:log
  frqmin.unit:Hz
  frqmin.min:20
  frqmin.max:5000
  frqmin.scale:log
  fratio.min:1.1
  fratio.max:4
  frqmax.unit:Hz
  speed.unit:Hz
  speed.min:0
  speed.max:10
  depth.min:0
  depth.max:1
  fb.min:-1
  fb.max:1
  output.min:-1.1927
  output.max:1.26327
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: width from 10 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: frqmin from 20 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: fratio from 1.1 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: speed from 0 to 10
  // 1 input, 1 output

pf.phaser2_stereo(Notches:4, width:50, frqmin:200, fratio:1.5, frqmax:4000, speed:0.5, depth:0.8, fb:0.2, invert:0)  pf.phaser2_stereo(Notches, width, frqmin, fratio, frqmax, speed, depth, fb, invert)
  width.unit:Hz
  width.min:10
  width.max:5000
  width.scale:log
  frqmin.unit:Hz
  frqmin.min:20
  frqmin.max:5000
  frqmin.scale:log
  fratio.min:1.1
  fratio.max:4
  frqmax.unit:Hz
  speed.unit:Hz
  speed.min:0
  speed.max:10
  depth.min:0
  depth.max:1
  fb.min:-1
  fb.max:1
  output.min:-1.2234
  output.max:1.25419
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: width from 10 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: frqmin from 20 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: fratio from 1.1 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: speed from 0 to 10
  // 2 inputs, 2 outputs

pf.vibrato2_mono(sections:4, phase01:0, fb:0.5, width:1000, frqmin:100, fratio:1.5, frqmax:4800, speed:0.5)  pf.vibrato2_mono(sections, phase01, fb, width, frqmin, fratio, frqmax, speed)
  phase01.min:0
  phase01.max:1
  fb.min:-1
  fb.max:1
  width.unit:Hz
  width.min:10
  width.max:5000
  width.scale:log
  frqmin.unit:Hz
  frqmin.min:20
  frqmin.max:5000
  frqmin.scale:log
  fratio.min:1.1
  fratio.max:4
  frqmax.unit:Hz
  speed.unit:Hz
  speed.min:0
  speed.max:10
  output.min:-2.80831
  output.max:2.78373
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: width from 10 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: frqmin from 20 to 5000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: fratio from 1.1 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: speed from 0 to 10
  // 1 input, 1 output

pl.BS  pl.BS
  // CONSTANT OUTPUT: the output does not move from 512
  // 0 input, 1 output

pl.SR  pl.SR
  // CONSTANT OUTPUT: the output does not move from 48000
  // 0 input, 1 output

pl.tablesize  pl.tablesize
  // CONSTANT OUTPUT: the output does not move from 65536
  // 0 input, 1 output

pm.SFFormantModel(voiceType:0, vowel:0, exType:0.2, freq:220, gain:0.7, filterbank, isFof:1)  pm.SFFormantModel(voiceType, vowel, exType, freq, gain, source, filterbank, isFof)
  freq.min:20
  freq.max:20000
  freq.scale:log
  gain.min:0
  gain.max:2
  source.nature:signal
  source.example:os.lf_imptrain(220)
  filterbank.nature:function
  filterbank.example:pm.formantFilterbankFofCycle
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 1 input, 1 output

pm.SFFormantModelBP(voiceType:0, vowel:0, exType:0.2, freq:220, gain:0.7)  pm.SFFormantModelBP(voiceType, vowel, exType, freq, gain)
  voiceType.min:0
  voiceType.max:4
  vowel.min:0
  vowel.max:4
  exType.min:0
  exType.max:1
  freq.min:20
  freq.max:20000
  freq.scale:log
  gain.min:0
  gain.max:1
  output.min:-2.11528
  output.max:1.62223
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: voiceType from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: vowel from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: exType from 0 to 1
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 1
  // 0 input, 1 output

pm.SFFormantModelBP_ui  pm.SFFormantModelBP_ui
  output.min:-4.06004
  output.max:2.97048
  output.measure:no-input
  // 0 input, 1 output

pm.SFFormantModelBP_ui_MIDI  pm.SFFormantModelBP_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.SFFormantModelFofCycle(voiceType:0, vowel:0, freq:220, gain:0.7)  pm.SFFormantModelFofCycle(voiceType, vowel, freq, gain)
  voiceType.min:0
  voiceType.max:4
  vowel.min:0
  vowel.max:4
  freq.min:20
  freq.max:20000
  freq.scale:log
  gain.min:0
  gain.max:2
  output.min:-0.00415235
  output.max:0.00387345
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: voiceType from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: vowel from 0 to 4
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 0 input, 1 output

pm.SFFormantModelFofCycle_ui  pm.SFFormantModelFofCycle_ui
  output.min:-0.784444
  output.max:0.949384
  output.measure:no-input
  // 0 input, 1 output

pm.SFFormantModelFofCycle_ui_MIDI  pm.SFFormantModelFofCycle_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.SFFormantModelFofSmooth(voiceType:0, vowel:0, freq:220, gain:0.7)  pm.SFFormantModelFofSmooth(voiceType, vowel, freq, gain)
  voiceType.min:0
  voiceType.max:4
  vowel.min:0
  vowel.max:4
  freq.min:20
  freq.max:20000
  freq.scale:log
  gain.min:0
  gain.max:2
  output.min:-0.00680057
  output.max:0.00761312
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: voiceType from 0 to 4
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: vowel from 0 to 4
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 0 input, 1 output

pm.SFFormantModelFofSmooth_ui  pm.SFFormantModelFofSmooth_ui
  output.min:-0.299213
  output.max:0.398473
  output.measure:no-input
  // 0 input, 1 output

pm.SFFormantModelFofSmooth_ui_MIDI  pm.SFFormantModelFofSmooth_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.allpassNL(nonlinearity:0.4)  pm.allpassNL(nonlinearity)
  nonlinearity.min:0
  nonlinearity.max:1
  // OUTPUT NOT FINITE: NaN or infinity on noise (383744 samples out of 575616)
  // 3 inputs, 3 outputs

pm.autobendFreq(n:0, freq:220, voiceType:0)  pm.autobendFreq(n, freq, voiceType)
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: the output does not move from 220
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.basicBlock  pm.basicBlock
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.blower(pressure:0.5, breathGain:0.05, breathCutoff:2000, vibratoFreq:5, vibratoGain:0.2)  pm.blower(pressure, breathGain, breathCutoff, vibratoFreq, vibratoGain)
  pressure.min:0
  pressure.max:1
  breathGain.min:0
  breathGain.max:1
  breathCutoff.unit:Hz
  breathCutoff.min:20
  breathCutoff.max:20000
  breathCutoff.scale:log
  vibratoFreq.unit:Hz
  vibratoFreq.min:0.1
  vibratoFreq.max:10
  vibratoFreq.scale:log
  vibratoGain.min:0
  vibratoGain.max:1
  output.min:0.287597
  output.max:0.714037
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: breathCutoff from 20 to 20000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: vibratoFreq from 0.1 to 10
  // 0 input, 1 output

pm.blower_ui  pm.blower_ui
  output.min:-0.0075
  output.max:0.0075
  output.measure:no-input
  // 0 input, 1 output

pm.bowInteraction(b)  pm.bowInteraction(b)
  b.nature:table
  b.example:(0.4, 0.05)
  output.min:-0.999991
  output.max:1.39997
  output.measure:silence-and-noise
  // at rest: 0 to 0.4; under noise: -0.999991 to 1.39997
  // 3 inputs, 3 outputs

pm.bowTable(offset:0.4, slope:0.1)  pm.bowTable(offset, slope)
  // CONSTANT OUTPUT: the output does not move from 1
  // 1 input, 1 output

pm.brassLips(tubeLength:0.3, lipsTension:0.2, pressure:0.1)  pm.brassLips(tubeLength, lipsTension, pressure)
  lipsTension.min:0
  lipsTension.max:1
  pressure.min:0
  pressure.max:1
  output.min:-1.82913
  output.max:1.79734
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.brassLipsTable(tubeLength:0.3, lipsTension:0.2)  pm.brassLipsTable(tubeLength, lipsTension)
  lipsTension.min:0
  lipsTension.max:1
  output.min:0
  output.max:1
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.brassModel(tubeLength:0.9, lipsTension:0.4, mute:0.2, pressure:0.6)  pm.brassModel(tubeLength, lipsTension, mute, pressure)
  tubeLength.min:0.01
  tubeLength.max:2.5
  tubeLength.scale:log
  lipsTension.min:0
  lipsTension.max:1
  mute.min:0
  mute.max:1
  pressure.min:0
  pressure.max:1
  // CONSTANT OUTPUT: the output does not move from 1.49012e-06
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: tubeLength from 0.01 to 2.5
  // 0 input, 1 output

pm.brassModel_ui(pressure:0.4)  pm.brassModel_ui(pressure)
  pressure.min:0
  pressure.max:1
  output.min:-0.102823
  output.max:0.052709
  output.measure:no-input
  // 0 input, 1 output

pm.brass_ui  pm.brass_ui
  output.min:-2.57018e-08
  output.max:2.57057e-08
  output.measure:no-input
  // 0 input, 1 output

pm.brass_ui_MIDI  pm.brass_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.bridgeFilter(brightness:0.6, absorption:0.4)  pm.bridgeFilter(brightness, absorption, x)
  brightness.min:0
  brightness.max:1
  absorption.min:0.1
  absorption.max:0.9
  x.nature:signal
  output.min:-0.990588
  output.max:0.983192
  output.measure:silence-and-noise
  // BOUNDS FROM USAGE, the values the libraries pass to it: absorption from 0.1 to 0.9
  // 1 input, 1 output

pm.bwMultMaxes  pm.bwMultMaxes
  output.min:2.5
  output.max:15
  output.measure:no-input
  // 0 input, 10 outputs

pm.bwMultMins  pm.bwMultMins
  output.min:1
  output.max:3
  output.measure:no-input
  // 0 input, 10 outputs

pm.chain  pm.chain(A)
  A.nature:signal
  A.example:pm.basicBlock
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.churchBell(strikePosition:0.4, strikeCutoff:2000, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.churchBell(strikePosition, strikeCutoff, strikeSharpness, gain, trigger)
  strikePosition.min:0
  strikePosition.max:6
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.churchBellModel(nModes:50, exPos:0, t60:30, t60DecayRatio:1, t60DecaySlope:2.5)  pm.churchBellModel(nModes, exPos, t60, t60DecayRatio, t60DecaySlope)
  exPos.min:0
  exPos.max:6
  t60.unit:s
  output.min:-36.5576
  output.max:34.8148
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.churchBell_ui  pm.churchBell_ui
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.clarinetModel(tubeLength:0.9, pressure:0.4, reedStiffness:0.3, bellOpening:0.2)  pm.clarinetModel(tubeLength, pressure, reedStiffness, bellOpening)
  tubeLength.min:0.01
  tubeLength.max:3
  tubeLength.scale:log
  pressure.min:0
  pressure.max:1
  reedStiffness.min:0
  reedStiffness.max:1
  bellOpening.min:0
  bellOpening.max:1
  output.min:-0.289497
  output.max:0.318228
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: tubeLength from 0.01 to 3
  // 0 input, 1 output

pm.clarinetModel_ui(pressure:0.4)  pm.clarinetModel_ui(pressure)
  pressure.min:0
  pressure.max:1
  output.min:0.017967
  output.max:0.0179672
  output.measure:no-input
  // 0 input, 1 output

pm.clarinetMouthPiece(reedStiffness:0.6, pressure:0.4)  pm.clarinetMouthPiece(reedStiffness, pressure)
  reedStiffness.min:0
  reedStiffness.max:1
  pressure.min:0
  pressure.max:1
  output.min:-1.99767
  output.max:1.71466
  output.measure:silence-and-noise
  // at rest: 0 to 0.4; under noise: -1.99767 to 1.71466
  // 3 inputs, 3 outputs

pm.clarinetReed(stiffness:0.6)  pm.clarinetReed(stiffness)
  stiffness.min:0
  stiffness.max:1
  output.min:0.416016
  output.max:0.983998
  output.measure:silence-and-noise
  // at rest: 0.7 to 0.7; under noise: 0.416016 to 0.983998
  // 1 input, 1 output

pm.clarinet_ui  pm.clarinet_ui
  output.min:-0.000669005
  output.max:0.000654802
  output.measure:no-input
  // 0 input, 1 output

pm.clarinet_ui_MIDI  pm.clarinet_ui_MIDI
  output.min:-0.000221414
  output.max:0.000219836
  output.measure:no-input
  // 0 input, 1 output

pm.closeIns  pm.closeIns
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 3 outputs

pm.closeOuts  pm.closeOuts
  output.min:-0.999991
  output.max:0.999992
  output.measure:silence-and-noise
  // 3 inputs, 1 output

pm.djembe(freq:110, strikePosition:0.3, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.djembe(freq, strikePosition, strikeSharpness, gain, trigger)
  freq.min:20
  freq.max:20000
  freq.scale:log
  strikePosition.min:0
  strikePosition.max:1
  strikeSharpness.min:0.01
  strikeSharpness.max:5
  strikeSharpness.scale:log
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: strikePosition from 0 to 1
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeSharpness from 0.01 to 5
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 1
  // 0 input, 1 output

pm.djembeModel(freq:110)  pm.djembeModel(freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 5.595)
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.djembe_ui_MIDI  pm.djembe_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.elecGuitar(stringLength:0.9, pluckPosition:0.3, mute:0.8, gain:0.6, trigger:0)  pm.elecGuitar(stringLength, pluckPosition, mute, gain, trigger)
  pluckPosition.min:0
  pluckPosition.max:1
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.elecGuitarBridge  pm.elecGuitarBridge
  output.min:-1.94502
  output.max:1.93799
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.elecGuitarModel(length:0.9, pluckPosition:0.3, mute:0.8)  pm.elecGuitarModel(length, pluckPosition, mute, excitation)
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.elecGuitarModel/gate"))
  output.min:-3.85743
  output.max:3.96073
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.elecGuitarNuts  pm.elecGuitarNuts
  output.min:-1.95338
  output.max:1.98085
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.elecGuitar_ui_MIDI  pm.elecGuitar_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.endChain(b)  pm.endChain(b)
  b.nature:table
  b.example:(_, _, _ + 0.25)
  // CONSTANT OUTPUT: the output does not move from 0.25
  // 0 input, 1 output

pm.englishBell(strikePosition:0.4, strikeCutoff:2000, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.englishBell(strikePosition, strikeCutoff, strikeSharpness, gain, trigger)
  strikePosition.min:0
  strikePosition.max:6
  strikeCutoff.min:20
  strikeCutoff.max:20000
  strikeCutoff.scale:log
  strikeSharpness.min:0.01
  strikeSharpness.max:5
  strikeSharpness.scale:log
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeCutoff from 20 to 20000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeSharpness from 0.01 to 5
  // 0 input, 1 output

pm.englishBellModel(nModes:50, exPos:0, t60:30, t60DecayRatio:1, t60DecaySlope:3)  pm.englishBellModel(nModes, exPos, t60, t60DecayRatio, t60DecaySlope)
  exPos.min:0
  exPos.max:6
  t60.unit:s
  output.min:-26.269
  output.max:25.9051
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.englishBell_ui  pm.englishBell_ui
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.f2l(freq:440)  pm.f2l(freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: the output does not move from 0.772727
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

pm.fluteEmbouchure(pressure:0.5)  pm.fluteEmbouchure(pressure)
  output.min:-0.999992
  output.max:0.999992
  output.measure:silence-and-noise
  // at rest: -0.375 to 0; under noise: -0.999992 to 0.999992
  // 3 inputs, 3 outputs

pm.fluteFoot  pm.fluteFoot
  output.min:-1.6352
  output.max:1.6658
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.fluteHead  pm.fluteHead
  output.min:-1.94371
  output.max:1.9444
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.fluteJetTable  pm.fluteJetTable
  output.min:-0.3849
  output.max:0.3849
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.fluteModel(tubeLength:0.9, mouthPosition:0.4, pressure:0.6)  pm.fluteModel(tubeLength, mouthPosition, pressure)
  tubeLength.min:0.01
  tubeLength.max:3
  tubeLength.scale:log
  mouthPosition.min:0
  mouthPosition.max:1
  pressure.min:0
  pressure.max:1
  output.min:2.38419e-07
  output.max:5.36442e-07
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: tubeLength from 0.01 to 3
  // 0 input, 1 output

pm.fluteModel_ui(pressure:0.4)  pm.fluteModel_ui(pressure)
  pressure.min:0
  pressure.max:1
  // CONSTANT OUTPUT: the output does not move from -2.89083e-06
  // 0 input, 1 output

pm.flute_ui  pm.flute_ui
  output.min:-0.00422586
  output.max:0.00422624
  output.measure:no-input
  // 0 input, 1 output

pm.flute_ui_MIDI  pm.flute_ui_MIDI
  output.min:-0.0112881
  output.max:0.0112892
  output.measure:no-input
  // 0 input, 1 output

pm.fof(fc:0.3, bw:440, sw:880, g:0.5)  pm.fof(fc, bw, sw, g)
  bw.unit:Hz
  sw.unit:Hz
  output.min:-0.0889861
  output.max:0.0927166
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.fofCycle(fc:0.3, bw:440, a:880, g:0.5, n:3)  pm.fofCycle(fc, bw, a, g, n)
  fc.unit:Hz
  bw.unit:Hz
  a.unit:Hz
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

pm.fofSH(fc:0.3, bw:440, a:880, g:0.5)  pm.fofSH(fc, bw, a, g)
  bw.unit:Hz
  a.unit:Hz
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

pm.fofSmooth(fc:0.3, bw:440, sw:880, g:0.5, tau:0.2)  pm.fofSmooth(fc, bw, sw, g, tau)
  fc.unit:Hz
  bw.unit:Hz
  sw.unit:Hz
  tau.unit:s
  output.min:-0.0889581
  output.max:0.0927
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.formantFilterBP(voiceType:0, vowel:0, nFormants:5, i:0, freq:200)  pm.formantFilterBP(voiceType, vowel, nFormants, i, freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-3.02734
  output.max:2.79846
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.formantFilterFofCycle(voiceType:1, vowel:1, nFormants:5, i:1, freq:200)  pm.formantFilterFofCycle(voiceType, vowel, nFormants, i, freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.formantFilterFofSmooth(voiceType:0, vowel:0, nFormants:5, i:0, freq:200)  pm.formantFilterFofSmooth(voiceType, vowel, nFormants, i, freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.122638
  output.max:0.126864
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.formantFilterbank(voiceType:0, vowel:0, formantGen, freq:200)  pm.formantFilterbank(voiceType, vowel, formantGen, freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  formantGen.nature:function
  formantGen.example:pm.formantFilterBP
  output.min:-3.44236
  output.max:3.23273
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.formantFilterbankBP(voiceType:0, vowel:0, freq:200)  pm.formantFilterbankBP(voiceType, vowel, freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-3.44236
  output.max:3.23273
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.formantFilterbankFofCycle(voiceType:1, vowel:1, freq:200)  pm.formantFilterbankFofCycle(voiceType, vowel, freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.formantFilterbankFofSmooth(voiceType:0, vowel:0, freq:200)  pm.formantFilterbankFofSmooth(voiceType, vowel, freq)
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-0.194193
  output.max:0.193256
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.formantValues  pm.formantValues
  // a set of definitions: f, g, bw

pm.frenchBell(strikePosition:0.4, strikeCutoff:2000, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.frenchBell(strikePosition, strikeCutoff, strikeSharpness, gain, trigger)
  strikePosition.min:0
  strikePosition.max:6
  strikeCutoff.min:20
  strikeCutoff.max:20000
  strikeCutoff.scale:log
  strikeSharpness.min:0.01
  strikeSharpness.max:5
  strikeSharpness.scale:log
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeCutoff from 20 to 20000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeSharpness from 0.01 to 5
  // 0 input, 1 output

pm.frenchBellModel(nModes:50, exPos:0, t60:30, t60DecayRatio:1, t60DecaySlope:3)  pm.frenchBellModel(nModes, exPos, t60, t60DecayRatio, t60DecaySlope)
  exPos.min:0
  exPos.max:6
  t60.unit:s
  output.min:-37.3355
  output.max:34.3056
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.frenchBell_ui  pm.frenchBell_ui
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.germanBell(strikePosition:0.4, strikeCutoff:2000, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.germanBell(strikePosition, strikeCutoff, strikeSharpness, gain, trigger)
  strikePosition.min:0
  strikePosition.max:6
  strikeCutoff.min:20
  strikeCutoff.max:20000
  strikeCutoff.scale:log
  strikeSharpness.min:0.01
  strikeSharpness.max:5
  strikeSharpness.scale:log
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeCutoff from 20 to 20000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeSharpness from 0.01 to 5
  // 0 input, 1 output

pm.germanBellModel(nModes:50, exPos:0, t60:30, t60DecayRatio:1, t60DecaySlope:2.5)  pm.germanBellModel(nModes, exPos, t60, t60DecayRatio, t60DecaySlope)
  exPos.min:0
  exPos.max:6
  t60.unit:s
  output.min:-33.5021
  output.max:32.8255
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.germanBell_ui  pm.germanBell_ui
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.guitar(stringLength:0.9, pluckPosition:0.25, gain:0.8, trigger:0)  pm.guitar(stringLength, pluckPosition, gain, trigger)
  pluckPosition.min:0
  pluckPosition.max:1
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 1
  // 0 input, 1 output

pm.guitarBody  pm.guitarBody
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.guitarBridge  pm.guitarBridge
  output.min:-1.90263
  output.max:1.90535
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.guitarModel(length:0.9, pluckPosition:0.25)  pm.guitarModel(length, pluckPosition, excitation)
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.guitarModel/gate"))
  output.min:-7.86199
  output.max:7.71136
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.guitarNuts  pm.guitarNuts
  output.min:-1.92324
  output.max:1.96358
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.guitar_ui_MIDI  pm.guitar_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.idealString(length:0.9, pluckPosition:0.2)  pm.idealString(length, pluckPosition, excitation)
  pluckPosition.min:0.001
  pluckPosition.max:0.999
  pluckPosition.scale:log
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.idealString/gate"))
  output.min:-89.9772
  output.max:78.6056
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.impulseExcitation(trigger:0)  pm.impulseExcitation(trigger)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.in  pm.in(x)
  x.nature:signal
  x.example:A : in(x) : B
  output.min:-1.99777
  output.max:1.99376
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.inLeftWave  pm.inLeftWave(x)
  x.nature:signal
  output.min:-1.99777
  output.max:1.99376
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.inRightWave  pm.inRightWave(x)
  x.nature:signal
  output.min:-1.99518
  output.max:1.99144
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.ks(length:0.9, damping:0.3)  pm.ks(length, damping, excitation)
  damping.min:0
  damping.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.ks/gate"))
  output.min:-11.1581
  output.max:10.8034
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.ksReflexionFilter  pm.ksReflexionFilter
  output.min:-0.995684
  output.max:0.998017
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.ks_ui_MIDI  pm.ks_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.l2f(length:0.75)  pm.l2f(length)
  // CONSTANT OUTPUT: the output does not move from 453.333
  // 0 input, 1 output

pm.l2s(l:1.2)  pm.l2s(l)
  // CONSTANT OUTPUT: the output does not move from 169.412
  // 0 input, 1 output

pm.lStringRigidTermination  pm.lStringRigidTermination
  output.min:-1.99767
  output.max:1.99545
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.lTermination(a, b)  pm.lTermination(a, b)
  a.nature:function
  a.example:*(-1)
  b.nature:expression
  b.example:pm.basicBlock
  output.min:-1.99767
  output.max:1.99545
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs
  // b is not an input: the compiler accepts it only in the form of its example

pm.marimba(freq:220, strikePosition:0.4, strikeCutoff:1, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.marimba(freq, strikePosition, strikeCutoff, strikeSharpness, gain, trigger)
  freq.min:50
  freq.max:1000
  strikePosition.min:0
  strikePosition.max:4
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: freq from 50 to 1000
  // 0 input, 1 output

pm.marimbaBarModel(freq:220, exPos:2, t60:0.1, t60DecayRatio:1, t60DecaySlope:5)  pm.marimbaBarModel(freq, exPos, t60, t60DecayRatio, t60DecaySlope)
  freq.min:20
  freq.max:20000
  freq.scale:log
  exPos.min:0
  exPos.max:4
  t60.unit:s
  output.min:-1.24064
  output.max:1.2888
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.marimbaModel(freq:220, exPos:2)  pm.marimbaModel(freq, exPos)
  freq.min:20
  freq.max:20000
  freq.scale:log
  exPos.min:0
  exPos.max:4
  output.min:-1.22769
  output.max:1.2032
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.marimbaResTube(tubeLength:0.5)  pm.marimbaResTube(tubeLength, excitation)
  excitation.nature:signal
  output.min:-1.81824
  output.max:2.24624
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.marimba_ui_MIDI  pm.marimba_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.maxGenderFreq  pm.maxGenderFreq
  output.min:523.25
  output.max:1046.5
  output.measure:no-input
  // 0 input, 2 outputs

pm.maxLength  pm.maxLength
  // CONSTANT OUTPUT: the output does not move from 3
  // 0 input, 1 output

pm.minGenderFreq  pm.minGenderFreq
  output.min:82.41
  output.max:174.61
  output.measure:no-input
  // 0 input, 2 outputs

pm.modalModel(n:3, modeFreqs, modeRes, modeGains)  pm.modalModel(n, modeFreqs, modeRes, modeGains)
  modeFreqs.nature:table
  modeFreqs.example:(440,660,880)
  modeRes.nature:table
  modeRes.example:(0.5,0.4,0.3)
  modeGains.nature:table
  modeGains.example:(0.8,0.6,0.4)
  output.min:-123.791
  output.max:140.72
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.modeFilter(freq:440, t60:1.5, gain:0.8)  pm.modeFilter(freq, t60, gain)
  freq.min:20
  freq.max:20000
  freq.scale:log
  t60.unit:s
  gain.min:0
  gain.max:1
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 140.9)
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.modeInterpRes(nModes:20)  pm.modeInterpRes(nModes, x, y)
  x.nature:signal
  y.nature:signal
  // OUTPUT NOT FINITE: NaN or infinity on noise (191872 samples out of 191872)
  // 3 inputs, 1 output

pm.modularInterpBody(nModes:20, shape:1.0, scale:1.5)  pm.modularInterpBody(nModes, shape, scale)
  output.min:-5.5036
  output.max:5.72696
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.modularInterpInstr(stringLength:0.9, pluckPosition:0.3, shape:1.0, scale:1.5, gain:0.8, tapBody:0, triggerString:0)  pm.modularInterpInstr(stringLength, pluckPosition, shape, scale, gain, tapBody, triggerString)
  pluckPosition.min:0
  pluckPosition.max:1
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: gain from 0 to 1
  // 0 input, 1 output

pm.modularInterpInstr_ui_MIDI  pm.modularInterpInstr_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.modularInterpStringModel(stringLength:0.9, pluckPosition:0.3, shape:1.0, scale:1.5)  pm.modularInterpStringModel(stringLength, pluckPosition, shape, scale, bodyExcitation, stringExcitation)
  pluckPosition.min:0
  pluckPosition.max:1
  bodyExcitation.nature:signal
  bodyExcitation.example:pm.impulseExcitation(button("pm.modularInterpStringModel/body"))
  stringExcitation.nature:signal
  stringExcitation.example:pm.impulseExcitation(button("pm.modularInterpStringModel/string"))
  output.min:-8.21526
  output.max:8.11817
  output.measure:silence-and-noise
  // 2 inputs, 1 output

pm.nylonGuitar(stringLength:0.9, pluckPosition:0.25, gain:0.8, trigger:0)  pm.nylonGuitar(stringLength, pluckPosition, gain, trigger)
  pluckPosition.min:0
  pluckPosition.max:1
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.nylonGuitarModel(length:0.9, pluckPosition:0.25)  pm.nylonGuitarModel(length, pluckPosition, excitation)
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.nylonGuitarModel/gate"))
  output.min:-5.03967
  output.max:4.75981
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.nylonGuitar_ui_MIDI  pm.nylonGuitar_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.nylonString(length:0.8, pluckPosition:0.3)  pm.nylonString(length, pluckPosition, excitation)
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(ba.pulse(64))
  output.min:-1.85844
  output.max:1.92265
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.openString(length:0.8, stiffness:0.5, pluckPosition:0.2)  pm.openString(length, stiffness, pluckPosition, excitation)
  stiffness.min:0
  stiffness.max:1
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(ba.pulse(64))
  output.min:-2.06238
  output.max:2.0334
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.openStringPick(length:0.8, stiffness:0.4, pluckPosition:0.3)  pm.openStringPick(length, stiffness, pluckPosition, excitation)
  stiffness.min:0
  stiffness.max:1
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.openStringPick/gate"))
  output.min:-3.56699
  output.max:3.57079
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.openStringPickDown(length:0.8, stiffness:0.4, pluckPosition:0.6, pickupPosition:0.5)  pm.openStringPickDown(length, stiffness, pluckPosition, pickupPosition, excitation)
  stiffness.min:0
  stiffness.max:1
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.openStringPickDown/gate"))
  output.min:-3.94038
  output.max:3.5734
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.openStringPickUp(length:0.8, stiffness:0.4, pluckPosition:0.6, pickupPosition:0.7)  pm.openStringPickUp(length, stiffness, pluckPosition, pickupPosition, excitation)
  stiffness.min:0
  stiffness.max:1
  pluckPosition.min:0
  pluckPosition.max:1
  pickupPosition.min:0
  pickupPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(button("pm.openStringPickUp/gate"))
  output.min:-3.47771
  output.max:3.48717
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: pluckPosition from 0 to 1
  // 4 inputs, 3 outputs

pm.openTube(maxLength, length:0.9)  pm.openTube(maxLength, length)
  maxLength.nature:expression
  maxLength.example:pm.maxLength
  output.min:-1.32662
  output.max:1.35801
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs
  // maxLength is not an input: the compiler accepts it only in the form of its example

pm.out(s:0.3)  pm.out(x, y, s)
  x.nature:signal
  y.nature:signal
  output.min:-1.69553
  output.max:2.29259
  output.measure:silence-and-noise
  // at rest: 0 to 0.3; under noise: -1.69553 to 2.29259
  // 2 inputs, 3 outputs

pm.outLeftWave(s:0.3)  pm.outLeftWave(x, y, s)
  x.nature:signal
  y.nature:signal
  output.min:-0.999999
  output.max:1.29995
  output.measure:silence-and-noise
  // at rest: 0 to 0.3; under noise: -0.999999 to 1.29995
  // 2 inputs, 3 outputs

pm.outRightWave(s:0.3)  pm.outRightWave(x, y, s)
  x.nature:signal
  y.nature:signal
  output.min:-0.999999
  output.max:1.29998
  output.measure:silence-and-noise
  // at rest: 0 to 0.3; under noise: -0.999999 to 1.29998
  // 2 inputs, 3 outputs

pm.pluckString(stringLength:0.9, cutoff:1, maxFreq:1, sharpness:1, gain:0.6, trigger:0)  pm.pluckString(stringLength, cutoff, maxFreq, sharpness, gain, trigger)
  sharpness.min:0
  sharpness.max:1
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: sharpness from 0 to 1
  // 0 input, 1 output

pm.rStringRigidTermination  pm.rStringRigidTermination
  output.min:-1.99659
  output.max:1.99858
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.rTermination(b, c)  pm.rTermination(b, c)
  b.nature:expression
  b.example:pm.basicBlock
  c.nature:function
  c.example:*(-1)
  output.min:-1.99659
  output.max:1.99858
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs
  // b is not an input: the compiler accepts it only in the form of its example

pm.reedTable(offset:0.4, slope:0.2)  pm.reedTable(offset, slope)
  output.min:0.200002
  output.max:0.599989
  output.measure:silence-and-noise
  // at rest: 0.4 to 0.4; under noise: 0.200002 to 0.599989
  // 1 input, 1 output

pm.rk_solve(ts:0, ks:1, ni:1, h:1.0/ma.SR, eq, iv:1)  pm.rk_solve(ts, ks, ni, h, eq, iv)
  eq.nature:table
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

pm.rk_solve_1(h:1.0/ma.SR, eq, iv:1)  pm.rk_solve_1(h, eq, iv)
  eq.nature:table
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

pm.rk_solve_2(h:1.0/ma.SR, eq, iv:1)  pm.rk_solve_2(h, eq, iv)
  eq.nature:table
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

pm.rk_solve_3(h:1.0/ma.SR, eq, iv:1)  pm.rk_solve_3(h, eq, iv)
  eq.nature:table
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

pm.rk_solve_4(h:1.0/ma.SR, eq, iv:1)  pm.rk_solve_4(h, eq, iv)
  eq.nature:table
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

pm.russianBell(strikePosition:0.4, strikeCutoff:2000, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.russianBell(strikePosition, strikeCutoff, strikeSharpness, gain, trigger)
  strikePosition.min:0
  strikePosition.max:6
  strikeCutoff.min:20
  strikeCutoff.max:20000
  strikeCutoff.scale:log
  strikeSharpness.min:0.01
  strikeSharpness.max:5
  strikeSharpness.scale:log
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeCutoff from 20 to 20000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeSharpness from 0.01 to 5
  // 0 input, 1 output

pm.russianBellModel(nModes:50, exPos:0, t60:30, t60DecayRatio:1, t60DecaySlope:3)  pm.russianBellModel(nModes, exPos, t60, t60DecayRatio, t60DecaySlope)
  exPos.min:0
  exPos.max:6
  t60.unit:s
  // OUTPUT WITHOUT RANGE: still rising after 5 s on noise (peak 29.5)
  // 1 input, 1 output

pm.russianBell_ui  pm.russianBell_ui
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.skirtWidthMultiplier(vowel:0, freq:220, gender:0)  pm.skirtWidthMultiplier(vowel, freq, gender)
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: the output does not move from 3.80898
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

pm.speedOfSound  pm.speedOfSound
  // CONSTANT OUTPUT: the output does not move from 340
  // 0 input, 1 output

pm.standardBell(strikePosition:0.4, strikeCutoff:2000, strikeSharpness:0.5, gain:0.8, trigger:0)  pm.standardBell(strikePosition, strikeCutoff, strikeSharpness, gain, trigger)
  strikePosition.min:0
  strikePosition.max:6
  strikeCutoff.min:20
  strikeCutoff.max:20000
  strikeCutoff.scale:log
  strikeSharpness.min:0.01
  strikeSharpness.max:5
  strikeSharpness.scale:log
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeCutoff from 20 to 20000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: strikeSharpness from 0.01 to 5
  // 0 input, 1 output

pm.standardBellModel(nModes:50, exPos:0, t60:30, t60DecayRatio:1, t60DecaySlope:2.5)  pm.standardBellModel(nModes, exPos, t60, t60DecayRatio, t60DecaySlope)
  exPos.min:0
  exPos.max:6
  t60.unit:s
  output.min:-31.0763
  output.max:33.2606
  output.measure:silence-and-noise
  // 1 input, 1 output

pm.standardBell_ui  pm.standardBell_ui
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.steelString(length:0.8, pluckPosition:0.3)  pm.steelString(length, pluckPosition, excitation)
  pluckPosition.min:0
  pluckPosition.max:1
  excitation.nature:signal
  excitation.example:pm.impulseExcitation(ba.pulse(64))
  output.min:-2.24022
  output.max:2.27418
  output.measure:silence-and-noise
  // 4 inputs, 3 outputs

pm.strike(exPos:0.4, sharpness:0.5, gain:0.8, trigger:0)  pm.strike(exPos, sharpness, gain, trigger)
  sharpness.min:0
  sharpness.max:1
  gain.min:0
  gain.max:2
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 0 input, 1 output

pm.strikeModel(HPcutoff:200, LPcutoff:4000, sharpness:0.5, gain:0.8, trigger:0)  pm.strikeModel(HPcutoff, LPcutoff, sharpness, gain, trigger)
  sharpness.min:0
  sharpness.max:1
  gain.min:0
  gain.max:2
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: gain from 0 to 2
  // 0 input, 1 output

pm.stringSegment(maxLength:1.0, length:0.5)  pm.stringSegment(maxLength, length)
  output.min:-1.28518
  output.max:1.28362
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.terminations(a, b, c)  pm.terminations(a, b, c)
  a.nature:function
  a.example:*(-1)
  b.nature:expression
  b.example:pm.basicBlock
  c.nature:function
  c.example:*(-1)
  output.min:-693.473
  output.max:693.516
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs
  // b is not an input: the compiler accepts it only in the form of its example

pm.violinBody  pm.violinBody
  output.min:-0.999992
  output.max:0.999992
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.violinBow(bowPressure:0.4, bowVelocity:0.05)  pm.violinBow(bowPressure, bowVelocity)
  bowPressure.min:0
  bowPressure.max:1
  bowVelocity.min:0
  bowVelocity.max:1
  output.min:-0.999991
  output.max:1.04951
  output.measure:silence-and-noise
  // at rest: 0 to 0.05; under noise: -0.999991 to 1.04951
  // 3 inputs, 3 outputs

pm.violinBowTable(bowPressure:0.4)  pm.violinBowTable(bowPressure)
  bowPressure.min:0
  bowPressure.max:1
  output.min:0.00337147
  output.max:1
  output.measure:silence-and-noise
  // at rest: 1 to 1; under noise: 0.00337147 to 1
  // 1 input, 1 output

pm.violinBowedString(stringLength:0.82, bowPressure:0.35, bowVelocity:0.2, bowPosition:0.15)  pm.violinBowedString(stringLength, bowPressure, bowVelocity, bowPosition)
  bowPressure.min:0
  bowPressure.max:1
  bowVelocity.min:0
  bowVelocity.max:1
  bowPosition.min:0
  bowPosition.max:1
  output.min:-1.10716
  output.max:1.13792
  output.measure:silence-and-noise
  // at rest: 0 to 0.0428312; under noise: -1.10716 to 1.13792
  // 3 inputs, 3 outputs

pm.violinBridge  pm.violinBridge
  output.min:-1.88929
  output.max:1.90059
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.violinModel(stringLength:0.82, bowPressure:0.4, bowVelocity:0.05, bowPosition:0.15)  pm.violinModel(stringLength, bowPressure, bowVelocity, bowPosition)
  stringLength.min:0
  stringLength.max:2
  bowPressure.min:0
  bowPressure.max:1
  bowVelocity.min:0
  bowVelocity.max:1
  bowPosition.min:0
  bowPosition.max:1
  output.min:-0.164713
  output.max:0.191226
  output.measure:no-input
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: stringLength from 0 to 2
  // 0 input, 1 output

pm.violinNuts  pm.violinNuts
  output.min:-1.93928
  output.max:1.97342
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.violin_ui  pm.violin_ui
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.violin_ui_MIDI  pm.violin_ui_MIDI
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output

pm.vocalEffort(freq:440, gender:0)  pm.vocalEffort(freq, gender)
  freq.min:20
  freq.max:20000
  freq.scale:log
  output.min:-2.85331
  output.max:2.85317
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 1 input, 1 output

pm.voiceGender(voiceType:0)  pm.voiceGender(voiceType)
  // CONSTANT OUTPUT: the output does not move from 1
  // 0 input, 1 output

pm.wBell(opening:0.4)  pm.wBell(opening)
  opening.min:0
  opening.max:1
  output.min:-1.85181
  output.max:1.92286
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.waveguide(nMax:512, n:32)  pm.waveguide(nMax, n)
  n.unit:samples
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.waveguideFd(nMax:512, n:32)  pm.waveguideFd(nMax, n)
  n.unit:samples
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.waveguideFd2(nMax:512, n:32)  pm.waveguideFd2(nMax, n)
  n.unit:samples
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.waveguideFd4(nMax:512, n:32)  pm.waveguideFd4(nMax, n)
  n.unit:samples
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

pm.waveguideUd(nMax:512, n:32)  pm.waveguideUd(nMax, n)
  n.unit:samples
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs

qu.dimin  qu.dimin
  output.min:1
  output.max:1.7818
  output.measure:no-input
  // 0 input, 8 outputs

qu.dodeca  qu.dodeca
  output.min:1
  output.max:1.88775
  output.measure:no-input
  // 0 input, 12 outputs

qu.dorian  qu.dorian
  output.min:1
  output.max:1.7818
  output.measure:no-input
  // 0 input, 7 outputs

qu.eolian  qu.eolian
  output.min:1
  output.max:1.7818
  output.measure:no-input
  // 0 input, 7 outputs

qu.ionian  qu.ionian
  output.min:1
  output.max:1.88775
  output.measure:no-input
  // 0 input, 7 outputs

qu.kumoi  qu.kumoi
  output.min:1
  output.max:1.6
  output.measure:no-input
  // 0 input, 5 outputs

qu.locrian  qu.locrian
  output.min:1
  output.max:1.7818
  output.measure:no-input
  // 0 input, 7 outputs

qu.lydian  qu.lydian
  output.min:1
  output.max:1.88775
  output.measure:no-input
  // 0 input, 7 outputs

qu.mixo  qu.mixo
  output.min:1
  output.max:1.7818
  output.measure:no-input
  // 0 input, 7 outputs

qu.natural  qu.natural
  output.min:1
  output.max:1.875
  output.measure:no-input
  // 0 input, 7 outputs

qu.penta  qu.penta
  output.min:1
  output.max:1.7818
  output.measure:no-input
  // 0 input, 5 outputs

qu.pentanat  qu.pentanat
  output.min:1
  output.max:1.77778
  output.measure:no-input
  // 0 input, 5 outputs

qu.phrygian  qu.phrygian
  output.min:1
  output.max:1.7818
  output.measure:no-input
  // 0 input, 7 outputs

qu.quantize(rf:440, nl)  qu.quantize(rf, nl, x)
  nl.nature:table
  nl.example:qu.ionian
  x.nature:signal
  // OUTPUT NOT FINITE: NaN or infinity on noise (95727 samples out of 191872)
  // 1 input, 1 output

qu.quantizeSmoothed(rf:440, nl)  qu.quantizeSmoothed(rf, nl, x)
  nl.nature:table
  nl.example:qu.ionian
  x.nature:signal
  // OUTPUT NOT MEASURED: the module stops dead: float unrepresentable in integer range
  // 1 input, 1 output

re.dattorro_rev(pre_delay:200, bw:0.5, i_diff1:0.7, i_diff2:0.6, decay:0.5, d_diff1:0.7, d_diff2:0.5, damping:0.2)  re.dattorro_rev(pre_delay, bw, i_diff1, i_diff2, decay, d_diff1, d_diff2, damping)
  pre_delay.unit:samples
  bw.min:0
  bw.max:1
  i_diff1.min:0
  i_diff1.max:1
  decay.min:0
  decay.max:1
  d_diff1.min:0
  d_diff1.max:1
  damping.min:0
  damping.max:1
  output.min:-1.04228
  output.max:1.04309
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: damping from 0 to 1
  // 2 inputs, 2 outputs

re.dattorro_rev_default  re.dattorro_rev_default
  output.min:-1.87544
  output.max:1.8677
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

re.fdnrev0(MAXDELAY:4096, delays, BBSO:1, freqs, durs, loopgainmax:0.8, nonl:0.0)  re.fdnrev0(MAXDELAY, delays, BBSO, freqs, durs, loopgainmax, nonl)
  loopgainmax.min:0
  loopgainmax.max:1
  delays.nature:table
  delays.example:(149, 211, 263, 293)
  freqs.nature:table
  freqs.example:(800, 4000)
  durs.nature:table
  durs.example:(2.5, 2.0, 1.5)
  output.min:-4.33698
  output.max:3.82496
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

re.greyhole(dt:2.0, damp:0.3, size:1.0, early_diff:0.6, feedback:0.5, mod_depth:0.4, mod_freq:0.2)  re.greyhole(dt, damp, size, early_diff, feedback, mod_depth, mod_freq)
  dt.unit:s
  damp.min:0
  damp.max:1
  size.min:0.5
  size.max:3
  early_diff.min:0
  early_diff.max:1
  feedback.min:0
  feedback.max:1
  mod_depth.min:0
  mod_depth.max:1
  mod_freq.min:0
  mod_freq.max:10
  output.min:-1.98641
  output.max:2.35027
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

re.jcrev  re.jcrev
  output.min:-0.733062
  output.max:0.733062
  output.measure:silence-and-noise
  // 1 input, 4 outputs

re.jpverb(t60:3.0, damp:0.2, size:1.0, early_diff:0.8, mod_depth:0.3, mod_freq:0.4, low:0.9, mid:0.8, high:0.7, low_cutoff:500, high_cutoff:4000)  re.jpverb(t60, damp, size, early_diff, mod_depth, mod_freq, low, mid, high, low_cutoff, high_cutoff)
  t60.unit:s
  t60.min:0.1
  t60.max:60
  t60.scale:log
  damp.min:0
  damp.max:1
  size.min:0.5
  size.max:5
  early_diff.min:0
  early_diff.max:1
  mod_depth.min:0
  mod_depth.max:1
  mod_freq.min:0
  mod_freq.max:10
  low.min:0
  low.max:1
  mid.min:0
  mid.max:1
  high.min:0
  high.max:1
  low_cutoff.min:100
  low_cutoff.max:6000
  high_cutoff.min:1000
  high_cutoff.max:10000
  output.min:-2.35883
  output.max:2.46746
  output.measure:silence-and-noise
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: low_cutoff from 100 to 6000
  // BOUNDS FROM INTERFACE, from the slider the libraries put on it: high_cutoff from 1000 to 10000
  // 2 inputs, 2 outputs

re.kb_rom_rev1(rt:0.7, damp:0.3)  re.kb_rom_rev1(rt, damp)
  rt.min:0
  rt.max:1
  damp.min:0
  damp.max:1
  output.min:-3.4554
  output.max:3.28503
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

re.mono_freeverb(fb1:0.7, fb2:0.5, damp:0.3, spread:30)  re.mono_freeverb(fb1, fb2, damp, spread)
  fb1.min:0
  fb1.max:1
  fb2.min:0
  fb2.max:1
  damp.min:0
  damp.max:1
  output.min:-7.97101
  output.max:9.04415
  output.measure:silence-and-noise
  // 1 input, 1 output

re.satrev  re.satrev
  output.min:-2.6707
  output.max:2.6707
  output.measure:silence-and-noise
  // 1 input, 2 outputs

re.springreverb(dwell_aux:0.5, blend_aux:0.5, tone_aux:0.5, tension_aux:0.5, springs:1)  re.springreverb(dwell_aux, blend_aux, tone_aux, tension_aux, springs)
  dwell_aux.min:0
  dwell_aux.max:1
  blend_aux.min:0
  blend_aux.max:1
  tone_aux.min:0
  tone_aux.max:1
  tension_aux.min:0
  tension_aux.max:1
  output.min:-1.26587
  output.max:1.24943
  output.measure:silence-and-noise
  // 1 input, 1 output

re.stereo_freeverb(fb1:0.7, fb2:0.5, damp:0.3, spread:30)  re.stereo_freeverb(fb1, fb2, damp, spread)
  fb1.min:0
  fb1.max:1
  fb2.min:0
  fb2.max:1
  damp.min:0
  damp.max:1
  output.min:-12.8978
  output.max:11.9889
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

re.vital_rev(_prelow:0.2, _prehigh:0.8, _lowcutoff:0.5, _highcutoff:0.7, _lowgain:0.4, _highgain:0.6, _chorus_amt:0.3, _chorus_freq:0.2, _predelay:0.1, _time:0.7, _size:0.5, _mix:0.4)  re.vital_rev(_prelow, _prehigh, _lowcutoff, _highcutoff, _lowgain, _highgain, _chorus_amt, _chorus_freq, _predelay, _time, _size, _mix)
  output.min:-1.24935
  output.max:1.26475
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

re.zita_distrib2(N:8)  re.zita_distrib2(N)
  output.min:-0.999999
  output.max:0.999999
  output.measure:silence-and-noise
  // 2 inputs, 8 outputs

re.zita_in_delay(rdel:60)  re.zita_in_delay(rdel)
  rdel.unit:ms
  output.min:-0.3
  output.max:0.299993
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

re.zita_rev1_ambi(rgxyz:0.0, rdel:25, f1:200, f2:2000, t60dc:3.0, t60m:2.0, fsmax:48000)  re.zita_rev1_ambi(rgxyz, rdel, f1, f2, t60dc, t60m, fsmax)
  rdel.unit:ms
  t60dc.unit:s
  t60m.unit:s
  output.min:-1.94795
  output.max:1.84488
  output.measure:silence-and-noise
  // 2 inputs, 4 outputs

re.zita_rev1_stereo(rdel:20, f1:200, f2:2000, t60dc:3.0, t60m:2.0, fsmax:48000)  re.zita_rev1_stereo(rdel, f1, f2, t60dc, t60m, fsmax)
  rdel.unit:ms
  t60dc.unit:s
  t60m.unit:s
  output.min:-1.21888
  output.max:1.17151
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

re.zita_rev_fdn(f1:200, f2:2000, t60dc:3.0, t60m:2.0, fsmax:48000)  re.zita_rev_fdn(f1, f2, t60dc, t60m, fsmax)
  f1.unit:Hz
  f2.unit:Hz
  t60dc.unit:s
  t60m.unit:s
  fsmax.unit:Hz
  output.min:-7.83588
  output.max:7.7346
  output.measure:silence-and-noise
  // 8 inputs, 8 outputs

rm.RMS(n:64)  rm.RMS(n)
  n.unit:samples
  output.min:0
  output.max:0.704422
  output.measure:silence-and-noise
  // 1 input, 1 output

rm.botReduce(op, n:4)  rm.botReduce(op, n)
  op.nature:function
  op.example:+
  output.min:-3.89329
  output.max:3.88647
  output.measure:silence-and-noise
  // 4 inputs, 1 output
  // n cannot be adjusted live: the compiler demands a constant in this place

rm.maxn(n:64)  rm.maxn(n)
  n.unit:samples
  output.min:0
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

rm.mean(n:64)  rm.mean(n)
  n.unit:samples
  output.min:-0.223884
  output.max:0.229145
  output.measure:silence-and-noise
  // 1 input, 1 output

rm.minn(n:64)  rm.minn(n)
  n.unit:samples
  output.min:-0.999992
  output.max:0
  output.measure:silence-and-noise
  // 1 input, 1 output

rm.parReduce(op, N:4)  rm.parReduce(op, N)
  op.nature:function
  op.example:+
  output.min:-3.89329
  output.max:3.88647
  output.measure:silence-and-noise
  // 4 inputs, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

rm.reduce(op, n:4)  rm.reduce(op, n, x)
  op.nature:function
  op.example:max
  x.nature:signal
  output.min:-0.902781
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

rm.reducemap(op, foo, n:4)  rm.reducemap(op, foo, n, x)
  op.nature:function
  op.example:+
  foo.nature:function
  foo.example:/(4)
  x.nature:signal
  output.min:-0.943986
  output.max:0.944227
  output.measure:silence-and-noise
  // 1 input, 1 output

rm.sumn(n:64)  rm.sumn(n)
  n.unit:samples
  output.min:-14.3286
  output.max:14.6653
  output.measure:silence-and-noise
  // 1 input, 1 output

rm.topReduce(op, N:4)  rm.topReduce(op, N)
  op.nature:function
  op.example:+
  output.min:-3.89329
  output.max:3.88647
  output.measure:silence-and-noise
  // 4 inputs, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

ro.bitonicSort(N:4)  ro.bitonicSort(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ro.bitonicSortIdx(N:4)  ro.bitonicSortIdx(N)
  output.min:0
  output.max:3
  output.measure:silence-and-noise
  // at rest: 0 to 3; under noise: 0 to 3
  // 4 inputs, 4 outputs

ro.bubbleSort(N:4)  ro.bubbleSort(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs
  // N cannot be adjusted live: the compiler demands a constant in this place

ro.butterfly(n:4)  ro.butterfly(n)
  output.min:-1.99642
  output.max:1.99885
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ro.cross(n:3)  ro.cross(n)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs
  // n cannot be adjusted live: the compiler demands a constant in this place

ro.cross1n(N:3)  ro.cross1n(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ro.cross2  ro.cross2
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ro.crossNM(N:2, M:3)  ro.crossNM(N, M)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 5 inputs, 5 outputs

ro.crossn1(n:3)  ro.crossn1(n)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ro.crossnn(n:2)  ro.crossnn(n)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ro.hadamard(n:4)  ro.hadamard(n)
  output.min:-3.89329
  output.max:3.88647
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs

ro.interleave(row:2, col:2)  ro.interleave(row, col)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs
  // row cannot be adjusted live: the compiler demands a constant in this place
  // col cannot be adjusted live: the compiler demands a constant in this place

ro.recursivize(p, q)  ro.recursivize(p, q)
  p.nature:function
  p.example:*(0.5)
  q.nature:function
  q.example:*(0.3)
  output.min:-0.583816
  output.max:0.584066
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

si.block(n:1)  si.block(n)
  // 1 input, 0 output
  // n cannot be adjusted live: the compiler demands a constant in this place

si.bpar(N:3, f)  si.bpar(N, f)
  f.nature:function
  f.example:*(0.5)
  output.min:-0.499999
  output.max:0.499998
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs
  // N cannot be adjusted live: the compiler demands a constant in this place

si.bprod(N:2, f)  si.bprod(N, f)
  f.nature:function
  f.example:_
  output.min:-0.998224
  output.max:0.995531
  output.measure:silence-and-noise
  // 2 inputs, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

si.bsmooth(c:0.5)  si.bsmooth(c)
  // CONSTANT OUTPUT: the output does not move from 0.5
  // 0 input, 1 output

si.bsum(N:3, f)  si.bsum(N, f)
  f.nature:function
  f.example:*(0.5)
  output.min:-1.4768
  output.max:1.46144
  output.measure:silence-and-noise
  // 3 inputs, 1 output
  // N cannot be adjusted live: the compiler demands a constant in this place

si.bus(n:3)  si.bus(n)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 3 inputs, 3 outputs
  // n cannot be adjusted live: the compiler demands a constant in this place

si.cbus(N:2)  si.cbus(N)
  output.min:-0.999999
  output.max:0.999997
  output.measure:silence-and-noise
  // 4 inputs, 4 outputs
  // N cannot be adjusted live: the compiler demands a constant in this place

si.cconj  si.cconj
  output.min:-0.999991
  output.max:0.999999
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

si.cmul  si.cmul(r1, i1, r2, i2)
  r1.nature:signal
  r1.example:os.osc(110)
  i1.nature:signal
  i1.example:os.osc(220)
  r2.nature:signal
  r2.example:os.osc(330)
  i2.nature:signal
  i2.example:os.osc(440)
  output.min:-1.87359
  output.max:1.89536
  output.measure:silence-and-noise
  // 4 inputs, 2 outputs

si.dot(n:3)  si.dot(n)
  output.min:-2.53632
  output.max:2.71655
  output.measure:silence-and-noise
  // 6 inputs, 1 output

si.interpolate(i:0.5)  si.interpolate(i, x, y)
  i.min:0
  i.max:1
  x.nature:signal
  x.example:os.osc(220)
  y.nature:signal
  y.example:os.osc(440)
  output.min:-0.997763
  output.max:0.996294
  output.measure:silence-and-noise
  // 2 inputs, 1 output

si.lag_ud(up:0.05, dn:0.2)  si.lag_ud(up, dn)
  output.min:0
  output.max:0.353671
  output.measure:silence-and-noise
  // 1 input, 1 output

si.onePoleSwitching(att:0.05, rel:0.2)  si.onePoleSwitching(att, rel, x)
  att.min:0.001
  att.max:10
  att.scale:log
  rel.min:0.001
  rel.max:10
  rel.scale:log
  x.nature:signal
  output.min:0
  output.max:0.353671
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 1 input, 1 output

si.polySmooth(g:0, s:0.999, d:32)  si.polySmooth(g, s, d)
  output.min:-0.0451394
  output.max:0.0452867
  output.measure:silence-and-noise
  // 1 input, 1 output

si.repeat(n:3, FX)  si.repeat(n, FX)
  FX.nature:function
  FX.example:*(0.5)
  output.min:-0.874993
  output.max:0.874951
  output.measure:silence-and-noise
  // 1 input, 1 output
  // n cannot be adjusted live: the compiler demands a constant in this place

si.rev(n:32)  si.rev(n)
  n.unit:samples
  output.min:-0.999992
  output.max:0.999944
  output.measure:silence-and-noise
  // 1 input, 1 output

si.smoo  si.smoo
  output.min:-0.0430023
  output.max:0.0439364
  output.measure:silence-and-noise
  // 1 input, 1 output

si.smooth(s:0.9)  si.smooth(s)
  s.min:0
  s.max:1
  output.min:-0.497341
  output.max:0.561106
  output.measure:silence-and-noise
  // 1 input, 1 output

si.smoothAndH(t:0, s:0.999)  si.smoothAndH(t, s)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

si.smoothq(time:0.25, q:0.5)  si.smoothq(time, q, tar)
  q.min:0
  q.max:1
  tar.nature:signal
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 1 input, 1 output

si.vecOp(vectorsList, op)  si.vecOp(vectorsList, op)
  vectorsList.nature:table
  vectorsList.example:(v0, v1)
  op.nature:function
  op.example:+
  // NOT VERIFIABLE: the parameter's example relies on `v0`, defined nowhere else

so.loop(sf, part:0)  so.loop(sf, part)
  sf.nature:expression
  sf.example:"soundfile('sound[url:{'tests/assets/silence.wav'}]', 1)"
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // 0 input, 1 output
  // sf is not an input: the compiler accepts it only in the form of its example

so.loop_speed(sf, part:0, speed:1)  so.loop_speed(sf, part, speed)
  speed.min:0.01
  speed.max:20
  speed.scale:log
  sf.nature:expression
  sf.example:"soundfile('sound[url:{'tests/assets/silence.wav'}]', 1)"
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: speed from 0.01 to 20
  // 0 input, 1 output
  // sf is not an input: the compiler accepts it only in the form of its example

so.loop_speed_level(sf, part:0, speed:1, level:0.5)  so.loop_speed_level(sf, part, speed, level)
  speed.min:0.01
  speed.max:20
  speed.scale:log
  level.min:0
  level.max:2
  sf.nature:expression
  sf.example:"soundfile('sound[url:{'tests/assets/silence.wav'}]', 1)"
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: speed from 0.01 to 20
  // BOUNDS GUESSED, from the parameter name: level from 0 to 2
  // 0 input, 1 output
  // sf is not an input: the compiler accepts it only in the form of its example

so.sound  so.sound
  // a set of definitions: loop

sp.binauralFir(hL, hR)  sp.binauralFir(hL, hR)
  hL.nature:table
  hL.example:(0.9, 0.05, 0.02)
  hR.nature:table
  hR.example:(0.4, 0.3, 0.1)
  output.min:-0.962027
  output.max:0.967345
  output.measure:silence-and-noise
  // 1 input, 2 outputs

sp.binauralModel(az:45)  sp.binauralModel(az)
  output.min:-2.01827
  output.max:1.98214
  output.measure:silence-and-noise
  // 1 input, 2 outputs

sp.constantPowerPan(p:0.4)  sp.constantPowerPan(p, x, y)
  p.min:0
  p.max:1
  x.nature:signal
  y.nature:signal
  output.min:-0.572057
  output.max:0.572035
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

sp.panner(c:0.3)  sp.panner(c)
  c.min:0
  c.max:1
  output.min:-0.699994
  output.max:0.699961
  output.measure:silence-and-noise
  // 1 input, 2 outputs

sp.spat(n:4, a:0.25, d:0.5)  sp.spat(n, a, d)
  output.min:-0.749398
  output.max:0.749362
  output.measure:silence-and-noise
  // 1 input, 4 outputs

sp.spcap(N:4, alpha:2.0, th, theta_s:0.0)  sp.spcap(N, alpha, th, theta_s)
  alpha.min:1
  alpha.max:10
  th.nature:function
  th.example:spk_angle
  // NOT VERIFIABLE: the parameter's example relies on `spk_angle`, defined nowhere else

sp.spcap_ui(N:4)  sp.spcap_ui(N)
  output.min:-0.696917
  output.max:0.696884
  output.measure:silence-and-noise
  // 1 input, 4 outputs

sp.stereoize(p)  sp.stereoize(p)
  p.nature:function
  p.example:+
  output.min:-1.99553
  output.max:1.99259
  output.measure:silence-and-noise
  // 2 inputs, 2 outputs

sp.wfs(xref:0, yref:1, zref:0, speakersDist:0.5, nSources:1, nSpeakers:2, inProc, xs, ys, zs)  sp.wfs(xref, yref, zref, speakersDist, nSources, nSpeakers, inProc, xs, ys, zs)
  inProc.nature:function
  inProc.example:wfs_proc
  xs.nature:function
  xs.example:wfs_xs
  ys.nature:function
  ys.example:wfs_ys
  zs.nature:function
  zs.example:wfs_zs
  // NOT VERIFIABLE: the parameter's example relies on `wfs_zs`, defined nowhere else

sp.wfs_ui(xref:0, yref:1, zref:0, speakersDist:0.5, nSources:1, nSpeakers:2)  sp.wfs_ui(xref, yref, zref, speakersDist, nSources, nSpeakers)
  output.min:-1.10879
  output.max:1.09321
  output.measure:silence-and-noise
  // 1 input, 2 outputs

sy.additiveDrum(freq:180, freqRatio, gain, harmDec:0.4, att:0.01, rel:0.4, gate:0)  sy.additiveDrum(freq, freqRatio, gain, harmDec, att, rel, gate)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  harmDec.min:0
  harmDec.max:1
  att.min:0.001
  att.max:10
  att.scale:log
  rel.min:0.001
  rel.max:10
  rel.scale:log
  freqRatio.nature:table
  freqRatio.example:(1, 1.3, 2.4, 3.2)
  gain.nature:table
  gain.example:(1, 0.8, 0.6, 0.4)
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 0 input, 1 output

sy.clap(tone:1200, attack:0.01, decay:0.6, gate:0)  sy.clap(tone, attack, decay, gate)
  attack.unit:s
  attack.min:0.001
  attack.max:10
  attack.scale:log
  decay.unit:s
  decay.min:0.001
  decay.max:10
  decay.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: attack from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: decay from 0.001 to 10
  // 0 input, 1 output

sy.combString(freq:220, res:4, gate:0)  sy.combString(freq, res, gate)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

sy.dubDub(freq:220, ctFreq:800, q:2, gate:0)  sy.dubDub(freq, ctFreq, q, gate)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  ctFreq.min:20
  ctFreq.max:20000
  ctFreq.scale:log
  q.min:0.5
  q.max:50
  q.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: ctFreq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: q from 0.5 to 50
  // 0 input, 1 output

sy.fm(freqs, indices)  sy.fm(freqs, indices)
  freqs.nature:table
  freqs.example:(220, 440, 660)
  indices.nature:table
  indices.example:(1.5, 0.8)
  output.min:-0.999999
  output.max:0.999999
  output.measure:no-input
  // 0 input, 1 output

sy.hat(pitch:800, tone:5000, attack:0.005, decay:0.3, gate:0)  sy.hat(pitch, tone, attack, decay, gate)
  pitch.min:20
  pitch.max:20000
  pitch.scale:log
  attack.unit:s
  attack.min:0.001
  attack.max:10
  attack.scale:log
  decay.unit:s
  decay.min:0.001
  decay.max:10
  decay.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: pitch from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: attack from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: decay from 0.001 to 10
  // 0 input, 1 output

sy.kick(pitch:60, click:0.2, attack:0.01, decay:0.5, drive:3, gate:0)  sy.kick(pitch, click, attack, decay, drive, gate)
  pitch.unit:Hz
  pitch.min:20
  pitch.max:20000
  pitch.scale:log
  attack.unit:s
  attack.min:0.001
  attack.max:10
  attack.scale:log
  decay.unit:s
  decay.min:0.001
  decay.max:10
  decay.scale:log
  drive.min:1
  drive.max:10
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: pitch from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: attack from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: decay from 0.001 to 10
  // 0 input, 1 output

sy.popFilterDrum(freq:200, q:5, gate:0)  sy.popFilterDrum(freq, q, gate)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  q.min:0.5
  q.max:50
  q.scale:log
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: q from 0.5 to 50
  // 0 input, 1 output

sy.sawTrombone(freq:196, gain:0.6, gate:0)  sy.sawTrombone(freq, gain, gate)
  freq.unit:Hz
  freq.min:20
  freq.max:20000
  freq.scale:log
  gain.min:0
  gain.max:1
  // CONSTANT OUTPUT: nothing comes out with the starting values
  // BOUNDS GUESSED, from the parameter name: freq from 20 to 20000
  // 0 input, 1 output

ve.autowah(level:0.7)  ve.autowah(level, x)
  level.min:0
  level.max:2
  x.nature:signal
  output.min:-1.49681
  output.max:1.58815
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: level from 0 to 2
  // 1 input, 1 output

ve.bandpass2Matched(CF:1200, Q:2.0)  ve.bandpass2Matched(CF, Q, x)
  CF.unit:Hz
  CF.min:20
  CF.max:20000
  CF.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-0.452664
  output.max:0.486507
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: CF from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.biquad(a0:0.5, a1:-0.3, a2:0.2, b1:0.3, b2:0.2)  ve.biquad(x, a0, a1, a2, b1, b2)
  x.nature:signal
  output.min:-0.285153
  output.max:0.347487
  output.measure:silence-and-noise
  // at rest: 0.0266667 to 0.0266667; under noise: -0.285153 to 0.347487
  // 1 input, 1 output

ve.crybaby(wah:0.3)  ve.crybaby(wah)
  wah.min:0
  wah.max:1
  output.min:-1.88622
  output.max:1.918
  output.measure:silence-and-noise
  // 1 input, 1 output

ve.diodeLadder(normFreq:0.4, Q:4)  ve.diodeLadder(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-0.0677674
  output.max:0.0757033
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.highpass2Matched(CF:500, Q:0.707)  ve.highpass2Matched(CF, Q, x)
  CF.unit:Hz
  CF.min:20
  CF.max:20000
  CF.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-1.53165
  output.max:1.4327
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: CF from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.highshelf2Matched(G:1.5, CF:1500)  ve.highshelf2Matched(G, CF, x)
  CF.unit:Hz
  CF.min:20
  CF.max:20000
  CF.scale:log
  x.nature:signal
  output.min:-1.7457
  output.max:1.75358
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: CF from 20 to 20000
  // 1 input, 1 output

ve.klonCentaur(gain:0.5, treble:0.5, level:0.5)  ve.klonCentaur(gain, treble, level)
  gain.min:0
  gain.max:1
  treble.min:0
  treble.max:1
  level.min:0
  level.max:1
  output.min:-0.364313
  output.max:0.377383
  output.measure:silence-and-noise
  // at rest: -0.00177327 to 0.000889623; under noise: -0.364313 to 0.377383
  // 1 input, 1 output

ve.korg35HPF(normFreq:0.4, Q:3.5)  ve.korg35HPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-1.28287
  output.max:1.25971
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.korg35LPF(normFreq:0.35, Q:3.5)  ve.korg35LPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-0.209134
  output.max:0.233798
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.lowpass2Matched(CF:1000, Q:0.707)  ve.lowpass2Matched(CF, Q, x)
  CF.unit:Hz
  CF.min:20
  CF.max:20000
  CF.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-0.490055
  output.max:0.500832
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: CF from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.lowpassLadder4(k:2.0, CF:800)  ve.lowpassLadder4(k, CF, x)
  k.min:0
  k.max:4
  CF.unit:Hz
  CF.min:20
  CF.max:20000
  CF.scale:log
  x.nature:signal
  output.min:-0.225975
  output.max:0.256346
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: CF from 20 to 20000
  // 1 input, 1 output

ve.lowshelf2Matched(G:1.5, CF:500)  ve.lowshelf2Matched(G, CF, x)
  CF.unit:Hz
  CF.min:20
  CF.max:20000
  CF.scale:log
  x.nature:signal
  output.min:-1.14313
  output.max:1.20195
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: CF from 20 to 20000
  // 1 input, 1 output

ve.moogHalfLadder(normFreq:0.3, Q:4)  ve.moogHalfLadder(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-0.14357
  output.max:0.164818
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.moogLadder(normFreq:0.3, Q:4)  ve.moogLadder(normFreq, Q, x)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-0.0851752
  output.max:0.0973637
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.moog_vcf(res:0.5, fr:1000)  ve.moog_vcf(res, fr)
  res.min:0
  res.max:1
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-0.257784
  output.max:0.266029
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 1 input, 1 output

ve.moog_vcf_2b(res:0.4, fr:1200)  ve.moog_vcf_2b(res, fr)
  res.min:0
  res.max:1
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-0.308335
  output.max:0.379063
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 1 input, 1 output

ve.moog_vcf_2bn(res:0.5, fr:440)  ve.moog_vcf_2bn(res, fr)
  res.min:0
  res.max:1
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-0.180427
  output.max:0.207219
  output.measure:silence-and-noise
  // GUESSED: res:0.5, from the parameter name
  // GUESSED: fr:440, from the parameter name
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 1 input, 1 output

ve.oberheim(normFreq:0.4, Q:1.5)  ve.oberheim(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-1.39832
  output.max:1.32629
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 4 outputs

ve.oberheimBPF(normFreq:0.4, Q:1.5)  ve.oberheimBPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-0.30114
  output.max:0.310411
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.oberheimBSF(normFreq:0.4, Q:1.5)  ve.oberheimBSF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-1.16187
  output.max:1.14891
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.oberheimHPF(normFreq:0.4, Q:1.5)  ve.oberheimHPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-1.39832
  output.max:1.32629
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.oberheimLPF(normFreq:0.4, Q:1.5)  ve.oberheimLPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-0.303812
  output.max:0.326502
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.peaking2Matched(G:1.5, CF:1000, Q:2.0)  ve.peaking2Matched(G, CF, Q, x)
  CF.unit:Hz
  CF.min:20
  CF.max:20000
  CF.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-1.17675
  output.max:1.16946
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: CF from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.sallenKey2ndOrder(normFreq:0.3, Q:1.0)  ve.sallenKey2ndOrder(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-1.27329
  output.max:1.30313
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 3 outputs

ve.sallenKey2ndOrderBPF(normFreq:0.3, Q:1.5)  ve.sallenKey2ndOrderBPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-0.336865
  output.max:0.322962
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.sallenKey2ndOrderHPF(normFreq:0.3, Q:0.8)  ve.sallenKey2ndOrderHPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-1.30561
  output.max:1.30006
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.sallenKey2ndOrderLPF(normFreq:0.3, Q:0.8)  ve.sallenKey2ndOrderLPF(normFreq, Q)
  normFreq.min:0
  normFreq.max:1
  Q.min:0.5
  Q.max:50
  Q.scale:log
  output.min:-0.179343
  output.max:0.195879
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

ve.sallenKeyOnePole(normFreq:0.25)  ve.sallenKeyOnePole(normFreq)
  normFreq.min:0
  normFreq.max:1
  output.min:-1.16996
  output.max:1.16825
  output.measure:silence-and-noise
  // 1 input, 2 outputs

ve.sallenKeyOnePoleHPF(normFreq:0.25)  ve.sallenKeyOnePoleHPF(normFreq)
  normFreq.min:0
  normFreq.max:1
  output.min:-1.16996
  output.max:1.16825
  output.measure:silence-and-noise
  // 1 input, 1 output

ve.sallenKeyOnePoleLPF(normFreq:0.25)  ve.sallenKeyOnePoleLPF(normFreq)
  normFreq.min:0
  normFreq.max:1
  output.min:-0.195177
  output.max:0.18769
  output.measure:silence-and-noise
  // 1 input, 1 output

ve.vocoder(nBands:8, att:0.01, rel:0.1, BWRatio:1.0)  ve.vocoder(nBands, att, rel, BWRatio, source, excitation)
  att.unit:s
  att.min:0.001
  att.max:10
  att.scale:log
  rel.unit:s
  rel.min:0.001
  rel.max:10
  rel.scale:log
  BWRatio.min:0.1
  BWRatio.max:2
  source.nature:signal
  excitation.nature:signal
  output.min:-1.58593
  output.max:1.62871
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: att from 0.001 to 10
  // BOUNDS GUESSED, from the parameter name: rel from 0.001 to 10
  // 2 inputs, 1 output

ve.wah4(fr:800)  ve.wah4(fr)
  fr.unit:Hz
  fr.min:20
  fr.max:20000
  fr.scale:log
  output.min:-1.21852
  output.max:1.05028
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: fr from 20 to 20000
  // 1 input, 1 output

vl.version  vl.version
  output.min:2
  output.max:74
  output.measure:no-input
  // 0 input, 3 outputs

wa.allpass2(f0:1000, Q:1, dtune:0)  wa.allpass2(f0, Q, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-1.88835
  output.max:1.77466
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

wa.bandpass2(f0:1000, Q:1, dtune:0)  wa.bandpass2(f0, Q, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-0.555466
  output.max:0.589701
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

wa.highpass2(f0:1000, Q:0.707, dtune:0)  wa.highpass2(f0, Q, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-1.70501
  output.max:1.65077
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

wa.highshelf2(f0:2000, gain:-6, dtune:0)  wa.highshelf2(f0, gain, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  gain.unit:dB
  x.nature:signal
  output.min:-0.812178
  output.max:0.842963
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // 1 input, 1 output

wa.lowpass2(f0:1000, Q:0.707, dtune:0)  wa.lowpass2(f0, Q, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-0.600039
  output.max:0.639492
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

wa.lowshelf2(f0:500, gain:6, dtune:0)  wa.lowshelf2(f0, gain, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  gain.unit:dB
  x.nature:signal
  output.min:-1.27734
  output.max:1.37903
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // 1 input, 1 output

wa.notch2(f0:1000, Q:1, dtune:0)  wa.notch2(f0, Q, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-1.40246
  output.max:1.37302
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

wa.peaking2(f0:1000, gain:3, Q:1, dtune:0)  wa.peaking2(f0, gain, Q, dtune, x)
  f0.unit:Hz
  f0.min:20
  f0.max:20000
  f0.scale:log
  gain.unit:dB
  Q.min:0.5
  Q.max:50
  Q.scale:log
  x.nature:signal
  output.min:-1.19149
  output.max:1.18599
  output.measure:silence-and-noise
  // BOUNDS GUESSED, from the parameter name: f0 from 20 to 20000
  // BOUNDS GUESSED, from the parameter name: Q from 0.5 to 50
  // 1 input, 1 output

wd.builddown(A)  wd.builddown(A)
  A.nature:function
  A.example:vsrc : (branch : (res_leaf, probe))
  // NOT VERIFIABLE: the parameter's example relies on `vsrc`, defined nowhere else

wd.buildout(A)  wd.buildout(A)
  A.nature:function
  A.example:vsrc : (branch : (res_leaf, probe))
  // NOT VERIFIABLE: the parameter's example relies on `vsrc`, defined nowhere else

wd.buildtree  wd.buildtree(a1)
  a1.nature:signal
  a1.example:vsrc : (branch : (res_leaf, probe))
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(<A> : <B>) => builddown(A : B)~buildup(A : B) : buildout(A 

wd.buildup(A)  wd.buildup(A)
  A.nature:function
  A.example:vsrc : (branch : (res_leaf, probe))
  // NOT VERIFIABLE: the parameter's example relies on `vsrc`, defined nowhere else

wd.capacitor(i, R:1e-7)  wd.capacitor(i, R)
  R.min:2.2e-09
  R.max:1e-06
  R.scale:log
  i.nature:internal
  // BOUNDS FROM USAGE, the values the libraries pass to it: R from 2.2e-09 to 1e-06
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.capacitor_Iout(i, C:1e-6)  wd.capacitor_Iout(i, C)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.capacitor_Vout(i, R:2e-7)  wd.capacitor_Vout(i, R)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.genericNode(i, scatter, upRes)  wd.genericNode(i, scatter, upRes)
  i.nature:internal
  scatter.nature:function
  upRes.nature:function
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.genericNode_Iout(i, scatter, upRes)  wd.genericNode_Iout(i, scatter, upRes)
  i.nature:internal
  scatter.nature:function
  upRes.nature:function
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.genericNode_Vout(i, scatter, upRes)  wd.genericNode_Vout(i, scatter, upRes)
  i.nature:internal
  scatter.nature:function
  upRes.nature:function
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.getres(A)  wd.getres(A)
  A.nature:function
  A.example:branch : (res_leaf, probe)
  // NOT VERIFIABLE: the parameter's example relies on `branch`, defined nowhere else

wd.inductor(i, R:0.01)  wd.inductor(i, R)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.inductor_Iout(i, L:0.02)  wd.inductor_Iout(i, L)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.inductor_Vout(i, R:0.02)  wd.inductor_Vout(i, R)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.lambert(itr:6)  wd.lambert(z, itr)
  z.nature:signal
  z.example:n
  output.min:-0.999959
  output.max:0.567123
  output.measure:silence-and-noise
  // 1 input, 1 output

wd.omega  wd.omega(x)
  x.nature:signal
  output.min:0.279762
  output.max:1.0012
  output.measure:silence-and-noise
  // at rest: 0.570369 to 0.570369; under noise: 0.279762 to 1.0012
  // 1 input, 1 output

wd.parallel  wd.parallel
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(2) => R0 with { {cons[cons[BoxIdent[R0],BoxAbstr[BoxIdent[R

wd.parallel2Port  wd.parallel2Port
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(2) => R0 with { {cons[cons[BoxIdent[R0],BoxAbstr[BoxIdent[R

wd.parallelCurrent(i, jin:0.1)  wd.parallelCurrent(i, jin)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.parres(Ap)  wd.parres(Ap)
  Ap.nature:table
  Ap.example:(subtree_left, subtree_right)
  // NOT VERIFIABLE: the parameter's example relies on `subtree_left`, defined nowhere else

wd.resCurrent(i, R:2200, jin:0.15)  wd.resCurrent(i, R, jin)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.resVoltage(i, R:1000, ein:0.5)  wd.resVoltage(i, R, ein)
  R.min:1e-09
  R.max:47000
  R.scale:log
  ein.min:0
  ein.max:4.5
  i.nature:internal
  // BOUNDS FROM USAGE, the values the libraries pass to it: R from 1e-09 to 47000
  // BOUNDS FROM USAGE, the values the libraries pass to it: ein from 0 to 4.5
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.resVoltage_Vout(i, R:1500, ein:0.3)  wd.resVoltage_Vout(i, R, ein)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.resistor(i, R:1000)  wd.resistor(i, R)
  R.min:560
  R.max:27000
  i.nature:internal
  // BOUNDS FROM USAGE, the values the libraries pass to it: R from 560 to 27000
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.resistor_Iout(i, R:1000)  wd.resistor_Iout(i, R)
  R.min:1000
  R.max:47000
  i.nature:internal
  // BOUNDS FROM USAGE, the values the libraries pass to it: R from 1000 to 47000
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.resistor_Vout(i, R:820)  wd.resistor_Vout(i, R)
  R.min:820
  R.max:10000
  i.nature:internal
  // BOUNDS FROM USAGE, the values the libraries pass to it: R from 820 to 10000
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.series  wd.series
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(2) => R0 with { {cons[cons[BoxIdent[R0],BoxAbstr[BoxIdent[R

wd.series2Port  wd.series2Port
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(2) => R0 with { {cons[cons[BoxIdent[R0],BoxAbstr[BoxIdent[R

wd.seriesVoltage(i, vin:0.3)  wd.seriesVoltage(i, vin)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.transformer(i, n:2.5)  wd.transformer(i, n)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.transformerActive(i, gamma1:0.9, gamma2:0.8)  wd.transformerActive(i, gamma1, gamma2)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_chua(i, G1:1e-3, G2:5e-4, V0:0.2)  wd.u_chua(i, G1, G2, V0)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_current(i)  wd.u_current(i, jin)
  i.nature:internal
  jin.nature:signal
  jin.example:os.osc(110)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_diodeAntiparallel(i, Is:1e-12, Vt:0.025)  wd.u_diodeAntiparallel(i, Is, Vt)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_diodeAntiparallel_omega(i, Is:2.52e-9, Vt:0.02585)  wd.u_diodeAntiparallel_omega(i, Is, Vt)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_diodePair(i, Is:1e-12, Vt:0.025)  wd.u_diodePair(i, Is, Vt)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_diodeSingle(i, Is:8e-13, Vt:0.026)  wd.u_diodeSingle(i, Is, Vt)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_genericNode(i, scatter)  wd.u_genericNode(i, scatter)
  i.nature:internal
  scatter.nature:function
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_idealDiode  wd.u_idealDiode
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(2) => 0; (1) => !,!; (0) => b1 with { {cons[cons[BoxIdent[b

wd.u_parallel2Port  wd.u_parallel2Port
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(2) => 0; (1) => !,!,!,!; (0) => u_par with { {cons[cons[Box

wd.u_resCurrent(i, R:2000)  wd.u_resCurrent(i, R, jin)
  i.nature:internal
  jin.nature:signal
  jin.example:os.osc(150)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_resVoltage(i, R:1800)  wd.u_resVoltage(i, R, ein)
  i.nature:internal
  ein.nature:signal
  ein.example:os.osc(220)
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_series2Port  wd.u_series2Port
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(2) => 0; (1) => !,!,!,!; (0) => u_ser with { {cons[cons[Box

wd.u_sixportPassive(i:0)  wd.u_sixportPassive(i)
  // OUTPUT NOT FINITE: NaN or infinity on silence (959360 samples out of 959360)
  // 13 inputs, 5 outputs

wd.u_switch  wd.u_switch
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(<lambda>,2) => 0; (<lambda>,1) => !,!; (<lambda>,0) => b0 w

wd.u_transformer(i, n:2.0)  wd.u_transformer(i, n)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_transformerActive(i, gamma1:0.9, gamma2:0.8)  wd.u_transformerActive(i, gamma1, gamma2)
  i.nature:internal
  // NOT VERIFIABLE: no example to put in place of a non-adjustable parameter

wd.u_voltage  wd.u_voltage
  // DOES NOT COMPILE: ERROR : pattern matching failed, no rule of case {(<ein>,2) => 0; (<ein>,1) => !,!; (<ein>,0) => b0 with { {co
