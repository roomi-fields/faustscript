#!/usr/bin/env python3
"""Measures the output range of every module in the catalogue, by making it sound.

A signal patched into a port is rescaled: FaustX puts an `it.remap` between what
the sending module produces and the bounds of the receiving port. That requires
knowing what a module produces — and no text says it. So we measure it.

The protocol, for each module:

  — the Faust compiler turns it into C (`-lang c`), gcc turns that into a program;
  — the program runs it at 48 kHz for five seconds, the first of which is
    discarded: a module with state takes time to settle;
  — a module that has inputs is fed twice, once with silence and once with
    full-scale white noise, with a fresh instance each time. Both ranges are
    recorded, and the announced range is their union;
  — the peak is recorded per quarter of the window: whatever is still rising in
    the last quarter has no range, it is a counter or a divergence.

What comes out is MEASURED, never deduced: an output recorded between -0.9998
and 0.9997 is written as such, and not as "-1 to 1". Five seconds of measurement
prove no theoretical bound — they say what was observed, with the starting
values of the declaration, and nothing more.

The possible states:

    measured     a range was recorded, min < max
    constant     the output does not move: no range to rescale
    growing      it is still rising at the end: counter, or divergence
    non-finite   NaN or infinity appeared
    failure      the module could not be compiled to C, or stopped dead

The cache (`tools/measured-ranges.json`) avoids redoing everything: it is keyed
by the measured Faust expression, and emptied as soon as the protocol changes
version.

    python3 tools/measure-ranges.py "os.osc(440)"      # one expression
"""
import os, re, json, hashlib, pathlib, shutil, tempfile, subprocess, sys
import concurrent.futures

# Change version as soon as the protocol changes: the cache becomes stale.
PROTOCOL = '1'

SR = 48000
DURATION = 5.0     # seconds given to the module
SETTLE = 1.0       # seconds discarded, the time it takes to settle

CACHE = pathlib.Path(__file__).with_name('measured-ranges.json')

# Beyond what an audio signal can be worth, an output still growing in the last
# quarter of the measurement has no range: it is counting or it is diverging.
GROWTH_THRESHOLD = 1.2
MAGNITUDE_THRESHOLD = 4.0

