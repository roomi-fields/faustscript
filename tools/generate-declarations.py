#!/usr/bin/env python3
"""Generates FaustX module declarations from the documentation of Faust's libraries.

The Faust libraries document every public function in a standard block: a usage
section, the description of each parameter, and a worked example. This script
extracts from it what a FaustX declaration needs — the names, the starting
values, the bounds, the units — and leaves as a comment what it could not read.

    npm run catalogue

The libraries are those the pinned @grame/faustwasm carries, and every
compilation and measurement goes through that same Faust (`tools/faustwasm.py`):
the catalogue describes exactly what the host compiles, and its header records
the versions of faustwasm, libfaust and the libraries.

The starting values come, in decreasing order of reliability, from:

  1. the worked example of the function's `#### Test` block, local names resolved;
  2. any other worked call in its own documentation block;
  3. the interface settings that a neighbouring function gives it (`name_ui`);
  4. the calls the other functions of the libraries make to it;
  5. the values of the function it relays to, when its body does nothing but
     pass its own parameters to another one;
  6. a default stated in so many words in the parameter description;
  7. failing all that, a convention on the parameter name or the middle of the
     documented range — and the line says so: `// GUESSED: ...`.

Not every parameter is a setting. The Test block shows what is really passed to
it: a number, or else a function to be applied, a list to be indexed, a signal
passing through, an index the model passes to itself. These last ones receive no
value but a nature — `function`, `table`, `signal`, `internal`, `expression` —
and the example that illustrates it:

    ADAA1(EPS:0.001, f, F1)  aa.ADAA1(EPS, f, F1, x)
      f.nature:function
      f.example:aa.clip(-1.0, 1.0)

They are outside the count of settings: giving them a number would make no
sense, and leaving them empty without saying so would be lying.

Finally, EVERY DECLARATION IS COMPILED with its starting values, and the
compiler has the last word. It answers three things at once:

  — the exact number of inputs and outputs, which the declaration carries in
    plain sight (`// 1 inputs, 1 outputs`) instead of guessing it from the text;
  — whether the starting values hold together: what does not compile stays in
    the catalogue, marked `// DOES NOT COMPILE` with the message received;
  — whether a parameter really is of the nature we lent it: what the compiler
    refuses in that position is reclassified, and the line says so.

Signals become the parameters of an anonymous function — `\\(x).(f(x))` — the
only form in which the compiler counts them as inputs. Failing that, the
declaration is marked `// NOT VERIFIABLE`, with the reason.

THE BOUNDS OF A SETTING — without them, a port is a numeric entry where the
value is typed; with them it becomes a slider, which a physical controller can
drive. They come, in decreasing order of reliability, from:

  1. the range the documentation announces in the parameter description;
  2. the slider a neighbouring function puts on it — its authors bound it
     themselves, unit and scale included;
  3. what the body imposes: `min(1, max(0, x))` clips, therefore bounds;
  4. the spread of the values the other functions pass to it — a usage, not a
     limit: the line says so;
  5. failing all that, a convention on the parameter name, marked GUESSED.

Bounds that exclude the starting value are not its own: we move on to the next
source. And a bounded setting must be able to change while playing: an `hslider`
is put in its place, and WHAT THE COMPILER REFUSES LOSES ITS BOUNDS — a filter
order or a table size is not something to drive.

THE OUTPUT RANGE — `output.min`, `output.max` — says what the module produces,
which is what one needs to know in order to rescale a signal patched into a
port. It is not read but MEASURED, by `tools/measure-ranges.py`.

What comes out is a STARTING POINT: the names are still Faust's own, often
terse. Do not edit by hand — correct this file and run it again.
"""
import re, sys, os, pathlib, shutil, tempfile, collections
import concurrent.futures, importlib.util

# The bench that measures the output range of each module, in the same folder.
_spec = importlib.util.spec_from_file_location(
    'measures', pathlib.Path(__file__).resolve().with_name('measure-ranges.py'))
measures = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(measures)

# The Faust of the pinned faustwasm, in the same folder.
_spec = importlib.util.spec_from_file_location(
    'faustwasm', pathlib.Path(__file__).resolve().with_name('faustwasm.py'))
faustwasm = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(faustwasm)

# The names Faust uses by convention for a signal passing through.
# `s` alone is excluded from it: it is just as much a selector
# (`lowpass0_highpass1`) as a stiffness (`nlSpringDamperClipped`).
SIGNALS = re.compile(r'^(?:x|y|z|in|input|sig|signal|src)\d*$', re.I)

UNITS = [
    (r'\bin\s+hz\b|\(hz\)', 'Hz'),
    (r'\bin\s+db\b|\(db\)', 'dB'),
    (r'\bin\s+seconds\b|\(sec\)|\(s\)', 's'),
    (r'\bin\s+ms\b|\(ms\)|\bmilliseconds\b', 'ms'),
    (r'\bin\s+samples\b|\(samples\)', 'samples'),
    (r'\(%\)|\bpercent\b', '%'),
]

RANGES = [
    r'\[(-?[\d.]+)\s*\.\.\s*(-?[\d.]+)\]',        # [0..1]
    r'\[(-?[\d.]+)\s*,\s*(-?[\d.]+)\]',           # [-1, 1]
    r'\((-?[\d.]+)\s*\.\.\s*(-?[\d.]+)\)',        # (0..1)
    r'\((-?[\d.]+)\s*-\s*(-?[\d.]+)\)',           # (0-1)
    r'\bbetween\s+(-?[\d.]+)\s+and\s+(-?[\d.]+)', # between 0 and 1
    r'\bbetween\s+(-?[\d.]+)\s*\.\.\s*(-?[\d.]+)',# between 0..1
    r'\bfrom\s+(-?[\d.]+)\s+to\s+(-?[\d.]+)',     # from 0 to 1
    r'\brange\s*:?\s*\(?\[?\s*(-?[\d.]+)\s*(?:-|to|\.\.)\s*(-?[\d.]+)',
    r'\((-?[\d.]+)\s*,\s*(-?[\d.]+)\)',           # (0,1)
]

# The bounds a parameter name hints at. Any bound taken from here is flagged
# `// BOUNDS GUESSED`: it comes from no source.
# The names that denote a size, an order or a number of channels are absent on
# purpose: they are not adjusted while playing, and giving them bounds would
# pass off as a slider what the compiler wants frozen.
CONVENTIONAL_BOUNDS = [
    (('freq', 'frequency', 'f0', 'fr', 'pitch', 'rootfreq', 'basefreq',
      'centerfreq', 'ctfreq', 'notefreq', 'fund', 'fc', 'cf', 'cutoff',
      'cutofffreq', 'fx', 'freqcutoff', 'cutofffrequency', 'freq1', 'fl',
      'lowcutoff', 'lowfreq', 'fmin', 'fu', 'highcutoff', 'highfreq', 'fmax',
      'freq2'), (20, 20000)),
    (('lfofreq', 'modfreq', 'vibratofreq', 'speed', 'rate'), (0.01, 20)),
    (('q', 'qfactor', 'quality'), (0.5, 50)),
    (('gain', 'level', 'amp', 'amplitude', 'volume', 'vol', 'outgain',
      'ingain', 'makeupgain', 'strength'), (0, 2)),
    (('l0', 'lpi', 'lfx', 'lg', 'ldb', 'gaindb'), (-60, 12)),
    (('thr', 'threshold', 'thresh'), (-80, 0)),
    (('att', 'attack', 'atttime', 'rel', 'release', 'reltime', 'dec', 'decay',
      'decaytime', 'hold', 'holdtime'), (0.001, 10)),
    (('sus', 'sustain', 'suslevel'), (0, 1)),
    (('wet', 'dry', 'mix', 'balance', 'pan', 'damp', 'damping', 'depth',
      'width', 'brightness', 'stiffness', 'sharpness', 'tension', 'res',
      'resonance', 'fb', 'feedback', 'size', 'roomsize', 'phase',
      'pluckposition', 'strikeposition', 'excitationposition'), (0, 1)),
    (('ratio', 'compressionratio'), (1, 20)),
]

