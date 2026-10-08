# FaustScript — l'interface

Le paquet public de FaustScript, `faustscript` (`packages/040-faustscript`), exporte une seule fonction, `createSession`, qui retourne une session contenant un graphe d'instances et de câbles : le morceau joué. L'hôte envoie du texte FaustScript au `apply` de la session, qui applique chaque ligne comme un geste sur le graphe et retourne ce que chaque ligne a fait ; l'hôte lit le programme Faust, une vue figée du graphe, les contrôles du programme et le catalogue par quatre autres méthodes, et un éditeur lit par `diagnose` ce qu'un texte ferait sur la session, sous forme de diagnostics. Une seconde entrée, `faustscript/editor`, donne à un éditeur l'analyseur de la grammaire. Ce document liste chaque élément qui traverse cette frontière : sa forme, ce qu'il retourne, ce qu'il refuse, et le garde qui le tient.

## 1. Le paquet

| spécificateur | contenu |
| --- | --- |
| `faustscript` | `createSession` et les types des §2 à §10 |
| `faustscript/editor` | `parser` (§10) |
| commande `faustscript` | la ligne de commande (§11) |
| dépendance de pair `@grame/faustwasm` | la version de faustwasm avec laquelle l'hôte compile, à une version exacte |

Le paquet déclare `@grame/faustwasm` comme dépendance de pair à une version exacte, écrite dans son `package.json`. Le catalogue est généré à partir des bibliothèques Faust que cette version embarque, et les tests compilent avec elle le Faust qu'écrit FaustScript : l'hôte qui installe cette version joue le Faust que les tests ont vérifié.

Chaque nom, champ, geste, code, paramètre et forme de phrase de ce document est un contrat : en changer un est un changement incompatible, consigné dans `CHANGELOG.md` sous *Changed*. Changer la version de faustwasm déclarée est un changement de même nature.

**Garde** — le test d'interface (cible, faustx-zj5.36) : le paquet exporte exactement les éléments de cette liste, leurs types déclarés sont les signatures de ce document, et la version de faustwasm déclarée est celle que le catalogue enregistre et avec laquelle les tests compilent.

## 2. `createSession`

```ts
export function createSession(channels: number): Session
```

Elle retourne une session dont le graphe est vide et dont le bus master, `process`, a `channels` canaux : l'hôte fixe ce nombre une fois, quand il crée la session, et chaque source vers le bus master s'y adapte (`LANGUAGE.md` §8). Elle lève une `RangeError` quand `channels` n'est pas un entier positif. La bibliothèque lit le catalogue une fois, la première fois qu'une session en a besoin, et chaque session lit cette même valeur figée. Ce catalogue est le seul état que les sessions partagent : le même texte, appliqué à chacune dans le même ordre de gestes, retourne les mêmes résultats, au caractère près.

**Garde** — cible, faustx-zj5.12 : deux sessions qui reçoivent le même texte retournent des résultats égaux, et un signal calculé de la seconde session est nommé comme dans la première ; cible, faustx-zj5.54 : le programme que retourne `write` a autant de sorties que le bus master de la session a de canaux, et un nombre qui n'est pas un entier positif lève une erreur.

## 3. La session

```ts
export interface Session {
  apply(text: string): readonly LineResult[]
  write(): string
  graph(): GraphView
  controls(): readonly Control[]
  catalogue(): Catalogue
  diagnose(text: string): readonly Diagnostic[]
}
```

`apply` est la seule méthode qui change le graphe. `write`, `graph`, `controls`, `catalogue` et `diagnose` le lisent et ne changent rien.

## 4. `apply` et le résultat d'une ligne

`apply` reçoit du texte FaustScript, une ou plusieurs lignes, tel que l'auteur l'a écrit. Il applique les lignes dans l'ordre et retourne un résultat par ligne qui porte une instruction, dans le même ordre. Une ligne vide, ou une ligne qui ne contient qu'un commentaire, ne retourne aucun résultat ; les autres lignes gardent leur numéro dans le texte. Un résultat décrit sa ligne au moment où elle a été appliquée : une ligne ultérieure du même texte qui libère l'instance ne le change pas.

