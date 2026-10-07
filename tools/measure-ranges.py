#!/usr/bin/env python3
"""Measures the output range of every module in the catalogue, by making it sound.

A signal patched into a port is rescaled: FaustScript puts an `it.remap` between what
the sending module produces and the bounds of the receiving port. That requires
knowing what a module produces — and no text says it. So we measure it.

The protocol, for each module:

  — the Faust of the pinned faustwasm compiles it (`tools/faustwasm.mjs`), and
    runs it at 48 kHz for five seconds, in blocks of 512 samples, the first
    second discarded: a module with state takes time to settle;
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
    failure      the module could not be compiled, or the measurement failed

The cache (`tools/measured-ranges.json`) avoids redoing everything: it is keyed
by the measured Faust expression, and emptied as soon as the protocol or the
libfaust that measures changes version.

    python3 tools/measure-ranges.py "os.osc(440)"      # one expression
"""
import os, json, pathlib, sys
import concurrent.futures, importlib.util

# The Faust of the pinned faustwasm, in the same folder.
_spec = importlib.util.spec_from_file_location(
    'faustwasm', pathlib.Path(__file__).resolve().with_name('faustwasm.py'))
faustwasm = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(faustwasm)

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


def measure_one(expr, delay=120):
    """Compiles a module, makes it sound, returns its verdict."""
    r = faustwasm.ask({'op': 'measure', 'rate': SR, 'duration': DURATION,
                       'settle': SETTLE,
                       'code': '%s\nprocess = %s;\n' % (faustwasm.HEAD, expr)},
                      delay)
    if 'timeout' in r:
        return {'state': 'failure', 'detail': 'the measurement exceeds %d s' % delay}
    if 'broken' in r:
        return {'state': 'failure', 'detail': 'measurement impossible: %s' % r['broken']}
    if 'error' in r:
        return {'state': 'failure', 'detail': 'the compiler refuses the module'}
    if 'trap' in r:
        return {'state': 'failure', 'detail': 'the module stops dead: %s' % r['trap']}
    return conclude(r)


# ------------------------------------------------------------------ cache ----

def load_cache(libfaust, path=CACHE):
    """The cache of a previous run, empty if the protocol or libfaust has changed."""
    try:
        with open(path) as f:
            j = json.load(f)
    except (OSError, ValueError):
        return {}
    if (j.get('protocol') != PROTOCOL or j.get('duration') != DURATION
            or j.get('libfaust') != libfaust):
        return {}
    return j.get('ranges', {})


def write_cache(ranges, libfaust, path=CACHE):
    """A JSON object, one expression per line: readable and diffable."""
    lines = ['{', '"protocol": %s,' % json.dumps(PROTOCOL),
             '"libfaust": %s,' % json.dumps(libfaust),
             '"duration": %s,' % json.dumps(DURATION),
             '"samplerate": %d,' % SR,
             '"ranges": {']
    items = sorted(ranges.items())
    for i, (expr, v) in enumerate(items):
        lines.append(' %s: %s%s' % (json.dumps(expr), json.dumps(v, sort_keys=True),
                                    ',' if i < len(items) - 1 else ''))
    lines += ['}', '}']
    pathlib.Path(path).write_text('\n'.join(lines) + '\n')


def measure(exprs, libfaust, cache=None, journal=None):
    """Measures a batch of expressions, keeping every available unit busy.

    What the cache already knows is not measured again: a full run costs a few
    minutes, a run that changes nothing costs a second.
    """
    known = load_cache(libfaust) if cache is None else cache
    todo = sorted(set(e for e in exprs if e and e not in known))
    if todo and journal:
        print('// %d modules to measure (%d already cached)'
              % (len(todo), len(exprs) - len(todo)), file=journal)
    with concurrent.futures.ThreadPoolExecutor(max_workers=os.cpu_count() or 4) as ex:
        for expr, res in zip(todo, ex.map(
                measure_one, todo)):
            known[expr] = res
    return known


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__.strip().splitlines()[-1].strip())
    print(json.dumps(measure_one(sys.argv[1]), indent=2, sort_keys=True))


if __name__ == '__main__':
    main()