# Last source, the least sure: what a parameter name hints at. Any value taken
# from here is flagged `// GUESSED` in the file produced.
CONVENTIONS = [
    (('freq', 'frequency', 'f0', 'fr', 'pitch', 'rootfreq', 'basefreq',
      'centerfreq', 'ctfreq', 'notefreq', 'fund'), '440'),
    (('fc', 'cf', 'cutoff', 'cutofffreq', 'fx', 'freqcutoff', 'cutofffrequency',
      'freq1'), '1000'),
    # the two edges of a band cannot fall in the same place
    (('fl', 'lowcutoff', 'lowfreq', 'fmin'), '500'),
    (('fu', 'highcutoff', 'highfreq', 'fmax', 'freq2'), '2000'),
    (('normfreq', 'normfrequency', 'nf'), '0.1'),
    (('q', 'qfactor', 'quality'), '1'),
    (('gain', 'level', 'amp', 'amplitude', 'volume', 'vol', 'outgain',
      'ingain', 'makeupgain', 'strength', 'g'), '1'),
    # a gain written in decibels does nothing at 0, like a linear gain at 1
    (('l0', 'lpi', 'lfx', 'lg', 'ldb', 'gaindb'), '0'),
    (('att', 'attack', 'atttime', 'attackms', 'envupms', 'attms',
      'bias_att'), '0.01'),
    (('rel', 'release', 'reltime', 'releasems', 'envdownms', 'relms',
      'bias_rel'), '0.1'),
    (('dec', 'decay', 'decaytime'), '0.1'),
    (('sus', 'sustain', 'suslevel'), '0.8'),
    (('hold', 'holdtime'), '0.1'),
    (('gate', 'trig', 'trigger', 'reset', 'bypass', 'phase', 'offset',
      'shift', 'start', 'legato', 'bias'), '0'),
    (('n', 'order', 'nbands', 'nchan', 'nchannels', 'nvoices', 'taps',
      'nharmonics', 'npoints', 'nfilters', 'o'), '2'),
    (('i', 'j', 'k', 'idx', 'sel', 'select', 'channel', 'chan'), '0'),
    (('index', 'modindex'), '1'),
    (('ratio', 'compressionratio'), '4'),
    (('thr', 'threshold', 'thresh'), '-20'),
    (('dur', 'duration', 't', 'time', 'period', 'length', 'delay', 'del',
      'stringlength', 'tubelength'), '1'),
    (('wet', 'dry', 'mix', 'balance', 'pan', 'position', 'pos', 'res',
      'resonance', 'fb', 'feedback', 'damp', 'damping', 'depth', 'width',
      'brightness', 'stiffness', 'sharpness', 'tension', 'mute',
      'pluckposition', 'strikeposition', 'strikesharpness',
      'excitationposition', 'a', 'b', 'c', 'w', 'e'), '0.5'),
    (('speed', 'rate', 'lfofreq', 'modfreq', 'vibratofreq'), '5'),
    (('size', 'roomsize'), '0.5'),
]

# A documentation title names one function or several sharing its block:
# `(ef.)cubicnl`, `(ef.)cubicnl_nodc`. A name written `name[n]` stands for a
# family of definitions and declares none.
TITLE = re.compile(r'^//-+\s*(`\(\w+\.\).*`)[-\s]*$', re.M)
TITLED = re.compile(r'`\((\w+)\.\)(\w+)`')


# ---------------------------------------------------------------- reading ----

def files(root):
    return sorted(pathlib.Path(root).glob('*.lib'))


def documented_blocks(root):
    """Returns {(prefix, name): text of the block} for each function a title names.

    Two libraries may document the same name — `ma.SR` and `pl.SR`: each one
    is a function of its own, under its prefix.
    """
    out = {}
    for f in files(root):
        txt = f.read_text(errors='replace')
        titles = list(TITLE.finditer(txt))
        for title, following in zip(titles, titles[1:] + [None]):
            block = txt[title.end():following.start() if following else len(txt)]
            body = re.split(r'^//-{10,}\s*$', block, maxsplit=1, flags=re.M)[0]
            for prefix, name in TITLED.findall(title.group(1)):
                out[(prefix, name)] = body
    return out


def without_comments(txt):
    return re.sub(r'//.*', '', txt)


def arguments(txt, i):
    """txt[i] is '(': returns (top-level arguments, position of the ')').

    Braces count too: `waveform{2, 3, 5}` is a single argument.
    """
    depth, braces, current, out = 0, 0, '', []
    while i < len(txt):
        c = txt[i]
        if c in '{[':
            braces += 1
        elif c in '}]':
            braces -= 1
        elif c == '(':
            depth += 1
            if depth == 1:
                i += 1
                continue
        elif c == ')':
            depth -= 1
            if depth == 0:
                out.append(current.strip())
                return [a for a in out if a], i
        if depth == 1 and braces == 0 and c == ',':
            out.append(current.strip())
            current = ''
        else:
            current += c
        i += 1
    return None, i


def up_to_semicolon(txt, i):
    """The body of a definition: from i up to the top-level `;`.

    A Faust definition nests `with { ... ; ... }`: stopping at the first `;` in
    sight would cut the body right down the middle.
    """
    depth = 0
    for j in range(i, len(txt)):
        c = txt[j]
        if c in '({[':
            depth += 1
        elif c in ')}]':
            depth -= 1
        elif c == ';' and depth <= 0:
            return txt[i:j]
    return txt[i:]


LITERAL = re.compile(r'^-?(?:\d+\.?\d*|\.\d+)(?:[eE][-+]?\d+)?$')
IDENTIFIER = re.compile(r'^[A-Za-z_]\w*$')


def literal(a):
    """Returns the value if the argument is a number written as such, else None."""
    a = a.strip()
    if LITERAL.match(a):
        return a
    if re.fullmatch(r'\s*\d+\s*<<\s*\d+\s*', a):
        left, right = a.split('<<')
        return str(int(left) << int(right))
    return None


def calls(txt, name=None):
    """Returns {name: [argument list, ...]} for every call written in txt."""
    out = collections.defaultdict(list)
    pattern = r'(?:(\w+)\.)?(%s)\s*\(' % (re.escape(name) if name else r'\w+')
    for mo in re.finditer(pattern, txt):
        args, _ = arguments(txt, mo.end() - 1)
        if args:
            out[mo.group(2)].append(args)
    return out


# ------------------------------------------------------------ signatures ----