```ts
export type Gesture =
  | 'define'
  | 'place'
  | 'replace'
  | 'release'
  | 'remove'
  | 'bypass'
  | 'set'
  | 'wire'

export interface LineResult {
  readonly line: number
  readonly text: string
  readonly gesture: Gesture | null
  readonly name: string | null
  readonly outcome: Outcome
  readonly faust?: string
  readonly needs?: readonly string[]
  readonly recompile?: readonly string[]
  readonly port?: string
  readonly value?: string
  readonly path?: string
}

export type Outcome =
  | { readonly done: true }
  | { readonly done: false; readonly fault: Fault }
```

| champ | contenu |
| --- | --- |
| `line` | le numéro de la ligne dans le texte passé à `apply`, à partir de 1, lignes vides et commentaires comptés |
| `text` | la ligne, sans ses espaces autour |
| `gesture` | le geste qu'exprime la ligne ; `null` quand la ligne n'a aucune forme que la grammaire lit |
| `name` | l'instance que touche le geste, ou le nom auquel un `define` donne son sens Faust ; `null` pour un câble, un `import` et un `declare` |
| `outcome` | appliquée, ou refusée avec sa faute (§5) |
| `faust`, `needs` | présents quand un `place`, `replace`, `bypass` ou `remove` est appliqué : la définition Faust de cette seule instance, et les autres instances que cette définition cite, que l'hôte compile avec elle |
| `recompile` | présent quand un `define` est appliqué : les instances dont le corps cite le nom défini, ou chaque instance placée pour un `import` ou un `declare`, dans l'ordre où elles ont été placées, que l'hôte recompile |
| `port`, `value`, `path` | présents quand un `set` est appliqué : le port, la valeur telle qu'écrite, et le chemin de contrôle depuis la racine du programme |

Le geste dit ce que la ligne fait au graphe, et ce que l'hôte doit compiler :

| geste | ligne | effet sur le graphe | retourne |
| --- | --- | --- | --- |
| `define` | `gain = 0.25;`, `import("mes-modules.fsc");` | donne à `gain` son sens Faust, à la place d'une définition précédente ; un import ou une déclaration atteint chaque nom | `recompile` |
| `place` | `let lpf1 fi.lowpass(fc=800)` | ajoute l'instance `lpf1` | `faust`, `needs` |
| `replace` | `lpf1 fi.lowpass(fc=400)`, `lpfs:16` | remplace le corps de `lpf1`, dont le nom, les câbles, le nombre de copies et les réglages dont le nouveau corps porte le port restent ; ou le nombre de copies de `lpfs`, une instance sans nombre en ayant une, dont le corps, les câbles et les réglages restent | `faust`, `needs` |
| `release` | `!let lpf1` | supprime `lpf1` et ses câbles ; le nom redevient libre | — |
| `remove` | `! lpf1` | sort `lpf1` et ses câbles du flux ; le nom reste pris | `faust`, `needs` |
| `bypass` | `_ lpf1`, `!_ lpf1` | laisse passer le signal à côté de `lpf1`, ou remet `lpf1` | `faust`, `needs` |
| `set` | `lpf1.fc = 400` | enregistre la valeur du port `fc` | `port`, `value`, `path` |
| `wire` | `osc1 : lpf1`, `osc1 !: lpf1` | ajoute ou coupe des câbles | — |

**Les ports d'une instance.** Une instance dont le corps est un module porte les paramètres de ce module qui ne portent aucune nature (§9). Une instance dont le corps est une expression Faust porte les ports que son auteur a nommés dans ce corps : `let lpf1 fi.lowpass(3, cutoff=800)` porte le port `cutoff`. Un réglage ou un câble qui vise tout autre port est refusé (§5).