BENCH = r'''
/* FaustX measurement bench: runs a module and records its range. */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define FAUSTFLOAT float

/* What the C backend expects around the module. We never call it: the starting
   values are set by instanceResetUserInterface, not by walking through the
   interface. */
typedef struct Soundfile {
    FAUSTFLOAT** fBuffers; int* fLength; int* fSR; int* fOffset; int fChannels;
} Soundfile;

typedef struct {
    void* uiInterface;
    void (*openTabBox)(); void (*openHorizontalBox)(); void (*openVerticalBox)();
    void (*closeBox)(); void (*addButton)(); void (*addCheckButton)();
    void (*addVerticalSlider)(); void (*addHorizontalSlider)(); void (*addNumEntry)();
    void (*addHorizontalBargraph)(); void (*addVerticalBargraph)();
    void (*addSoundfile)(); void (*declare)();
} UIGlue;

typedef struct { void* metaInterface; void (*declare)(); } MetaGlue;

/* Faust expects a generic min and max, as in its CInterface.h */
#define max(a,b) ((a) < (b) ? (b) : (a))
#define min(a,b) ((a) < (b) ? (a) : (b))

#include "module.c"

#undef max
#undef min

#define BLOCK 512

static unsigned long long seed;
static float uniform(void) {
    seed = seed * 6364136223846793005ULL + 1442695040888963407ULL;
    return ((float)((seed >> 33) & 0x7fffff) / 4194304.0f) - 1.0f;
}

/* One regime: fresh instance, silence or noise, the range over the tail. */
static void regime(int noise, int nin, int nout) {
    dspx* dsp = newdspx();
    initdspx(dsp, SRX);
    FAUSTFLOAT** ins = (FAUSTFLOAT**)calloc(nin > 0 ? nin : 1, sizeof(FAUSTFLOAT*));
    FAUSTFLOAT** outs = (FAUSTFLOAT**)calloc(nout > 0 ? nout : 1, sizeof(FAUSTFLOAT*));
    int i, j;
    for (i = 0; i < nin; i++) ins[i] = (FAUSTFLOAT*)calloc(BLOCK, sizeof(FAUSTFLOAT));
    for (i = 0; i < nout; i++) outs[i] = (FAUSTFLOAT*)calloc(BLOCK, sizeof(FAUSTFLOAT));

    long total = (long)(DURATIONX * SRX), start = (long)(SETTLEX * SRX), pos;
    long measured = total - start, nonfinite = 0, points = 0;
    double low = 0.0, high = 0.0, peak[4] = {0, 0, 0, 0};

    seed = 20260806ULL;
    for (pos = 0; pos < total; pos += BLOCK) {
        int c = (int)((total - pos < BLOCK) ? (total - pos) : BLOCK), q;
        for (i = 0; i < nin; i++)
            for (j = 0; j < c; j++) ins[i][j] = noise ? uniform() : 0.0f;
        computedspx(dsp, c, ins, outs);
        if (pos < start) continue;
        q = (int)(4 * (pos - start) / (measured > 0 ? measured : 1));
        if (q > 3) q = 3;
        for (i = 0; i < nout; i++)
            for (j = 0; j < c; j++) {
                double v = (double)outs[i][j];
                if (!isfinite(v)) { nonfinite++; continue; }
                if (points == 0 || v < low) low = v;
                if (points == 0 || v > high) high = v;
                if (fabs(v) > peak[q]) peak[q] = fabs(v);
                points++;
            }
    }
    printf("%s %.9g %.9g %ld %ld %.6g %.6g %.6g %.6g\n",
           noise ? "noise" : "silence", low, high, nonfinite, points,
           peak[0], peak[1], peak[2], peak[3]);
    fflush(stdout);
    deletedspx(dsp);
}

int main(void) {
    dspx* probe = newdspx();
    initdspx(probe, SRX);
    int nin = getNumInputsdspx(probe), nout = getNumOutputsdspx(probe);
    deletedspx(probe);
    printf("arity %d %d\n", nin, nout);
    if (nout == 0) return 0;
    regime(0, nin, nout);
    if (nin > 0) regime(1, nin, nout);
    return 0;
}
'''


def bench_c():
    return (BENCH.replace('SRX', str(SR)).replace('DURATIONX', repr(DURATION))
                 .replace('SETTLEX', repr(SETTLE)))


def read_output(text):
    """Strips down what one run of the bench printed."""
    out = {}
    for line in text.splitlines():
        m = line.split()
        if len(m) == 3 and m[0] == 'arity':
            out['arity'] = (int(m[1]), int(m[2]))
        elif len(m) == 9:
            out[m[0]] = {'min': float(m[1]), 'max': float(m[2]),
                         'nonfinite': int(m[3]), 'points': int(m[4]),
                         'peaks': [float(x) for x in m[5:9]]}
    return out


def conclude(raw):
    """Returns the verdict on a module, from what the regimes gave."""
    regimes = {k: v for k, v in raw.items() if k in ('silence', 'noise')}
    if not regimes:
        return {'state': 'failure', 'detail': 'the module has no output'}

    for name, r in regimes.items():
        if r['nonfinite']:
            return {'state': 'non-finite',
                    'detail': 'NaN or infinity on %s (%d samples out of %d)'
                              % (name, r['nonfinite'], r['nonfinite'] + r['points'])}
    for name, r in regimes.items():
        c = r['peaks']
        if c[3] > MAGNITUDE_THRESHOLD and c[3] > GROWTH_THRESHOLD * max(c[1], 1e-30):
            return {'state': 'growing',
                    'detail': 'still rising after %g s on %s (peak %.4g)'
                              % (DURATION, name, c[3])}

    low = min(r['min'] for r in regimes.values())
    high = max(r['max'] for r in regimes.values())
    d = {'min': low, 'max': high,
         'excitation': 'silence-and-noise' if len(regimes) > 1 else
                       ('no-input' if raw.get('arity', (0, 0))[0] == 0
                        else 'silence')}
    if len(regimes) > 1:
        for name, r in regimes.items():
            d[name] = [r['min'], r['max']]
    if low == high:
        d['state'] = 'constant'
        d['detail'] = ('nothing comes out with the starting values' if low == 0
                       else 'the output does not move from %.6g' % low)
    else:
        d['state'] = 'measured'
    return d