def environment_contents(body):
    """The names an `environment { ... }` exposes, with their parameters."""
    mo = re.search(r'\benvironment\s*\{', body)
    if not mo:
        return None
    depth, inside = 0, ''
    for j in range(mo.end() - 1, len(body)):
        c = body[j]
        if c == '{':
            depth += 1
            if depth == 1:
                continue
        elif c == '}':
            depth -= 1
            if depth == 0:
                break
        if depth == 1:
            inside += c
    names = {}
    for m in re.finditer(r'(?:^|;)\s*(\w+)\s*(\([^()]*\))?\s*=', inside):
        args = [a.strip() for a in (m.group(2) or '()')[1:-1].split(',') if a.strip()]
        # several clauses per name: we keep the one that names its parameters
        if m.group(1) not in names or (names[m.group(1)] is None
                                       and all(IDENTIFIER.match(a) for a in args)):
            names[m.group(1)] = ', '.join(args) if all(
                IDENTIFIER.match(a) for a in args) and args else None
    return ', '.join(f'{n}({a})' if a else n for n, a in names.items())


def definitions(root):
    """Returns ({name: [clauses]}, {name: body}, {name: (target, frozen args)}).

    Faust allows several clauses per name — `allpassn(0,sv)` then
    `allpassn(n,sv)`. Only the one whose parameters are all names describes the
    function; the others are base cases.
    """
    clauses = collections.defaultdict(list)
    bodies = collections.defaultdict(str)
    forwards = {}
    for f in files(root):
        txt = without_comments(f.read_text(errors='replace'))
        for mo in re.finditer(r'^(\w+)\s*\(', txt, re.M):
            args, end = arguments(txt, mo.end() - 1)
            # the `=` may fall on the next line of a long signature
            if args is None or not re.match(r'\s*=', txt[end + 1:end + 200]):
                continue
            clauses[mo.group(1)].append(args)
            bodies[mo.group(1)] += up_to_semicolon(txt, end)
        for mo in re.finditer(r'^(\w+)\s*=', txt, re.M):
            name, rest = mo.group(1), up_to_semicolon(txt, mo.end())
            bodies[name] += rest
            if name in forwards:
                continue
            # `name = other;` a plain forward; `name = other(a,b);` a partial
            # application: the signature is the target's, minus the arguments
            # already frozen.
            head = re.match(r'\s*(?:\w+\.)?(\w+)\s*(\(|$)', rest)
            if head and head.group(2) == '(':
                args, _ = arguments(rest, head.end() - 1)
                forwards[name] = (head.group(1), args or [])
            elif head:
                forwards[name] = (head.group(1), [])
            else:
                forwards[name] = (None, [])
    return clauses, bodies, forwards


def signatures(root):
    """Returns ({name: [parameters]}, {name: body})."""
    clauses, bodies, forwards = definitions(root)
    direct = {}
    for name, listing in clauses.items():
        # the general clause: all parameters are names, the longest one
        good = [c for c in listing if all(IDENTIFIER.match(a) for a in c)]
        chosen = max(good or listing, key=len)
        direct[name] = [a if IDENTIFIER.match(a) else 'a%d' % (i + 1)
                        for i, a in enumerate(chosen)]

    for name, (target, args) in forwards.items():
        if name in direct:
            continue
        seen, frozen = set(), list(args)
        while target and target not in direct and target in forwards and target not in seen:
            seen.add(target)
            target, rest = forwards[target]
            frozen = rest + frozen
        if target in direct:
            direct[name] = direct[target][len(frozen):]
            if not bodies[name]:
                bodies[name] = bodies[target]
        else:
            # a constant or a composition: no parameter at all
            direct[name] = []
    return direct, bodies


# ------------------------------------------------------ reading one block ----

def commented_text(block):
    # `[ \t]?` and not `\s?`: a broad class would swallow the line break and
    # glue two comment lines into one.
    return '\n'.join(re.findall(r'^//[ \t]?(.*)$', block, re.M))


def section(block, title):
    """The text of a `#### Title` section, without its heading."""
    mo = re.search(r'####\s*%s\b:?(.*?)(?=^####|\Z)' % title,
                   commented_text(block), re.S | re.M)
    return mo.group(1) if mo else ''


def test_part(block):
    return section(block, 'Test')


def code_lines(zone):
    """The lines between the ``` fences of a section, or all of them failing that."""
    inside = re.findall(r'^```.*?$(.*?)^```', zone, re.S | re.M)
    return (''.join(inside) if inside else zone).splitlines()


def local_names(txt):
    """What each name stands for in an excerpt: `sig = os.osc(110);`.

    A binding holds on its own line: without that limit, prose containing
    `(N=1, M=1)` would swallow everything up to the next semicolon.
    """
    out = {}
    for mo in re.finditer(r'(?:^|[\s{])(\w+)\s*=\s*([^;\n]*);', txt, re.M):
        out.setdefault(mo.group(1), mo.group(2).strip())
    return out


def usage(block, name):
    """Returns (takes a signal, parameters) as the Usage section writes them.

    The parameters are None when no line calls the function, and the empty list
    when it is used without parentheses — a module without settings, such as
    `_ : softclipQuadratic1 : _`.
    """
    zone = section(block, 'Usage')
    if not zone.strip():
        # some blocks title their usage differently — `#### Phaser`: failing
        # that, everything written as code before the Test block stands
        zone = re.split(r'####\s*Test\b', commented_text(block))[0]
    found = re.compile(r'(?<![\w.])(?:\w+\.)?%s(?![\w])' % re.escape(name))
    signal, params, seen = False, None, False
    for line in code_lines(zone):
        mo = found.search(line)
        if not mo:
            continue
        seen = True
        before, rest = line[:mo.start()], line[mo.end():]
        if ':' in before:
            signal = True
        if rest.lstrip().startswith('('):
            args, _ = arguments(rest, rest.index('('))
            if args and params is None and all(IDENTIFIER.match(a) for a in args):
                params = args
        elif params is None and not before.strip().endswith('.'):
            params = []
    return (signal, params) if seen else (False, None)


def descriptions(block):
    return dict(re.findall(r'^//\s*\*\s*`(\w+)`\s*:\s*(.+?)\s*$', block, re.M))


def unit_and_range(text):
    low = text.lower()
    unit = next((u for pattern, u in UNITS if re.search(pattern, low)), None)
    span = None
    for pattern in RANGES:
        m = re.search(pattern, low)
        if m:
            try:
                span = (float(m.group(1)), float(m.group(2)))
            except ValueError:
                span = None
            break
    return unit, span


# ------------------------------------------ what an example argument is ----

UI_SETTING = re.compile(r'^\s*[hv]?(?:slider|nentry|entry)\s*\(\s*"[^"]*"\s*,\s*(-?[\d.]+)')
UI_BUTTON = re.compile(r'^\s*(?:button|checkbox)\s*\(')

# What stays a value even when written in Faust: constants and pure functions.
CONSTANTS = re.compile(r'\b(?:ma|pl)\.(?:PI|E|SR|BS|EPSILON|INFINITY|MIN|MAX|T|tablesize)\b')
PURE = re.compile(r'\b(?:ba\.(?:db2linear|linear2db|midikey2hz|hz2midikey|sec2samp|samp2sec)'
                  r'|ma\.(?:pow|sqrt|log|log10|exp|fabs|floor|ceil|min|max)'
                  r'|pow|sqrt|log|exp|abs|floor|ceil|min|max|int|float)\b')


def constant_expression(a):
    # `*(0.5)` is not a value but a half-applied function: an operator at the
    # head or the tail disqualifies the expression.
    if re.match(r'^[-+*/^%,]\s*\(|^[*/^%,]|[-+*/^%,]$', a.strip()):
        return False
    s = PURE.sub('', CONSTANTS.sub('1', a))
    return bool(re.fullmatch(r'[-+*/^%(),.\s\d]+', s)) and any(c.isdigit() for c in s)