**Le chemin de contrôle.** Une instance devient un groupe Faust qui porte son nom, et un contrôle un curseur dans ce groupe : `let lpf1 fi.lowpass(fc=800)` écrit `lpf1 = vgroup("lpf1", fi.lowpass(4, hslider("fc…", 800, 2, 8000, …)));`, et `lpf1.fc = 400` retourne le chemin `/lpf1/fc`. Un `set` ne compile rien : l'hôte écrit la valeur sur le circuit en cours de jeu à ce chemin. Le préfixe qu'un programme compilé ajoute au-dessus de la racine du programme appartient à l'hôte.

**Garde** — `tests/unit/transpiler.test.js` (chaque geste dit ce qu'il a touché, et ce qui doit être recompilé ; un module piloté par un autre nomme ce dont il a besoin) ; cible, faustx-zj5.54 : un `define` retourne les instances dont le corps cite le nom, et un redimensionnement retourne `replace` avec le Faust de la banque ; cible, faustx-zj5.9 : un `set` retourne son port, sa valeur et son chemin ; cible, faustx-zj5.36 : une ligne vide et une ligne de commentaire ne retournent aucun résultat, et la ligne suivante garde son numéro ; le test d'interface.

## 5. Les refus

Une ligne refusée ne change rien au graphe, et les lignes qui la suivent s'appliquent. Son issue porte une faute : un code pris dans la liste fermée ci-dessous, la phrase qui nomme la cause et le nom en jeu, les valeurs dont cette phrase est écrite, et la position de l'écriture fautive. Le code est ce sur quoi l'hôte agit ; le message est ce que l'auteur lit ; la position est l'endroit où un éditeur la marque. Une faute a les champs de celle de BPScript, pour qu'un hôte qui joue les deux lise une seule forme.

```ts
export interface Fault {
  readonly code: RefusalCode
  readonly message: string
  readonly params: Readonly<Record<string, string>>
  readonly origin: Origin
}

export interface Origin {
  readonly line: number
  readonly column: number
  readonly endLine: number
  readonly endColumn: number
}

export type RefusalCode =
  | 'UNREADABLE'
  | 'EMPTY_EXPRESSION'
  | 'UNKNOWN_FORM'
  | 'ALREADY_PLACED'
  | 'UNKNOWN_NAME'
  | 'UNAVAILABLE_MODULE'
  | 'INCOMPLETE_SETTING'
  | 'UNKNOWN_PORT'
  | 'SETTING_FROM_INPUT'
  | 'NO_SUCH_WIRE'
  | 'NAME_IS_INSTANCE'
  | 'NAME_IS_DEFINITION'
  | 'MASTER_WITH_PARAMETER'
  | 'CHANNEL_OUT_OF_RANGE'
```

| code | la ligne | `params` | message |
| --- | --- | --- | --- |
| `UNREADABLE` | ne se lit pas par la grammaire | `text` | `does not read: <text>` |
| `EMPTY_EXPRESSION` | une expression sans terme | — | `empty expression` |
| `UNKNOWN_FORM` | une forme que la grammaire lit et qu'aucun geste ne traite | `form` | `unknown form: <form>` |
| `ALREADY_PLACED` | `let lpf1 …` quand `lpf1` est placé | `name` | `lpf1 is already placed` |
| `UNKNOWN_NAME` | nomme une instance qui n'existe pas, ou donne un nouveau corps à un nom qui n'est pas placé | `name` | `ghost does not exist` |
| `UNKNOWN_NAME` | écrit le dernier membre du nom d'un module du catalogue sans son préfixe, là où aucune instance ne le porte : `let lpf1 lowpass`, `saw1 : lowpass` | `name`, `modules` | `lowpass is not a module; fi.lowpass is` |
| `UNAVAILABLE_MODULE` | place ou donne un corps qui appelle un module que le faustwasm déclaré ne fournit pas : `let n1 no.rnoises` | `module`, `function` | `no.rnoises calls arc4random, which faustwasm does not provide` |
| `INCOMPLETE_SETTING` | un réglage sans son port ou sans sa valeur | `text` | `incomplete setting: <text>` |
| `UNKNOWN_PORT` | un réglage ou un câble qui vise un port que l'instance ne porte pas : `lpf1.nope = 3`, `osc1 : lpf1.nope` | `name`, `port` | `lpf1 has no port nope` |
| `SETTING_FROM_INPUT` | pilote un port par un signal qui porte une entrée du programme | `name` | `in1 carries one of the program's inputs: a port is driven by a signal, never by an input` |
| `NO_SUCH_WIRE` | `osc1 !: lpf1` là où aucun câble ne les relie | `from`, `to` | `no wire between osc1 and lpf1` |
| `NAME_IS_INSTANCE` | une définition Faust du nom d'une instance placée : `lpf1 = 3;` | `name`, `port`, `value` | `lpf1 is an instance; set a port (lpf1.fc = 3) or give the definition another name` |
| `NAME_IS_INSTANCE` | la même, quand l'instance ne porte aucun port : `let vca1 *` puis `vca1 = 3;` | `name` | `vca1 is an instance; replace its body (vca1 …) or give the definition another name` |
| `NAME_IS_DEFINITION` | `let gain …` quand une définition Faust donne `gain` | `name` | `gain is a Faust definition; give the instance another name` |
| `MASTER_WITH_PARAMETER` | une définition Faust qui donne des paramètres au bus master : `process(x) = x;` | `name` | `process is the master bus; it takes no parameter` |
| `CHANNEL_OUT_OF_RANGE` | une plage de canaux qui dépasse le dernier canal de sa source ou de sa destination : `src2.2 :4 dst3.1` quand `src2` en a 3 | `name`, `first`, `last`, `channels` | `src2 has 3 channels; 2 to 5 runs past them` |

`params` contient, sous les noms de sa colonne, les valeurs dont le message est écrit, telles qu'elles apparaissent dans la ligne ; pour `NAME_IS_INSTANCE`, `port` est le premier port que porte l'instance et `value` l'expression que donne la définition ; pour `CHANNEL_OUT_OF_RANGE`, `name` est l'extrémité que la plage dépasse, `first` et `last` les canaux que la plage atteint sur elle, et `channels` son nombre de canaux. `origin` est l'étendue de l'écriture fautive dans le texte passé à `apply` : le nœud que nomme le refus (le nom, le port, le câble), ou la ligne sans ses espaces autour pour `UNREADABLE`, `EMPTY_EXPRESSION` et `UNKNOWN_FORM`. Ses lignes se comptent à partir de 1 comme `line`, ses colonnes à partir de 1 en unités de code UTF-16 ; `endColumn` est juste après le dernier caractère.

Un module que faustwasm ne fournit pas est un module dont le Faust appelle une fonction étrangère que le backend WebAssembly de faustwasm refuse ; le catalogue le marque (§9), et sa phrase nomme cette fonction. Une erreur que le compilateur Faust lève sur le Faust qu'écrit FaustScript est le message du compilateur : l'hôte la reçoit du compilateur.

**Garde** — `tests/unit/transpiler.test.js` (une ligne fautive est refusée sans toucher au graphe ; un port ne peut pas être piloté par une entrée du programme ; un nom sans son préfixe est refusé, et sa phrase nomme les modules) ; `tests/unit/language-examples.test.js` (chaque exemple refusé de la référence du langage porte son code) ; cible, faustx-zj5.54 : `NAME_IS_INSTANCE`, `NAME_IS_DEFINITION`, `MASTER_WITH_PARAMETER` et `CHANNEL_OUT_OF_RANGE` sont produits par leurs lignes ; cible, faustx-zj5.9 : chaque code de la liste est produit par sa ligne avec ses paramètres et son origine, chaque refus porte un code de la liste, et la vue du graphe après une ligne refusée est égale à la vue d'avant.

## 6. `write`

`write` retourne le programme Faust entier du graphe à cet instant : l'import de la bibliothèque, une définition par instance dans le flux, et `process`. Dès qu'une instance alimente plus d'une destination, le programme s'écrit en étages. Un graphe vide donne un programme valide dont la sortie est silencieuse.

**Garde** — `tests/unit/transpiler.test.js` (les morceaux compilent ; un graphe vidé reste un programme valide et silencieux ; un signal partagé ne s'écrit qu'une fois) ; `tests/unit/references.test.js` (chaque morceau de `examples/` et chaque bloc d'exemples de `LANGUAGE.md` donne les résultats et le programme gravés sous `tests/references/`).

## 7. `graph`

```ts
export interface GraphView {
  readonly instances: readonly InstanceView[]
  readonly wires: readonly WireView[]
}

export interface InstanceView {
  readonly name: string
  readonly body: string
  readonly settings: Readonly<Record<string, string>>
  readonly bypassed: boolean
  readonly removed: boolean
  readonly computed: boolean
}

export interface WireView {
  readonly from: WireEnd
  readonly to: WireEnd
  readonly width: number | null
  readonly loop: boolean
}

export interface WireEnd {
  readonly name: string
  readonly port: string | null
  readonly channel: number | null
}
```

`graph` retourne une copie du graphe à l'instant de l'appel, figée en profondeur : un `apply` ultérieur ne la change pas, et écrire dedans lève une erreur sans atteindre le graphe. Les instances viennent dans l'ordre où elles ont été placées, les câbles dans l'ordre où ils ont été posés. `body` est le nom du module qu'appelle le corps, ou l'expression Faust du corps telle qu'écrite ; ses réglages sont dans `settings`. `removed` marque une instance sortie du flux, dont le nom reste pris ; `computed` marque un signal calculé, une instance que la session place sous un nom à elle pour une expression comme `lfo1 * 3800 + 400`. Une extrémité de câble dont le `port` n'est pas `null` pilote ce port de l'instance ; une extrémité de câble dont le `channel` n'est pas `null` est ce canal de l'instance, compté à partir de 1, le premier de la plage quand `width` n'est pas `null` ; le bus master est une extrémité de câble sous son nom réservé, `process`. `width` est le nombre de voies sur lesquelles court un câble, des copies entre deux noms (`saw1 :8 lpf1`) ou des canaux consécutifs après un canal (`src1.1 :4 dst1.1`), `null` quand il n'en nomme aucune ; `loop` marque un câble de réinjection, dont la sortie revient à l'entrée.

**Garde** — cible, faustx-zj5.36 : le test d'interface vérifie que la vue est figée en profondeur, qu'une écriture dedans lève une erreur et laisse `write()` inchangé, et qu'une vue prise avant un geste est la même après lui.

## 8. `controls`

```ts
export interface Control {
  readonly path: string
  readonly instance: string
  readonly port: string
  readonly min: number
  readonly max: number
  readonly unit: string | null
  readonly start: string
  readonly smoothing: string | null
}
```

`controls` retourne les contrôles du programme que `write` retourne au même instant, comme une valeur figée en profondeur : pour chaque instance dans le flux, dans l'ordre où les instances ont été placées, ses contrôles dans l'ordre où son corps les écrit. Un contrôle est un port qui a un réglage et des bornes (`LANGUAGE.md` §3.4). `path` est son chemin de contrôle depuis la racine du programme, celui que retourne un `set` ; `min` et `max` sont les bornes que porte le curseur ; `unit` est l'attribut `unit` du port, `null` quand il n'en a pas ; `start` est la valeur à laquelle le curseur démarre, telle qu'écrite ; `smoothing` est la fonction Faust que le programme applique à la valeur du contrôle avant que le circuit la lise (`si.smoo`), `null` quand la valeur entre telle quelle. L'hôte met ses valeurs à l'échelle des bornes et les écrit par chemin ; FaustScript ne met rien à l'échelle.

**Garde** — cible, faustx-zj5.36 : chaque contrôle qu'expose un programme compilé, lu dans la description que le compilateur donne de son interface, a une entrée avec le même chemin et les mêmes bornes, et aucune entrée ne manque de son contrôle.

## 9. `catalogue`

```ts
export type Catalogue = Readonly<Record<string, CatalogueModule>>

export interface CatalogueModule {
  readonly name: string
  readonly ports: readonly Port[]
  readonly unavailable: string | null
}

export interface Port {
  readonly name: string
  readonly start: string | null
  readonly min: number | null
  readonly max: number | null
}
```

`catalogue` retourne les modules que déclare le catalogue, chacun sous son nom Faust, préfixe compris (`fi.lowpass`), comme une valeur figée en profondeur, la même à chaque appel et pour chaque session. Un `Port` est un paramètre du module qui ne porte aucune nature (une fonction, un signal) : son nom, sa valeur de départ telle qu'écrite, et ses bornes. Chacun est un port des instances dont le corps appelle le module. `unavailable` est la fonction étrangère qu'appelle un module et que le faustwasm déclaré ne fournit pas, `null` pour un module qu'il compile ; placer un module dont le `unavailable` n'est pas `null` est refusé (§5).

**Garde** — `tests/unit/graph.test.js` (le catalogue porte chaque module que compte son en-tête) ; `tests/unit/catalogue-source.test.js` (un module que faustwasm refuse est marqué par la fonction qu'il appelle) ; cible, faustx-zj5.36 : le test d'interface vérifie que la valeur est figée en profondeur et qu'une écriture dedans lève une erreur.

## 10. `diagnose` et l'entrée de l'éditeur

```ts
export interface Diagnostic {
  readonly range: Range
  readonly severity: 1
  readonly code: RefusalCode
  readonly source: 'faustscript'
  readonly message: string
}

export interface Range {
  readonly start: Position
  readonly end: Position
}

export interface Position {
  readonly line: number
  readonly character: number
}
```

`session.diagnose(text)` dit ce qu'un texte ferait sur la session qui joue, dans l'état de son graphe à cet instant, et ne change rien : il lit les lignes comme `apply` le ferait, chacune dans l'état que laisseraient les lignes qui la précèdent, avec le bus master de la session et son nombre de canaux, et n'en garde aucun effet. Il retourne un diagnostic par ligne que `apply` refuserait, dans l'ordre des lignes : la faute du §5, imprimée sous la forme du Language Server Protocol. `range` est l'`origin` de la faute, ses lignes et caractères comptés à partir de 0 en unités de code UTF-16 dans le texte passé à `diagnose` ; `severity` vaut 1, une erreur ; `code` et `message` sont ceux de la faute.

```ts
import type { LRParser } from '@lezer/lr'

export const parser: LRParser
```

`faustscript/editor` sert un éditeur. `parser` est l'analyseur Lezer généré à partir de la grammaire de FaustScript, celui avec lequel la session lit : un éditeur CodeMirror construit son langage à partir de lui (`LRLanguage.define({ parser })`) et colore FaustScript par les noms de nœuds de la grammaire.

**Garde** — cible, faustx-zj5.36 : le test d'interface vérifie l'export de `parser` ; chaque exemple refusé de la référence du langage donne un diagnostic avec son code et l'étendue de l'origine de sa faute ; cible, faustx-zj5.54 : la vue du graphe, `write` et `controls` après `diagnose` sont égaux à ceux d'avant, et une ligne diagnostiquée sur une session donne le refus que donne `apply` sur cette session.

## 11. La ligne de commande

```
faustscript <file.fsc> [-o <file.dsp>] [--channels <N>]
faustscript --version
```

La commande applique le fichier à une nouvelle session dont le bus master a les canaux que donne `--channels`, 2 quand l'option est absente, et écrit le programme Faust sur la sortie standard, ou dans le fichier que donne `-o`. Chaque ligne refusée va sur la sortie d'erreur sous la forme `<file>:<line>:<column>: refused <CODE> — <message>`, la position étant l'origine de la faute, suivie de la ligne. Elle se termine avec le code 0 une fois le fichier lu, lignes refusées comprises, et avec le code 2 quand aucun fichier n'est donné ou quand `--channels` n'est pas un entier positif.

**Garde** — `tests/unit/transpiler.test.js` (la ligne de commande traduit un fichier) ; cible, faustx-zj5.54 : `--channels` fixe les sorties du programme écrit, 2 par défaut, et un nombre invalide termine la commande avec le code 2.