def measure_one(expr, head, root, delay=120):
    """Compiles a module to C, runs it, returns its verdict."""
    work = tempfile.mkdtemp(prefix='faustx-range-')
    try:
        dsp = os.path.join(work, 'm.dsp')
        with open(dsp, 'w') as f:
            f.write('%s\nprocess = %s;\n' % (head, expr))
        r = subprocess.run(['faust', '-I', os.path.abspath(root), '-lang', 'c',
                            '-cn', 'dspx', '-o', os.path.join(work, 'module.c'), dsp],
                           capture_output=True, text=True, timeout=delay, cwd=work)
        if r.returncode != 0:
            return {'state': 'failure', 'detail': 'the compiler refuses the C'}
        with open(os.path.join(work, 'bench.c'), 'w') as f:
            f.write(bench_c())
        r = subprocess.run(['gcc', '-O0', '-w', '-o', os.path.join(work, 'bench'),
                            os.path.join(work, 'bench.c'), '-lm'],
                           capture_output=True, text=True, timeout=delay, cwd=work)
        if r.returncode != 0:
            return {'state': 'failure', 'detail': 'the generated C does not compile'}
        r = subprocess.run([os.path.join(work, 'bench')], capture_output=True,
                           text=True, timeout=delay, cwd=work)
        if r.returncode != 0:
            return {'state': 'failure',
                    'detail': 'the module stops dead (code %d)' % r.returncode}
        return conclude(read_output(r.stdout))
    except subprocess.TimeoutExpired:
        return {'state': 'failure', 'detail': 'the measurement exceeds %d s' % delay}
    except OSError as e:
        return {'state': 'failure', 'detail': 'measurement impossible: %s' % e}
    finally:
        shutil.rmtree(work, ignore_errors=True)


# ------------------------------------------------------------------ cache ----

def load_cache(path=CACHE):
    """The cache of a previous run, empty if the protocol has changed."""
    try:
        with open(path) as f:
            j = json.load(f)
    except (OSError, ValueError):
        return {}
    if j.get('protocol') != PROTOCOL or j.get('duration') != DURATION:
        return {}
    return j.get('ranges', {})


def write_cache(ranges, path=CACHE):
    """A JSON object, one expression per line: readable and diffable."""
    lines = ['{', '"protocol": %s,' % json.dumps(PROTOCOL),
             '"duration": %s,' % json.dumps(DURATION),
             '"samplerate": %d,' % SR,
             '"ranges": {']
    items = sorted(ranges.items())
    for i, (expr, v) in enumerate(items):
        lines.append(' %s: %s%s' % (json.dumps(expr), json.dumps(v, sort_keys=True),
                                    ',' if i < len(items) - 1 else ''))
    lines += ['}', '}']
    pathlib.Path(path).write_text('\n'.join(lines) + '\n')


def measure(exprs, head, root, cache=None, journal=None):
    """Measures a batch of expressions, keeping every available unit busy.

    What the cache already knows is not measured again: a full run costs a few
    minutes, a run that changes nothing costs a second.
    """
    known = load_cache() if cache is None else cache
    todo = sorted(set(e for e in exprs if e and e not in known))
    if todo and journal:
        print('// %d modules to measure (%d already cached)'
              % (len(todo), len(exprs) - len(todo)), file=journal)
    with concurrent.futures.ThreadPoolExecutor(max_workers=os.cpu_count() or 4) as ex:
        for expr, res in zip(todo, ex.map(
                lambda e: measure_one(e, head, root), todo)):
            known[expr] = res
    return known


def main():
    root = (sys.argv[2] if len(sys.argv) > 2
            else '../faust-upstream/faustlibraries')
    head = re.sub(r'library\("([^"]+)"\)',
                  lambda m: 'library("%s/%s")' % (os.path.abspath(root), m.group(1)),
                  (pathlib.Path(root) / 'stdfaust.lib').read_text(errors='replace'))
    if len(sys.argv) < 2:
        sys.exit(__doc__.strip().splitlines()[-1].strip())
    print(json.dumps(measure_one(sys.argv[1], head, root), indent=2,
                     sort_keys=True))


if __name__ == '__main__':
    main()