def without_parentheses(a):
    """`(0.3)` is 0.3; `(0.1, 0.2)` stays a list."""
    while a.startswith('(') and a.endswith(')'):
        inside, end = arguments(a, 0)
        if inside is None or end != len(a) - 1 or len(inside) != 1:
            break
        a = inside[0].strip()
    return a


def classify(a, locals_, depth=0):
    """Returns (kind, text) for an example argument.

    kind is 'value' when the argument boils down to a number, 'table' when it is
    a list, 'expression' when it is signal or processing that will have to be
    told apart on the body of the definition.
    """
    a = without_parentheses(a.strip())
    if not a:
        return None, None
    v = literal(a)
    if v is not None:
        return 'value', v
    mo = UI_SETTING.match(a)
    if mo:
        return 'value', mo.group(1)
    if UI_BUTTON.match(a):
        return 'value', '0'
    if IDENTIFIER.match(a) and a in locals_ and depth < 3:
        return classify(locals_[a], locals_, depth + 1)
    if a.startswith('(') and ',' in a:
        return 'table', a
    if constant_expression(a):
        return 'value', a
    return 'expression', a


def split_top_level(txt):
    """Splits a sequence of expressions on its top-level commas."""
    depth, current, out = 0, '', []
    for c in txt:
        if c in '({[':
            depth += 1
        elif c in ')}]':
            depth -= 1
        if c == ',' and depth == 0:
            out.append(current.strip())
            current = ''
        else:
            current += c
    out.append(current.strip())
    return [a for a in out if a]


def patchings(zone, name):
    """What an example patches into `name` with `:` instead of parentheses.

    `(trigger, seedRange) : no.dnoise` says what the two arguments are worth as
    surely as a call written `no.dnoise(trigger, seedRange)`. Only the
    occurrences without parentheses are read this way, failing which the input
    signal of a `src : fi.resonlp(...)` would pass for a setting.
    """
    pattern = re.compile(r':\s*(?:\w+\.)?%s(?![\w])' % re.escape(name))
    out = []
    for line in code_lines(zone):
        mo = pattern.search(line)
        if not mo or line[mo.end():].lstrip().startswith('('):
            continue
        before, depth, start = line[:mo.start()], 0, 0
        for j in range(len(before) - 1, -1, -1):
            c = before[j]
            if c in ')}]':
                depth += 1
            elif c in '({[':
                depth -= 1
            elif depth == 0 and c in ':=':
                start = j + 1
                break
        t = before[start:].strip()
        args = None
        if t.startswith('('):
            inside, end = arguments(t, 0)
            if inside is not None and end == len(t) - 1:
                args = inside
        if args is None:
            args = split_top_level(t)
        if args:
            out.append(args)
    return out


def examples(listings, locals_, params, usage_params):
    """Returns {parameter: (kind, text)} from the calls given as examples.

    A call follows either the full signature or the usage line — which leaves
    aside the signals patched in with `:`. We align on whichever of the two has
    a matching number of arguments.
    """
    out = {}
    for args in listings:
        order = params
        if usage_params is not None and len(args) == len(usage_params) \
           and len(args) != len(params):
            order = usage_params
        for p, a in zip(order, args):
            if p not in out:
                out[p] = classify(a, locals_)
    return out


# ------------------------------------------------------ the other sources ----

def number(a):
    """The value of a slider argument: a number, or `-1/2`."""
    v = literal(a)
    if v is not None:
        return float(v)
    mo = re.fullmatch(r'\s*(-?[\d.]+)\s*([*/])\s*(-?[\d.]+)\s*', a)
    if mo:
        left, right = float(mo.group(1)), float(mo.group(3))
        return left * right if mo.group(2) == '*' else (left / right if right else None)
    return None


# Smoothing does not change the range of a slider; a multiplication does.
SMOOTHING = re.compile(r'\s*:\s*si\.(?:smoo|smooth|polySmooth)\b.*$')
SLIDER = re.compile(r'^[hv]?(?:slider|nentry)\s*\(\s*"((?:[^"\\]|\\.)*)"\s*,(.*)$', re.S)


def bare_slider(a, locals_, depth=0):
    """The slider a library puts on an argument, if it is put there as such.

    `hslider("f", 440, 50, 1000, 0.01) : si.smoo` bounds the parameter: 50 and
    1000 are the bounds its authors give it. On the other hand
    `hslider(...)*0.05` or `ba.semi2ratio(hslider(...))` no longer says anything
    about the value reaching the called function — we do not read those.
    """
    a = a.strip()
    if IDENTIFIER.match(a) and a in locals_ and depth < 3:
        return bare_slider(locals_[a], locals_, depth + 1)
    a = SMOOTHING.sub('', a).strip()
    mo = re.match(r'^\w*group\s*\(', a)          # a group changes nothing
    if mo and depth < 4:
        inside, end = arguments(a, mo.end() - 1)
        return (bare_slider(inside[-1], locals_, depth + 1)
                if inside and end == len(a) - 1 else None)
    mo = SLIDER.match(a)
    if not mo:
        return None
    args, end = arguments('(' + mo.group(2), 0)
    if args is None or end != len(mo.group(2)) or len(args) != 4:
        return None
    start, low, high, _ = [number(x) for x in args]
    if low is None or high is None or low >= high:
        return None
    meta = dict(re.findall(r'\[(\w+)\s*:\s*([^\]]*)\]', mo.group(1)))
    return {'min': low, 'max': high, 'start': start,
            'unit': meta.get('unit'), 'scale': meta.get('scale')}


def ui_settings_index(root):
    """What a neighbouring function sets as an interface setting.

    `blower_ui = blower(pressure, ...) with { pressure = hslider("...",0,0,1,0.01); }`
    says what the settings of `blower` are worth by default — and, when the
    slider is put there as such, between which bounds its authors adjust them.

    Returns (starting values, bounds), both keyed by function name.
    """
    out = collections.defaultdict(list)
    bounds = collections.defaultdict(list)
    for f in files(root):
        txt = without_comments(f.read_text(errors='replace'))
        for mo in re.finditer(r'^(\w+)\s*(?:\([^()]*\))?\s*=', txt, re.M):
            scope = up_to_semicolon(txt, mo.end())
            if not re.search(r'slider|nentry|button|checkbox', scope):
                continue
            locals_ = local_names(scope)
            for target, listings in calls(scope).items():
                for args in listings:
                    read = [classify(a, locals_) for a in args]
                    if any(k == 'value' for k, _ in read):
                        out[target].append([t if k == 'value' else '' for k, t in read])
                    sliders = [bare_slider(a, locals_) for a in args]
                    if any(sliders):
                        bounds[target].append(sliders)
    return out, bounds


def calls_index(root):
    """Every worked call the libraries make to each function.

    At each position we keep the most frequent value: the real usage, and not
    the special case of one example.
    """
    out = collections.defaultdict(lambda: collections.defaultdict(collections.Counter))
    for f in files(root):
        txt = f.read_text(errors='replace')
        for name, listings in calls(txt).items():
            for args in listings:
                for i, a in enumerate(args):
                    v = literal(a)
                    if v is not None:
                        out[name][i][v] += 1
    return out


