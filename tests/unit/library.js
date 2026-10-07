// The texts of lib/ the tests read: the catalogue of Faust's modules (lib/faust.fsc) and the
// translation templates (lib/translation.fsc).
import { readFileSync } from 'node:fs'

const lib = name => readFileSync(new URL(`../../lib/${name}`, import.meta.url), 'utf8')

export const CATALOGUE = lib('faust.fsc')
export const TEMPLATES = lib('translation.fsc')
