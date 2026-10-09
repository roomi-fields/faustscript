# Index des interfaces

Généré par `node scripts/index-interfaces.mjs` depuis les `INTERFACE.md` ; ne pas éditer.
Une ligne par composant, puis une par élément qu'il fournit ; l'interface donne le détail.

## 040-faustscript — FaustScript — l'interface

Le paquet public de FaustScript, `faustscript` (`packages/040-faustscript`), exporte une seule fonction, `createSession`, qui retourne une session contenant un graphe d'instances et de câbles : le morceau joué. (`packages/040-faustscript/docs/INTERFACE.md`)

- **1. Le paquet** — Le paquet déclare `@grame/faustwasm` comme dépendance de pair à une version exacte, écrite dans son `package.json`.
- **2. `createSession`** — export function createSession(channels: number): Session Elle retourne une session dont le graphe est vide et dont le bus master, `process`, a `channels` canaux : l'hôte fixe ce nombre une fois, quand il crée la session, et chaque source vers le bus master s'y adapte (`LANGUAGE.md` §8).
- **3. La session** — export interface Session { apply(text: string): readonly LineResult[] write(): string graph(): GraphView controls(): readonly Control[] catalogue(): Catalogue
- **4. `apply` et le résultat d'une ligne** — `apply` reçoit du texte FaustScript, une ou plusieurs lignes, tel que l'auteur l'a écrit.
- **5. Les refus** — Une ligne refusée ne change rien au graphe, et les lignes qui la suivent s'appliquent.
- **6. `write`** — `write` retourne le programme Faust entier du graphe à cet instant : l'import de la bibliothèque, une définition par instance dans le flux, et `process`.
- **7. `graph`** — export interface GraphView { readonly instances: readonly InstanceView[] readonly wires: readonly WireView[] } export interface InstanceView { readonly name: string
- **8. `controls`** — export interface Control { readonly path: string readonly instance: string readonly port: string readonly min: number readonly max: number
- **9. `catalogue`** — export type Catalogue = Readonly<Record<string, CatalogueModule>> export interface CatalogueModule { readonly name: string readonly ports: readonly Port[] readonly unavailable: string | null }
- **10. `diagnose` et l'entrée de l'éditeur** — export interface Diagnostic { readonly range: Range readonly severity: 1 readonly code: RefusalCode readonly source: 'faustscript' readonly message: string
- **11. La ligne de commande** — faustscript <file.fsc> [-o <file.dsp>] [--channels <N>] faustscript --version La commande applique le fichier à une nouvelle session dont le bus master a les canaux que donne `--channels`, 2 quand l'option est absente, et écrit le programme Faust sur la sortie standard, ou dans le fichier que donne `-o`.