def pass_through(body, params):
    """Returns (relayed function, its arguments) when the body only relays.

    `envelopeAbs(thr, gain, envUpMs, envDownMs, sig) = sig:motionEnvelope(thr,
    gain, envUpMs, envDownMs)`: what a setting of `motionEnvelope` is worth
    holds for it too.
    """
    for mo in re.finditer(r'(?:(\w+)\.)?(\w+)\s*\(', body):
        args, _ = arguments(body, mo.end() - 1)
        if args and len(args) >= 2 and all(a in params for a in args):
            return mo.group(2), args
    return None, []


STATED_DEFAULT = re.compile(r'default(?:\s+(?:should\s+be|is|value))?\s*[:=]?\s*(-?[\d.]+)'
                            r'|(-?[\d.]+)\s+(?:for|is\s+the)\s+default')


def stated_value(desc):
    mo = STATED_DEFAULT.search(desc.lower())
    return (mo.group(1) or mo.group(2)) if mo else None


def conventional_value(param, span, unit):
    """The convention on the name, refused if it falls outside the stated range."""
    low = param.lower()
    v = next((v for names, v in CONVENTIONS if low in names), None)
    # duration conventions are in seconds: in milliseconds, x1000
    if v and (unit == 'ms' or low.endswith('ms')) and float(v) < 1:
        v = '%g' % (float(v) * 1000)
    if v and span and not (span[0] <= float(v) <= span[1]):
        v = None
    if v is None and span:
        # failing that, the middle of the range the documentation announces
        return '%g' % (span[0] + (span[1] - span[0]) / 2), 'the middle of the range'
    return (v, 'the parameter name') if v else (None, None)


# ------------------------------------------------------------- the bounds ----
#
# Without bounds, a port is a numeric entry where the value is typed; with them
# it becomes a slider, which a physical controller can drive. They come from
# four sources, from the surest to the least sure, and the file says which one
# answered as soon as it is not the documentation.

def bounds_from_body(body, p):
    """What the body of the function imposes by itself.

    `max(0, x)` bounds from below, `min(1, max(0, x))` bounds on both sides:
    beyond that the value is clipped and the setting does nothing any more.
    """
    e = re.escape(p)
    for pattern in (r'min\s*\(\s*(-?[\d.]+)\s*,\s*max\s*\(\s*(-?[\d.]+)\s*,\s*%s\s*\)' % e,
                    r'max\s*\(\s*(-?[\d.]+)\s*,\s*min\s*\(\s*(-?[\d.]+)\s*,\s*%s\s*\)' % e):
        mo = re.search(pattern, body)
        if mo:
            a, b = float(mo.group(1)), float(mo.group(2))
            return (min(a, b), max(a, b))
    for pattern, group in ((r'max\s*\(\s*(-?[\d.]+)\s*,\s*%s\s*\)' % e, 1),
                           (r'max\s*\(\s*%s\s*,\s*(-?[\d.]+)\s*\)' % e, 1)):
        mo = re.search(pattern, body)
        if mo:
            return (float(mo.group(group)), None)
    return (None, None)


def bounds_from_usage(count):
    """The values the libraries really pass at that position.

    These are not limits but usages: several of them are needed for the spread
    to mean anything, and the line says so.
    """
    seen = sorted({float(v) for v in count})
    if len(seen) < 3 or seen[0] >= seen[-1]:
        return (None, None)
    return (seen[0], seen[-1])


def conventional_bounds(p, unit):
    low = p.lower()
    b = next((v for names, v in CONVENTIONAL_BOUNDS if low in names), None)
    if b and (unit == 'ms' or low.endswith('ms')) and b[1] <= 10:
        b = (b[0] * 1000, b[1] * 1000)   # duration conventions are in seconds
    return b or (None, None)


def bounds(p, span, unit, body, count, ui, start):
    """The first source the starting value does not contradict.

    Bounds that exclude the module's starting value are not its bounds: they
    come from another use of the same function — an `os.osc` that the
    documentation sets up as a low-frequency oscillator between 1 and 10 Hz says
    nothing about an audio oscillator at 440. We then move on to the next source.

    Returns (low, high, source, what was set aside along the way).
    """
    candidates = []
    if span:
        candidates.append((span[0], span[1], 'documentation'))
    if ui:
        candidates.append((ui['min'], ui['max'], 'interface'))
    lo, hi = bounds_from_body(body, p)
    if lo is not None:
        candidates.append((lo, hi, 'body'))
    lo, hi = bounds_from_usage(count) if count else (None, None)
    if lo is not None:
        candidates.append((lo, hi, 'usage'))
    lo, hi = conventional_bounds(p, unit)
    if lo is not None:
        candidates.append((lo, hi, 'convention'))

    aside = []
    for low, high, source in candidates:
        if start is None or (low <= start and (high is None or start <= high)):
            return low, high, source, aside
        aside.append(source)
    return None, None, None, aside


# --------------------------------------------- the nature of a parameter ----

INTERNAL = re.compile(r'never\s+be\s+user\s+declared|internal\s+use|do\s+not\s+set')
SAYS_FUNCTION = re.compile(r'\ba\s+(?:faust\s+)?function\b|\ban\s+arbitrary\s+expression\b'
                           r'|\bfunction\s+(?:to|that|of|we|which)\b|\bantiderivative\b'
                           r'|\btype\s+of\s+function\b|\b\w+\s+function\b')
SAYS_TABLE = re.compile(r'\(s1\s*,\s*s2|\blist\s+of\b|\ba\s+table\b|\bthe\s+table\b'
                        r'|\bcoefficients\b|\bthe\s+scale\b|\barrays?\b|\bmatri[xc]e?s?\b')
SAYS_SIGNAL = re.compile(r'\bwaveform\b|^(?:an?|the)\s+\w*\s*signal\b|\bsignal\s+to\s+be\b'
                         r'|\bexcitation\s+signal\b|\btrigger\s+signal\b'
                         r'|^[\w/]+(?:\s+[\w/]+)?\s+signal\b')


# An example that starts with an operator, or that boils down to an operator,
# is not a signal source but a processing block one patches in: `*(0.5)`.
PROCESSING = re.compile(r'^\s*(?:[-+*/^%<>]|_|!|par\s*\(|seq\s*\(|si\.(?:bus|smoo)\b'
                        r'|min\b|max\b|fi\.|it\.|ba\.(?:take|midikey2hz)\b)')


def nature_of_example(text):
    if text.startswith('waveform{'):
        return 'table'
    if PROCESSING.match(text) or re.fullmatch(r'[-+*/^%<>]+', text.strip()):
        return 'function'
    return 'signal'


def nature(p, usage_params, params, body, desc, example):
    """Returns 'function', 'table', 'signal', 'internal' — or None for a setting.

    The order matters: what the Test block shows wins over what the prose hints
    at, because a description such as "fundamental of the input signal" speaks
    of the signal without the parameter being one.
    """
    if SIGNALS.match(p):
        return 'signal'
    # present in the signature but absent from the usage line: this is the
    # signal that `:` patches in, not an argument one writes
    if usage_params and params[:len(usage_params)] == usage_params \
       and p not in usage_params:
        return 'signal'
    if INTERNAL.search(desc.lower()):
        return 'internal'
    if re.search(r'\b%s\s*\(' % re.escape(p), body):
        return 'function'
    if example[0] == 'value':
        return None                       # the Test block decides: it is a setting
    if re.search(r'\b(?:ba\.(?:take|subseq|count)|rdtable)\s*\([^()]*\b%s\b'
                 % re.escape(p), body):
        return 'table'
    if example[0] == 'table':
        return 'table'
    low = desc.lower()
    if SAYS_FUNCTION.search(low):
        return 'function'
    if SAYS_TABLE.search(low):
        return 'table'
    if example[0] == 'expression':
        return nature_of_example(example[1])
    if SAYS_SIGNAL.search(low):
        return 'signal'
    return None


