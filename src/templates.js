// The templates: what each form of the language becomes in Faust.
//
// Nothing here says what FaustX looks like or what Faust expects: it all comes
// from `lib/translation.fx`. This file only knows how to fill in blanks.

/** Reads the template file: lines of `key  value`, everything else ignored. */
export function readTemplates(text) {
  const table = new Map()
  for (const line of text.split('\n')) {
    const bare = line.replace(/\/\/.*$/, '').trim()
    if (!bare) continue
    const split = bare.search(/\s/)
    if (split < 0) continue
    table.set(bare.slice(0, split), bare.slice(split).trim())
  }
  return new Templates(table)
}

export class Templates {
  constructor(table) { this.table = table }

  /** What a key is worth, as it stands. */
  value(key) {
    const found = this.table.get(key)
    if (found === undefined) throw new Error(`template missing: ${key}`)
    return found
  }

  /** Fills a template: `{name}` takes the value of `values.name`. */
  fill(key, values = {}) {
    return this.value(key).replace(/\{(\w+)\}/g, (whole, name) =>
      name in values ? String(values[name]) : whole)
  }

  /** A word the language reserves — the sink, the index, the input. */
  reserved(what) { return this.value(`reserved.${what}`) }

  /** What a port takes when nothing bounds it. */
  fallback(what) { return this.value(`fallback.${what}`) }
}
