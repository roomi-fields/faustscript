// Translation templates: what each FaustX form becomes in Faust.
//
// The transpiler knows no sign of the language — it reads this file. What sits
// between braces is replaced; everything else is copied as it stands.

// --- what the language reserves ---------------------------------------------

reserved.sink          process
reserved.index         i
reserved.input         _

// --- what a line becomes -----------------------------------------------------

template.Series        {a} : {b}
template.WideSeries    par({i},{n},{a}) : par({i},{n},{b})
template.Feedback      {a} ~ {b}
template.WideFeedback  {a} ~ par({i},{n},{b})
template.Split         {a} <: {b}
template.Merge         {a} :> {b}
template.Stack         {a}, {b}
template.Multiple      par({i},{n},{body})
template.CutWire       0

// Bypassing does not cut abruptly: the module stops being fed — it receives
// silence — but its output is still summed in, so whatever was ringing inside
// finishes coming out. Faust's own bypass1 does the opposite: it erases the
// module, and the measurement shows it — 97 memory fields become 0, against 81
// here.
template.Bypass        (_ <: ((0 : {module}), _) :> _)

// Removing: nothing enters and nothing passes through, but the tail runs out
template.Removal       (0 : {module})

// --- how an instance is written ----------------------------------------------

template.Instance      {name} = {body};
template.Group         vgroup("{name}", {body})
template.Call          {module}({arguments})

// --- how a setting is written ------------------------------------------------

// without bounds, one types the value; with bounds, a slider
template.FreePort      nentry("{label}", {default}, {min}, {max}, {step})
template.BoundedPort   hslider("{label}", {default}, {min}, {max}, {step})
template.Label         {name}{metadata}
template.Metadatum     [{key}:{value}]

// what an unbounded port takes for want of anything better
fallback.min           0
fallback.max           1e6
fallback.step          0.001

// --- scaling a signal connected to a setting ---------------------------------

template.Rescale       {signal} : it.remap({fromStart}, {fromEnd}, {toStart}, {toEnd})

// --- a program's heading -----------------------------------------------------

template.Header        import("stdfaust.lib");
template.Sink          process = {expression};

// what the sink receives when nothing feeds it any more: silence, and not the
// absence of a program — a file without a sink does not compile
template.Silence       0

// a module that feeds back and also receives a signal from outside: the return
// and the input are summed before entering it, otherwise the loop would eat the
// input
template.FedFeedback   (+ : {a}) ~ {b}

// --- the decision rules ------------------------------------------------------
//
// These are not forms but choices: when to merge, when a parameter becomes a
// port. They belong to the language, so they are read here and not written into
// the engine.

// several sources arriving at a module with a single input are summed;
// if it has several, they line up in order
rule.multipleSources.singleInput    template.Merge
rule.multipleSources.severalInputs  template.Series

// a parameter only becomes a port if the catalogue bounds it: without bounds,
// nothing says it accepts to move, and a filter's order does not
rule.port.requiresBounds            yes

// what a bounded port becomes, and what it becomes without bounds
rule.port.bounded                   template.BoundedPort
rule.port.free                      template.FreePort