# --------------------------------------------------------------- declare ----

# What we say of a bound that does not come from the documentation.
BOUNDS_EXPLAINED = {
    'interface': 'BOUNDS FROM INTERFACE, from the slider the libraries put on it',
    'body': 'BOUNDS DEDUCED, the body of the function imposes them',
    'usage': 'BOUNDS FROM USAGE, the values the libraries pass to it',
    'convention': 'BOUNDS GUESSED, from the parameter name',
}

# Below this, what a module lets out at rest is computation dust — a reverb
# dying out at -120 dB — and not an emission.
RESIDUE = 1e-6

RANGE_TROUBLES = {
    'constant': 'CONSTANT OUTPUT',
    'growing': 'OUTPUT WITHOUT RANGE',
    'non-finite': 'OUTPUT NOT FINITE',
    'failure': 'OUTPUT NOT MEASURED',
}


def rendered_range(d):
    """What the measurement recorded of the module's output.

    A range is only ever written once measured: `output.measure` says under
    which excitation. What does not fit into two numbers — an output that does
    not move, that rises without end, that goes off into NaN — stays in plain
    words, without bounds.
    """
    r = d['range']
    if not r:
        return []
    if r['state'] != 'measured':
        return ['  // %s: %s' % (RANGE_TROUBLES[r['state']], r['detail'])]
    lines = ['  output.min:%g' % r['min'], '  output.max:%g' % r['max'],
             '  output.measure:%s' % r['excitation']]
    s, n = r.get('silence'), r.get('noise')
    if s and n and max(abs(s[0]), abs(s[1])) > RESIDUE:
        # the module emits something even without receiving anything: the two
        # regimes are read separately
        lines.append('  // at rest: %g to %g; under noise: %g to %g'
                     % (s[0], s[1], n[0], n[1]))
    return lines

def aligned(listings, params, usage_params):
    """Keys by parameter name what argument lists carry."""
    out = {}
    for args in listings:
        order = params
        if usage_params is not None and len(args) == len(usage_params) \
           and len(args) != len(params):
            order = usage_params
        for p, r in zip(order, args):
            if r and p not in out:
                out[p] = r
    return out


def declare(name, prefix, block, params, body, ui, uib, everywhere, stats):
    empty = {'name': name, 'prefix': prefix, 'params': [], 'values': {},
             'natures': {}, 'examples': {}, 'units': {}, 'bounds': {},
             'scales': {}, 'guessed': {},
             'environment': None, 'remarks': [], 'unverifiable': None,
             'inputs': None, 'outputs': None, 'error': None, 'range': None}

    inside = environment_contents(body)
    if inside is not None:
        stats['environments'] += 1
        return dict(empty, environment=inside), None

    _, usage_params = usage(block, name)
    if params is None:
        params = usage_params
    elif params == [] and usage_params:
        params = usage_params
    if params is None:
        return None, 'neither signature nor usage'

    d = dict(empty, params=params)

    if not params:
        # a module without settings: the name alone is enough on both sides
        return d, None

    desc = descriptions(block)
    # the usage line sometimes names things differently from the definition: the
    # description follows the usage name, the declaration the definition's one
    if usage_params:
        for p, q in zip(params, usage_params):
            if p not in desc and q in desc:
                desc[p] = desc[q]
    locals_ = local_names(commented_text(block))
    test = test_part(block)
    ex_test = examples(calls(test, name).get(name, []) + patchings(test, name),
                       locals_, params, usage_params)
    ex_block = examples(calls(commented_text(block), name).get(name, []), locals_,
                        params, usage_params)
    ex_ui = examples(ui.get(name, []), {}, params, usage_params)
    sliders = aligned(uib.get(name, []), params, usage_params)
    relayed_to, relayed = pass_through(body, params)

    for i, p in enumerate(params):
        nothing = (None, None)
        e_test, e_block, e_ui = (ex_test.get(p, nothing), ex_block.get(p, nothing),
                                 ex_ui.get(p, nothing))
        nat = nature(p, usage_params, params, body, desc.get(p, ''), e_test)

        if nat:
            d['natures'][p] = nat
            shown = next((t for k, t in (e_test, e_block)
                          if k in ('expression', 'table')), None)
            if shown and shown != p:
                d['examples'][p] = shown
            continue

        u, span = unit_and_range(desc.get(p, ''))
        v, source = None, None
        for (k, t), src in ((e_test, 'Test block'), (e_block, 'doc block'),
                            (e_ui, 'neighbouring interface')):
            if k == 'value':
                v, source = t, src
                break
        if v is None and everywhere[name][i]:
            v, source = everywhere[name][i].most_common(1)[0][0], 'library calls'
        if v is None and p in relayed:
            count = everywhere[relayed_to][relayed.index(p)]
            if count:
                v, source = count.most_common(1)[0][0], 'relayed function'
        if v is None:
            v = stated_value(desc.get(p, ''))
            source = 'documentation' if v else None
        if v is None:
            v, why = conventional_value(p, span, u)
            if v:
                source = 'convention'
                d['guessed'][p] = why

        if v is not None:
            d['values'][p] = v
            stats['source ' + source] += 1

        slider = sliders.get(p)
        if u is None and slider and slider.get('unit'):
            u = slider['unit']
        if u:
            d['units'][p] = u

        try:
            start = float(d['values'].get(p, ''))
        except ValueError:
            start = None
        low, high, origin, aside = bounds(p, span, u, body,
                                          everywhere[name][i], slider, start)
        if 'documentation' in aside:
            d['remarks'].append(
                f'  // the bounds stated for {p} ({span[0]:g} to {span[1]:g}) '
                f'are not kept: {p}:{d["values"][p]} falls outside')
        stats['bounds set aside, the start falls outside'] += len(aside)
        if low is None:
            continue
        d['bounds'][p] = (low, high, origin)
        stats['bounds ' + origin] += 1
        # whatever covers several decades is adjusted logarithmically, otherwise
        # half the travel of a slider is of no use
        scale = (slider or {}).get('scale')
        if scale == 'log' and not low > 0:
            scale = None              # a logarithmic scale starts above zero
        if not scale and high is not None and low > 0 and high / low >= 100:
            scale = 'log'
        if scale:
            d['scales'][p] = scale

    return d, None


def quote(value):
    """An example carrying raw Faust is quoted: otherwise it breaks the reading.

    `FTZ_test = ((ma.MIN * 0.5)` carries an equals sign and an unclosed
    parenthesis; between quotes it is text that the parser goes through without
    trying to understand it. So is the ellipsis of a documented table,
    `(k1,k2,k3,...)`.
    """
    value = str(value).strip()
    # a number written `.2` is normalised: the dot belongs to a copy, it does
    # not begin a number
    value = re.sub(r'(?<![\w.])\.(\d)', r'0.\1', value)
    # nor end with a dot: `0.` becomes `0.0`, without which the next dot would
    # be taken for the dot of a path
    value = re.sub(r'(\d)\.(?![\d.])', r'\1.0', value)
    fragile = (re.search(r'[=;{}]|\.\.', value)
               or value.count('(') != value.count(')'))
    if fragile:
        return '"%s"' % value.replace('"', "'")
    return value


