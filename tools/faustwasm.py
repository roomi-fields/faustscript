"""The Faust of the pinned @grame/faustwasm, for the catalogue's generator.

Each request runs in a `node tools/faustwasm.mjs` process of its own: no
compilation inherits what another one left in libfaust, and the catalogue is the
same whatever order the requests run in. The callers run requests in parallel,
one per thread.

    ask({'op': 'compile', 'code': faust}, delay=300)
"""
import json, pathlib, subprocess

# The head of every program: the libraries that faustwasm carries.
HEAD = 'import("stdfaust.lib");'

SERVER = pathlib.Path(__file__).resolve().with_name('faustwasm.mjs')


def ask(request, delay=300):
    """The answer of faustwasm to `request`, or {'timeout': delay}.

    An answer {'broken': message} says the compiler failed outside of a
    compilation.
    """
    try:
        r = subprocess.run(['node', str(SERVER)], input=json.dumps(request) + '\n',
                           capture_output=True, text=True, timeout=delay)
    except subprocess.TimeoutExpired:
        return {'timeout': delay}
    if not r.stdout.strip():
        return {'broken': 'the process exits without an answer (code %d)'
                          % r.returncode}
    return json.loads(r.stdout)