# The refusal of a module that calls a function of the C library the WebAssembly
# backend does not link: the module is unavailable in faustwasm, whatever its
# values.
FOREIGN = re.compile(r"calling foreign function '(\w+)' is not allowed")


def render(d):
    """The text of a declaration, once the compiler has gone over it."""
    head = [f"{p}:{quote(d['values'][p])}" if p in d['values'] else p
            for p in d['params']
            if d['natures'].get(p) != 'signal']
    name = f"{d['prefix']}.{d['name']}"
    body = name
    if d['params']:
        body += f"({', '.join(d['params'])})"
    lines = [f"{name}({', '.join(head)})  {body}" if head
             else f"{name}  {body}"]
    for p in d['params']:
        if p in d['units']:
            lines.append(f"  {p}.unit:{d['units'][p]}")
        if p in d['bounds']:
            low, high, _ = d['bounds'][p]
            lines.append(f'  {p}.min:{low:g}')
            if high is not None:
                lines.append(f'  {p}.max:{high:g}')
        if p in d['scales']:
            lines.append(f"  {p}.scale:{d['scales'][p]}")
    for p in d['params']:
        if p in d['natures']:
            lines.append(f"  {p}.nature:{d['natures'][p]}")
            if p in d['examples']:
                lines.append(f"  {p}.example:{quote(d['examples'][p])}")
    foreign = re.search(FOREIGN, d['error'] or '')
    if foreign:
        lines.append(f'  faustwasm.unavailable:{foreign.group(1)}')
    lines += rendered_range(d)
    for p in d['params']:
        if p in d['guessed'] and p in d['values']:
            lines.append(f"  // GUESSED: {p}:{d['values'][p]}, from {d['guessed'][p]}")
    for p in d['params']:
        if p in d['bounds'] and d['bounds'][p][2] in BOUNDS_EXPLAINED:
            low, high, origin = d['bounds'][p]
            span = f'from {low:g} to {high:g}' if high is not None else f'at least {low:g}'
            lines.append(f'  // {BOUNDS_EXPLAINED[origin]}: {p} {span}')
    if d['environment'] is not None:
        lines.append(f"  // a set of definitions: {d['environment']}")
    elif d['unverifiable']:
        lines.append(f"  // NOT VERIFIABLE: {d['unverifiable']}")
    elif d['error']:
        lines.append(f"  // DOES NOT COMPILE: {d['error']}")
    else:
        i, o = d['inputs'], d['outputs']
        lines.append('  // %d input%s, %d output%s'
                     % (i, 's' if i > 1 else '', o, 's' if o > 1 else ''))
    lines += d['remarks']
    for p in d['params']:
        if p not in d['values'] and p not in d['natures']:
            lines.append(f'  // TO COMPLETE: {p} has no starting value')
    return '\n'.join(lines)


# --------------------------------------------- what the compiler says of it ----

def expression(d, tweak=None):
    """The Faust call of a declaration, ready to compile.

    Signals become the parameters of an anonymous function: that is how they
    count among the inputs of the module, instead of being confused with an
    argument one writes. `tweak` replaces the treatment of one parameter, long
    enough to check whether the declaration would fare better otherwise.
    """
    args, free = [], []
    for p in d['params']:
        what = tweak[1] if tweak and tweak[0] == p else None
        if what == 'signal' or (what is None and d['natures'].get(p) == 'signal'):
            free.append(p)
            args.append(p)
        elif what is not None:
            args.append(what)
        elif p in d['values']:
            v = d['values'][p]
            args.append(v if LITERAL.match(v) else f'({v})')
        elif p in d['examples']:
            args.append(f"({d['examples'][p]})")
        else:
            return None
    call = f"{d['prefix']}.{d['name']}" + (f"({', '.join(args)})" if args else '')
    return f"\\({', '.join(free)}).({call})" if free else call


def first_error(text):
    """The compiler's first error, from `ERROR` on: its place is in the bench's
    own program, which says nothing of the module."""
    for line in (text or '').splitlines():
        at = line.find('ERROR')
        if at >= 0:
            return line[at:].strip()[:110]
    return (text or 'failure without a message').strip().splitlines()[0][:110]


def compile_faust(expr, delay=300):
    """Returns (inputs, outputs) or (None, error message).

    We compile `(expression), 1`: the added constant changes nothing to the
    inputs, adds an output we subtract again, and lets a module without an
    output — a signal blocker, an environment — go through all the same.
    """
    r = faustwasm.ask({'op': 'compile', 'code': '%s\nprocess = (%s), 1;\n'
                       % (faustwasm.HEAD, expr)}, delay)
    if 'timeout' in r:
        return None, 'compilation too long'
    if 'broken' in r:
        return None, 'the compiler fails: %s' % r['broken']
    if 'error' in r:
        return None, first_error(r['error'])
    return (r['inputs'], r['outputs'] - 1), None


def in_parallel(tasks):
    """Compiles a batch of expressions, keeping every available unit busy."""
    with concurrent.futures.ThreadPoolExecutor(max_workers=os.cpu_count() or 4) as ex:
        return list(ex.map(compile_faust, tasks))


def tweaks(d):
    """What we try when the declared form does not compile.

    A setting the compiler refuses was perhaps a signal; a parameter judged
    non-adjustable perhaps makes do with a number.
    """
    for p in d['params']:
        if d['natures'].get(p) == 'signal' and p in d['examples']:
            yield (p, d['examples'][p])
        elif p in d['values']:
            yield (p, 'signal')
        elif p not in d['examples']:
            yield (p, conventional_value(p, None, None)[0] or '1')
            yield (p, '_')


def verify(decls, stats):
    """Makes the compiler the source of truth on each declaration."""
    testable = [d for d in decls if d['environment'] is None]
    exprs = [expression(d) for d in testable]
    for d, e in zip(testable, exprs):
        if e is None:
            d['unverifiable'] = ('no example to put in place of a '
                                 'non-adjustable parameter')
    todo = [(d, e) for d, e in zip(testable, exprs) if e is not None]
    for (d, _), res in zip(todo, in_parallel([e for _, e in todo])):
        (arity, err) = res
        if arity:
            d['inputs'], d['outputs'] = arity
        else:
            d['error'] = err

    # what failed: we look for the tweak that repairs it. A tweak changes only
    # one parameter: two faults in the same declaration take as many rounds, and
    # we stop as soon as a round repairs nothing more. The refusal of a foreign
    # function holds whatever the values: a tweak that goes through only hides
    # the call, and the widths it yields are not the module's.
    for _ in range(4):
        broken = [d for d in testable
                  if d['error'] and d['error'].startswith(('ERROR', 'error'))
                  and not re.search(FOREIGN, d['error'])]
        if not broken or not repair(broken, stats):
            break

    # what fails on a name borrowed from a documentation example is not a broken
    # declaration: it is the stand-in that misses its context
    for d in testable:
        mo = re.search(r'undefined symbol : (\w+)', d['error'] or '')
        if mo and any(re.search(r'\b%s\b' % re.escape(mo.group(1)), t)
                      for t in d['examples'].values()):
            d['unverifiable'] = (f"the parameter's example relies on "
                                 f"`{mo.group(1)}`, defined nowhere else")
            d['error'] = None

    # the parameters judged non-adjustable: would a number go through too?
    doubles = [(d, p, expression(d, (p, '1'))) for d in testable if not d['error']
               for p in d['params'] if d['natures'].get(p) in ('function', 'table')]
    doubles = [(d, p, e) for d, p, e in doubles if e is not None]
    for (d, p, _), (arity, _) in zip(doubles, in_parallel([e for _, _, e in doubles])):
        stats['nature refusing a number' if not arity
              else 'nature accepting a number too'] += 1


def verify_sliders(decls, stats):
    """A bounded port must be adjustable while playing.

    Faust demands a constant in certain places — the size of a table, a filter
    order, a number of voices. Putting bounds there would pass off as a slider
    what will never be one: we put an `hslider` in place of the value, and what
    the compiler refuses loses its bounds.
    """
    trials = []
    for d in decls:
        if d['error'] or d['unverifiable'] or d['environment'] is not None:
            continue
        for p, (low, high, _) in d['bounds'].items():
            if high is None:
                continue
            try:
                start = float(d['values'].get(p, ''))
            except ValueError:
                start = None
            if start is None or not (low <= start <= high):
                start = low + (high - low) / 2
            e = expression(d, (p, 'hslider("%s", %g, %g, %g, %g)'
                               % (p, start, low, high, (high - low) / 1000.0)))
            if e is not None:
                trials.append((d, p, e))
    for (d, p, _), (arity, _) in zip(trials, in_parallel([e for _, _, e in trials])):
        if arity:
            stats['bounds that hold as a slider'] += 1
            continue
        d['bounds'].pop(p, None)
        d['scales'].pop(p, None)
        d['remarks'].append(f'  // {p} cannot be adjusted live: the compiler '
                            'demands a constant in this place')
        stats['bounds removed, the setting stays frozen'] += 1


def measure_ranges(decls, libfaust, stats, journal):
    """Makes each module sound and attaches the range recorded to it."""
    measurable = [d for d in decls if not d['error'] and not d['unverifiable']
                  and d['environment'] is None and d['outputs']]
    exprs = [expression(d) for d in measurable]
    ranges = measures.measure([e for e in exprs if e], libfaust, journal=journal)
    for d, e in zip(measurable, exprs):
        d['range'] = ranges.get(e)
        if d['range']:
            stats['range ' + d['range']['state']] += 1
    measures.write_cache(ranges, libfaust)


def repair(broken, stats):
    """Tries one tweak per parameter; returns the number of repairs."""
    repaired = 0
    trials = [(d, t, expression(d, t)) for d in broken for t in tweaks(d)]
    trials = [(d, t, e) for d, t, e in trials if e is not None]
    for (d, t, _), (arity, _) in zip(trials, in_parallel([e for _, _, e in trials])):
        if not arity or not d['error']:
            continue
        p, what = t
        d['inputs'], d['outputs'], d['error'] = arity[0], arity[1], None
        repaired += 1
        if what == 'signal':
            d['values'].pop(p, None)
            d['natures'][p] = 'signal'
            d['remarks'].append(f'  // {p} becomes a signal: the compiler '
                                'refuses a value in this place')
            stats['settings reclassified as signal'] += 1
        elif what == '_':
            d['natures'][p] = 'function'
            d['examples'][p] = '_'
            d['remarks'].append(f'  // {p} is a treatment one patches in: '
                                'the compiler accepts here neither value nor input')
            stats['signals reclassified as function'] += 1
        elif what == d['examples'].get(p):
            d['natures'][p] = 'expression'
            d['remarks'].append(f'  // {p} is not an input: the compiler '
                                'accepts it only in the form of its example')
            stats['signals reclassified as expression'] += 1
        else:
            d['natures'].pop(p, None)
            d['values'][p] = what
            d['guessed'][p] = 'default: only a number compiles in this place'
            stats['natures reclassified as setting'] += 1
    return repaired


def main():
    versions = faustwasm.ask({'op': 'versions'})
    root = tempfile.mkdtemp(prefix='faustx-libraries-')
    try:
        faustwasm.ask({'op': 'libraries', 'to': root})
        generate(root, versions)
    finally:
        shutil.rmtree(root)


def generate(root, versions):
    """Writes the catalogue of the libraries copied into `root` on stdout."""
    blocks = documented_blocks(root)
    sigs, bodies = signatures(root)
    ui, uib = ui_settings_index(root)
    everywhere = calls_index(root)
    decls, failures = [], collections.Counter()
    stats = collections.Counter()

    for (prefix, name), block in sorted(blocks.items()):
        d, failure = declare(name, prefix, block, sigs.get(name), bodies.get(name, ''),
                             ui, uib, everywhere, stats)
        if failure:
            failures[failure] += 1
            continue
        decls.append(d)

    verify(decls, stats)
    verify_sliders(decls, stats)
    measure_ranges(decls, versions['libfaust'], stats, sys.stderr)

    done = []
    for d in decls:
        text = render(d)
        done.append(text)
        stats['declared'] += 1
        for p in d['params']:
            if d['natures'].get(p):
                stats['nature ' + d['natures'][p]] += 1
                stats['non-adjustable parameters'] += 1
            else:
                stats['settings'] += 1
                if p in d['values']:
                    stats['settings given a value'] += 1
        if d['unverifiable']:
            stats['not verifiable'] += 1
        elif d['error']:
            stats['do not compile'] += 1
        elif d['environment'] is None:
            stats['compile'] += 1
            if d['inputs'] == 0:
                stats['without input'] += 1
        if '.unit:' in text:    stats['with a unit'] += 1
        if d['bounds']:         stats['with bounds'] += 1
        if 'output.min:' in text: stats['with an output range'] += 1
        if 'TO COMPLETE' not in text: stats['complete'] += 1

    print('// FaustX module declarations, generated from the Faust libraries of')
    print('// @grame/faustwasm %s: libfaust %s, libraries %s (version.lib).'
          % (versions['faustwasm'], versions['libfaust'], versions['libraries']))
    print('// %d modules.' % len(done))
    print('// Each module bears Faust\'s name, its prefix included: fi.lowpass.')
    print('// Every declaration has been compiled with its starting values: the')
    print('// "N inputs, M outputs" line comes from the compiler, not from the text.')
    print('// A value marked GUESSED comes from no source: it is deduced from the')
    print('// parameter name or from the range the documentation announces.')
    print('// A parameter that carries a nature is not a setting.')
    print('//')
    print('// The bounds of a setting — `p.min`, `p.max` — come from the')
    print('// documentation when nothing says otherwise; failing that a BOUNDS ...')
    print('// line names the source, and says what is deduced, observed or guessed.')
    print('// A bounded setting has passed the slider test: the compiler accepts')
    print('// that it changes while the sound plays.')
    print('//')
    print('// The output range — `output.min`, `output.max` — is MEASURED:')
    print('// the module ran for %g s at %d kHz with its starting values, the'
          % (measures.DURATION, measures.SR // 1000))
    print('// first second discarded, on silence then on full-scale noise.')
    print('// `output.measure` says under which excitation. These are observed')
    print('// values, never theoretical bounds.')
    print('//')
    print('// `faustwasm.unavailable:f` marks a module that faustwasm refuses to')
    print('// compile: it calls the foreign function f, which the WebAssembly')
    print('// backend does not allow.')
    print('// Do not edit by hand: correct tools/generate-declarations.py.')
    print()
    print('\n\n'.join(done))

    total = len(blocks)
    print(f"\n// --- {total} public functions read ---", file=sys.stderr)
    for k, v in stats.most_common():
        print(f"//   {k:<38} {v:>5}", file=sys.stderr)
    for k, v in failures.most_common():
        print(f"//   FAILED {k:<31} {v:>5}", file=sys.stderr)


if __name__ == '__main__':
    main()
