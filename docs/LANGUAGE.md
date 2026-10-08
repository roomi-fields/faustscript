# FaustScript — le langage

FaustScript est Faust avec des instances nommées. Un texte FaustScript est une suite de lignes ; chaque ligne place une instance, connecte des instances, règle un port, change une instance déjà placée, ou définit en Faust, et le transpileur écrit le programme Faust que décrit le graphe qui en résulte. FaustScript est à Faust ce que TypeScript est à JavaScript : tout texte que la grammaire de Faust accepte garde son sens Faust, et FaustScript ne donne un sens qu'aux écritures que la grammaire de Faust refuse. Ce document est la spécification du langage : ce qu'il décrit existe, et un écart entre lui et le transpileur est un défaut du transpileur.

## 1. Lignes et signes

### 1.1 Deux sortes de ligne

Une ligne qui commence comme une définition Faust est du Faust jusqu'à son `;`, et elle peut courir sur plusieurs lignes : un nom ou un nom avec ses paramètres suivi de `=`, un `import(`, un `declare`. Toute autre ligne est une ligne FaustScript — elle place, connecte, règle ou change une instance — et se termine au retour à la ligne ; les lignes indentées sous la déclaration d'un module lui appartiennent (§3.2). Un commentaire commence par `//` et court jusqu'à la fin de la ligne.

```faustscript
gain = 0.5;                          // a Faust definition, up to its ;
voice(f) = os.sawtooth(f)
  : fi.lowpass(2, 800);              // a Faust definition over two lines
let lpf1 fi.lowpass(fc=800)          // a FaustScript line, up to the newline
let = 1;                             // a Faust definition of the identifier let
voix2(f) = os.sawtooth(freq=f) : fi.lowpass(fc=800);  // named settings in a Faust definition
```

Une définition Faust donne les paramètres d'un module par leur nom, `freq=f`, comme le fait une ligne FaustScript : la grammaire de Faust refuse `=` dans un appel. Les décorations du câblage restent sur les lignes de câblage (§4.1).

Une définition Faust d'un nom est le geste `define`. Elle donne au nom son sens Faust pour tout le texte, et chaque instance dont le corps cite ce nom est recompilée avec la nouvelle définition ; une définition ultérieure du même nom remplace la précédente.

```faustscript
gain = 0.5;
let vca1 *(gain)
gain = 0.25;                         // defines gain again: vca1 is recompiled
```

Une définition Faust du nom d'une instance placée est refusée : le nom désigne l'instance, qui change par ses ports (§6) ou par un nouveau corps (§5).

```faustscript
let hpf1 fi.highpass
hpf1 = 3;                            // refused: NAME_IS_INSTANCE
```

De la même manière, un `let` sur un nom que donne une définition Faust est refusé : le nom désigne la définition.

```faustscript
level = 0.5;
let level os.osc                     // refused: NAME_IS_DEFINITION
```

Une ligne `import` ou `declare` est aussi le geste `define`. Un import peut changer le sens de n'importe quel nom, donc chaque instance placée est recompilée.

Un texte envoyé pendant que le son joue s'applique au graphe tel qu'il est, et un fichier est la même suite de lignes appliquée à un graphe vide.

### 1.2 `=` donne une valeur, `:` connecte

En Faust, `=` donne à un nom sa définition et `:` connecte un circuit au suivant. FaustScript garde les deux sens et écrit `=` là où la grammaire de Faust le refuse, pour donner une valeur à un port, à un attribut ou à un paramètre :

| écriture | donne une valeur à |
| --- | --- |
| `lpf1.fc = 400` | un port (§6) |
| `lpf1.fc.min = 20` | un attribut d'un port (§6) |
| `fi.lowpass(fc=800)` | un paramètre, dans un appel (§3.1) |
| `fi.lowpass(N=4, fc=2000)` | la valeur de départ d'un paramètre, dans une déclaration (§3.2) |

Le nom vient d'abord, sa valeur après. Le `:` ne fait que connecter, et ses décorations qualifient la connexion.

### 1.3 Les trois décorations

FaustScript qualifie les signes de Faust par trois décorations, chacune avec un seul sens dans toutes les positions :

| décoration | sens | exemples |
| --- | --- | --- |
| un `!` devant | annule le signe qu'il précède | `!:` `!~` `!let` `!_` |
| un nombre après | dit combien | `:8` `~4` `lpfs:8` |
| un point | entre dans une instance | `lpf1.fc` `saw1.3` `lpf1.fc.min` |

### 1.4 Les espaces

Les espaces séparent les mots comme en Faust, et un signe FaustScript se lit par sa place dans la ligne. Deux écritures sont fixées : `_lpf1` est un seul identifiant Faust, donc le bypass s'écrit `_ lpf1` ; le `!` qui annule un signe lui est collé : `!:`, `!~`, `!let`, `!_`.

Sur une ligne de câblage, un nombre après `:`, collé ou espacé, dit sur combien de voies court le câble : des copies, ou des canaux (§4.1). Un nombre négatif s'écrit comme en Faust, un `-` devant le nombre, partout où Faust accepte un nombre.

```faustscript
let saw1 os.sawtooth
let lpf1 fi.lowpass
saw1 : 8 lpf1                        // eight copies, as saw1 :8 lpf1
let gate1 ef.gate_mono(thresh=-40)   // a negative number, in a named setting
let gate2 ef.gate_mono(-40, 0.001, 0.1, 0.05)  // a negative number, in Faust's order
```

## 2. Placer une instance

### 2.1 `let`

`let` place une instance et la nomme : le premier mot est le nom, le reste de la ligne est le corps.

```faustscript
let lpf1 fi.lowpass                  // one instance, every parameter at its starting value
let lpf2 fi.lowpass(fc=400)          // one parameter given
let lpfs:8 fi.lowpass                // a bank of eight
let voix:8 os.sawtooth : fi.lowpass  // eight complete chains
let vca1 *                           // any Faust expression is a body
```

Le corps est du Faust : `:` et `~` y gardent leur sens Faust, et FaustScript ne décore que les appels aux modules (§3.1). Une répétition dans un corps s'écrit comme Faust l'écrit, `par(i, 8, …)`.

`let` est un mot FaustScript en début de ligne suivi d'un nom. Ailleurs, c'est un identifiant Faust ordinaire, et `let = 1;` est une définition Faust (§1.1).

Un nom se place une fois. Un second `let` sur un nom placé est refusé, comme Faust refuse une seconde définition d'un identifiant :

```faustscript
let lpf1 fi.lowpass
let lpf1 fi.lowpass                  // refused: ALREADY_PLACED
```

`let` s'écrit à la racine du texte. Les portées locales de Faust — `with{}`, `letrec{}`, `environment{}` — gardent leur sens Faust et ne contiennent aucun `let`, parce qu'une instance nommée à l'intérieur ne pourrait pas être atteinte de l'extérieur.

### 2.2 Un nom désigne une seule instance

Un nom placé par `let` désigne une seule instance ; le `=` de Faust désigne une définition que chaque usage copie. Employer un nom de `let` à deux endroits connecte deux fois le même circuit : l'instance somme ce qui y entre et envoie sa sortie à chaque destination, comme le fait un départ d'effet.

```faustscript
let voix1 os.sawtooth
let voix2 os.sawtooth(freq=165)
let rev1 re.mono_freeverb
voix1 : rev1                         // both voices enter the same reverb
voix2 : rev1
rev1 : process
```

### 2.3 Les banques et le rang `i`

Un nombre après le nom déclaré fait désigner au nom autant de copies du corps : `let lpfs:8 fi.lowpass` est le `par(i, 8, fi.lowpass)` de Faust. Le nombre appartient au nom, donc un corps fait de plusieurs modules n'a pas besoin de parenthèses : `let voix:8 os.sawtooth : fi.lowpass`. Le point atteint alors une copie, comptée à partir de 1 (`lpfs.3`), et le nom seul les atteint toutes.

`i` est le rang de la copie dans une banque, à partir de 0, comme dans le `par(i, N, …)` de Faust. Il permet aux copies de différer ; huit copies identiques seraient réduites par Faust à un seul circuit.

```faustscript
let clic:6 fi.resonbp(fc=311 * 1.5^i, Q=40)  // six resonators, six pitches
let voix:8 os.sawtooth(freq=110 * (i+1))     // eight harmonics
```

`i` n'a de sens que dans le corps d'une banque.

Le nombre de copies est une constante pour Faust. Un nom placé suivi d'un nombre, seul sur sa ligne, donne à l'instance autant de copies de son corps ; son corps, ses câbles et ses réglages restent. Une instance placée sans nombre a une copie, et la même ligne en fait une banque. Un nouveau corps garde le nombre de copies (§5).

```faustscript
let lpfs:8 fi.lowpass(fc=800)
lpfs:16                              // the bank becomes sixteen filters
lpfs fi.highpass                     // sixteen high-pass filters, fc stays 800
let hpf2 fi.highpass
hpf2:4                               // hpf2 becomes a bank of four
```

Un nombre entre deux noms est toujours un câble : `lpfs:16 lpf2` connecte `lpfs` à `lpf2` sur seize copies (§4.1).

## 3. Les modules

### 3.1 Le catalogue

Un module est une fonction Faust que le catalogue déclare avec les noms de ses paramètres et leurs valeurs de départ. Le catalogue, `lib/faust.fsc`, déclare les fonctions publiques des bibliothèques de Faust sous les noms de Faust, préfixe compris : `fi.lowpass`, `os.osc`, `re.mono_freeverb`. Deux bibliothèques qui définissent le même nom donnent deux modules, `ma.SR` et `pl.SR`, et une nouvelle version d'une bibliothèque ajoute un module sans changer le sens d'un nom déjà écrit.

Un module s'écrit comme Faust écrit la fonction, et FaustScript décore l'appel : `fi.lowpass(fc=800)` donne ses paramètres par leur nom, dans n'importe quel ordre. Le nom sans son préfixe ne désigne aucun module, et le refus nomme les modules dont il termine le nom :

```faustscript
let lpf1 lowpass                     // refused: UNKNOWN_NAME
```

### 3.2 Déclarer un module

Une déclaration donne le nom du module, ses paramètres avec leurs valeurs de départ, puis son corps ; les lignes qui suivent règlent les attributs de ses paramètres.

```faustscript
fi.lowpass(N=4, fc=2000)  fi.lowpass(N, fc)
  fc.min = 2
  fc.max = 8000
  fc.scale = log
  fc.unit = Hz
```

Le même mot nomme le paramètre dans le corps, le port d'une instance, et l'attribut qui le borne. Le corps appelle les modules déjà déclarés par leurs noms, ou Faust tel quel.

```faustscript
voix(freq=110, fc=800)  os.sawtooth(freq=freq) : fi.lowpass(fc=fc)
```

### 3.3 Un appel dans l'ordre de Faust

Un appel qui passe un argument sans son nom s'écrit dans l'ordre des arguments de Faust et garde le sens de Faust : `fi.lowpass(3, 800)` est l'appel de Faust. Une fonction Faust que le catalogue ne déclare pas s'appelle ainsi. Dans un tel appel, un argument écrit `key=value` devient un port que l'auteur nomme ; les noms des paramètres de Faust ne peuvent pas servir, puisqu'ils sont hors de portée au point d'appel.

```faustscript
let lpf1 fi.lowpass(3, cutoff=800)   // Faust's order, a port named cutoff
```

### 3.4 Les ports

Un port est ce qu'un réglage ou un câble vise sur une instance, par son nom après le point : chaque paramètre du module de l'instance qui ne porte aucune nature, ou chaque `key=value` que l'auteur a nommé dans un appel dans l'ordre de Faust (§3.3). Un port qui n'est pas écrit reste une constante, que Faust précalcule ; un contrôle coûte du calcul, donc on nomme ce qu'on contrôle.

Un port écrit dont les bornes sont connues devient un contrôle, un curseur entre ces bornes. Les bornes viennent du catalogue, ou de `min` et `max` écrits sur l'instance. Un port sans bornes reste une constante : FaustScript ne devine aucune plage, et l'auteur donne `min` et `max` pour rendre le port contrôlable.

Régler un port qui est encore une constante recompile l'instance, pour que le contrôle existe.

Un paramètre que Faust exige constant à la compilation — l'ordre `N` d'un filtre, la taille `n` d'un retard — est marqué constant par le catalogue. Le régler recompile l'instance avec la nouvelle valeur, et il ne devient jamais un contrôle :

```faustscript
let lpf1 fi.lowpass
lpf1.N = 5                           // recompiles lpf1 as a filter of order 5
```

Les attributs sont ceux que Faust lit entre crochets dans l'étiquette d'un contrôle : `min`, `max`, `scale`, `unit`, `style`, `midi`, `osc`. FaustScript transmet le mot à Faust.

## 4. Connecter

### 4.1 Les câbles

Une ligne de câblage connecte des instances placées. Elle s'écrit à la racine du texte, là où la grammaire de Faust refuse une expression nue ; sur elle, `:`, `!:`, `:8`, `~`, `~4`, `!~` et un port comme cible sont à FaustScript. Dans un corps (§2.1) et dans une définition Faust (§1.1), `:` et `~` gardent leur sens Faust.

```faustscript
let saw1 os.sawtooth
let lpf1 fi.lowpass
saw1 : lpf1                          // connects
saw1 !: lpf1                         // cuts
saw1 :8 lpf1                         // connects as eight copies
```

Un nombre après le deux-points, collé ou espacé, dit sur combien de voies court le câble. Entre deux noms, une voie est une copie : `saw1 :8 lpf1` est le `par(i, 8, saw1) : par(i, 8, lpf1)` de Faust, il répète le circuit et ne déclare aucun nom. Après un canal, une voie est un canal, et le câble porte autant de canaux consécutifs (§7).

Une ligne envoyée seule ajoute ses câbles au graphe : `voix2 : rev1` ajoute une branche et laisse les autres. Le `,` de Faust empile deux circuits qui gardent leurs propres entrées et sorties, et reste disponible dans une expression ; le parallèle du studio, le `A <: (X, Y) :> B` de Faust, est ce qu'écrivent deux câbles vers une même instance.

| signe de Faust | ce qu'il fait | en FaustScript |
| --- | --- | --- |
| `:` | série | `:8` sur huit voies, `!:` coupe, et les largeurs s'adaptent (§4.2) |
| `,` | empile | inchangé |
| `<:` | répartit | s'écrit en connectant une instance à plusieurs |
| `:>` | fusionne | s'écrit en connectant plusieurs instances à une seule |
| `~` | réinjecte | `~4` canaux renvoyés, `!~` ouvre (§4.4) |

### 4.2 Les largeurs s'adaptent

Un câble entre deux largeurs que le `:` de Faust refuserait s'écrit comme le routage qui convient :

| ce qui arrive | ce qui se passe |
| --- | --- |
| un canal vers plusieurs | il est envoyé à tous |
| plusieurs canaux vers l'entrée d'une instance | ils sont sommés |
| plusieurs canaux vers un port nommé | le premier canal est pris |
| des largeurs sans rapport entier | la destination prend le nombre de canaux qu'elle accepte |

Le point distingue les deux cas du milieu : l'entrée d'une instance porte de l'audio, qui se somme ; un port nommé porte un contrôle, qui prend une seule valeur. Plusieurs câbles vers un même port sont sommés, comme un départ d'effet somme ses sources.

### 4.3 Un câble coupé porte du silence

Couper un câble laisse la largeur de la destination inchangée : l'entrée que le câble alimentait reçoit zéro. Dans l'exemple ci-dessous, `basse !: vcab` fait taire la branche de la basse ; l'autre branche n'est pas envoyée dans l'entrée libérée.

```faustscript
let basse os.sawtooth(freq=55)
let nappe os.sawtooth(freq=220)
let vcab si.bus(2) :> _
basse : vcab
nappe : vcab
vcab : process
basse !: vcab
```

### 4.4 La réinjection

`~` renvoie la sortie d'une instance vers son entrée, avec le retard d'un échantillon que Faust place.

```faustscript
let dly1 de.delay(4096, 1000)
let fb1 _ * 0.5
dly1 ~ fb1                           // closes the loop
dly1 !~ fb1                          // opens it
dly1 ~4 fb1                          // four channels return, the others stay free
```

Le nombre dit combien de canaux reviennent ; les entrées qui ne reçoivent aucun retour restent des entrées du circuit.

| Faust | entrées | sorties |
| --- | --- | --- |
| `par(i,8,+) ~ par(i,8,_)` — huit reviennent | 8 | 8 |
| `par(i,8,+) ~ par(i,4,_)` — quatre reviennent | 12 | 8 |
| `par(i,8,+) ~ _` — un revient | 15 | 8 |

Un retour vers une entrée qui reçoit déjà un câble est sommé avec ce câble, comme plusieurs câbles vers une même entrée sont sommés (§4.2) : avec `src1 : dly1`, la boucle `dly1 ~ fb1` est le `(+ : dly1) ~ fb1` de Faust, alimenté par `src1`.

```faustscript
let src1 os.sawtooth
let dly1 de.delay(4096, 1000)
let fb1 _ * 0.5
src1 : dly1
dly1 ~ fb1                           // the return is summed with src1
dly1 : process
```

## 5. Changer une instance placée

```faustscript
let lpf1 fi.lowpass
lpf1 fi.lowpass(fc=400)              // replaces its body
_ lpf1                               // bypasses it
!_ lpf1                              // puts it back in the flow
! lpf1                               // removes it from the flow, with its wires
!let lpf1                            // gives its name back
```

Un nom placé suivi d'un corps remplace le corps ; l'instance garde son nom, ses câbles, son nombre de copies, et les réglages dont le nouveau corps porte le port. Ce que devient l'état du circuit en cours de jeu appartient à l'hôte, qui substitue l'instance compilée. `let` place, le nom seul remplace. Le corps d'un remplacement commence par un nom : `vca1 *` se lirait comme une multiplication inachevée, donc un remplacement par un opérateur passe par un module déclaré.

Remplacer un corps change le circuit ; un bypass laisse le corps et change la place de l'instance dans le flux : l'instance contournée reçoit du silence, le signal passe à côté d'elle, et sa sortie reste sommée, si bien que ce qui résonne en elle s'éteint. Le `ba.bypass_fade` de Faust efface au contraire l'état du module.

`! lpf1` sort l'instance du flux avec tous ses câbles ; le nom reste placé, et rien n'y entre, si bien que sa queue s'éteint. `!let lpf1` supprime l'instance et ses câbles et libère le nom. Quand une instance ou une boucle quitte le programme — `!let`, `!~` — l'hôte décide de la façon dont son son se termine.

Une instance qu'aucun câble ne touche garde son nom et sa définition, que l'hôte peut compiler seule, et reste hors de `process`. Une fois la boucle ouverte, `fb1` est une telle instance :

```faustscript
let dly1 de.delay(4096, 1000)
let fb1 _ * 0.5
dly1 ~ fb1
dly1 : process
dly1 !~ fb1                          // fb1 stays placed, out of process
```

Deux façons de recommencer, et l'auteur choisit :

```faustscript
let rev1 re.mono_freeverb
rev1 re.mono_freeverb(damp=0.9)      // the same instance, with its settings
!let rev1
let rev1 re.mono_freeverb(damp=0.9)  // a new instance, from the module's starting values
```

## 6. Les réglages

```faustscript
let lpf1 fi.lowpass(fc=800)
let lfo1 os.osc(freq=0.2)
lpf1.fc = 400                        // one port
lpf1(fc=400, N=5)                    // several at once
lpf1.fc.min = 20                     // an attribute of the port
lfo1 : lpf1.fc                       // a signal drives the port
```

Le point règle un port, les parenthèses plusieurs. Les attributs d'un port s'atteignent de la même manière. Ce qui est écrit sur l'instance l'emporte sur ce que le catalogue donne au module.

Un signal connecté à un port est remis à l'échelle de la plage du module qui l'émet vers les bornes du port, avec le `it.remap` de Faust : un `os.osc` de -1 à 1 balaie `lpf1.fc` de 2 à 8000 Hz. Quand l'une des deux plages est inconnue, le signal passe tel quel, et l'auteur écrit la mise à l'échelle :

```faustscript
let lfo1 os.osc(freq=0.2)
let lpf1 fi.lowpass(fc=800)
lfo1 : it.remap(-1, 1, 140, 900) : lpf1.fc
```

Un port est piloté par un signal, jamais par l'une des entrées du programme :

```faustscript
let micro _
let lpf1 fi.lowpass(fc=800)
micro : lpf1.fc                      // refused: SETTING_FROM_INPUT
```

## 7. Les canaux

Un point suivi d'un nombre désigne un canal, compté à partir de 1 comme le `route` de Faust les compte. FaustScript écrit le `route` qui ne porte que les canaux nommés.

```faustscript
let src1 si.bus(4)
let dst1 si.bus(8)
let lpfs:8 fi.lowpass
src1.3 : dst1.5                      // channel 3 into channel 5
lpfs.3.fc = 400                      // the third filter of the bank
```

Dans une banque de corps à un canal, le canal est la copie : `lpfs.3` est le troisième filtre.

Un nombre après le deux-points qui suit un canal porte autant de canaux consécutifs, à partir du canal nommé de chaque côté : `src1.1 :4 dst1.1` route les canaux 1 à 4 de `src1` vers les canaux 1 à 4 de `dst1`. Une source se répartit sur plusieurs destinations par une ligne par plage.

```faustscript
let src1 si.bus(7)
let dst1 si.bus(4)
let lpf1 fi.lowpass
let dst2 si.bus(2)
src1.1 :4 dst1.1                     // channels 1 to 4 into channels 1 to 4 of dst1
src1.5 : lpf1                        // channel 5 into lpf1
src1.6 :2 dst2.1                     // channels 6 and 7 into channels 1 and 2 of dst2
```

Une plage qui dépasse le dernier canal de sa source ou de sa destination est refusée, et la ligne ne change rien :

```faustscript
let src2 si.bus(3)
let dst3 si.bus(4)
src2.2 :4 dst3.1                     // refused: CHANNEL_OUT_OF_RANGE
```

## 8. Le bus master et les entrées

`process` est le bus master : il mélange les sources qui y arrivent dans la sortie du programme. C'est le nom propre de Faust ; FaustScript écrit `process = <what arrives>`, et plusieurs sources vers lui sont sommées. Son nombre de canaux est fixé par l'hôte quand il crée la session, et chaque source s'y adapte selon §4.2 : une source à un canal est envoyée à chaque canal, une source aussi large que le bus master entre canal par canal. Un point atteint l'un de ses canaux, comme sur toute instance. Les exemples de ce document jouent sur un bus master à deux canaux.

```faustscript
let saw1 os.sawtooth
let lpf1 fi.lowpass
let rev1 re.stereo_freeverb
saw1 : lpf1 : process                // sounds
lpf1 !: process                      // no longer goes out
lpf1 : rev1
rev1.1 : process.1                   // a stereo output
rev1.2 : process.2
```

Une définition Faust de `process` est une source de plus vers le bus master, sommée avec les câbles vers `process`. La définir à nouveau remplace cette définition et laisse les câbles.

```faustscript
let saw1 os.sawtooth
saw1 : process
process = no.noise * 0.1;            // the noise is summed with saw1
process = no.noise * 0.05;           // replaces the noise, saw1 stays
```

Le bus master ne prend aucun paramètre : une définition Faust qui donne des paramètres à `process` est refusée.

```faustscript
process(x) = x * 0.5;                // refused: MASTER_WITH_PARAMETER
```

Une entrée est le fil `_` de Faust, écrit dans une chaîne ou placé sous un nom ; les deux écritures sont du FaustScript.

```faustscript
let lpf1 fi.lowpass
_ : lpf1 : process                   // the first input through a filter
```

```faustscript
let micro _
let lpf1 fi.lowpass
micro : lpf1 : process
micro !: lpf1                        // unplugs the microphone from the filter
```

L'ordre dans lequel les entrées sont placées est leur ordre sur le programme : le premier `let … _` est l'entrée 1. Le nombre d'entrées découle du circuit, comme en Faust.

## 9. Les imports

Le transpileur importe la bibliothèque standard de Faust et le catalogue dans chaque programme : `fi.lowpass` n'a besoin d'aucun import. Un programme Faust qui écrit ses propres imports les garde ; une ligne `import` est le geste `define` et recompile chaque instance placée (§1.1).

```faustscript
import("mes-modules.fsc");           // as in Faust
```

## 10. Une ligne refusée

Une ligne que le transpileur refuse ne change rien au graphe, et les lignes qui la suivent s'appliquent ; ce qui joue continue de jouer. Une ligne acceptée qui sonne faux reste acceptée : FaustScript vérifie l'écriture, pas la musique. Les refus et leurs codes sont listés dans `packages/040-faustscript/docs/INTERFACE.md` §5.

## 11. Aide-mémoire

| écriture | ce qu'elle fait |
| --- | --- |
| `name = expr;` | définit en Faust, jusqu'au `;` (`define`) |
| `let lpf1 fi.lowpass` | place une instance |
| `let lpfs:8 fi.lowpass` | place une banque de huit |
| `lpfs:16` | redimensionne la banque à seize |
| `i` | le rang de la copie, dans une banque |
| `lpf1 fi.lowpass(fc=400)` | remplace son corps |
| `_ lpf1` · `!_ lpf1` | la contourne · la remet |
| `! lpf1` | la retire du flux, avec ses câbles |
| `!let lpf1` | rend son nom |
| `saw1 : lpf1` · `saw1 !: lpf1` | connecte · coupe |
| `saw1 :8 lpf1` | connecte sur huit copies |
| `dly1 ~ fb1` · `dly1 !~ fb1` | réinjecte · ouvre la boucle |
| `lpf1.fc = 400` · `lpf1(fc=400, N=5)` | règle un port · plusieurs |
| `lpf1.fc.min = 20` | règle un attribut |
| `saw1.3` | un canal |
| `src1.1 :4 dst1.1` | quatre canaux consécutifs |
| `: process` | vers le bus master |
| `process = expr;` | une source de plus vers le bus master |
| `_` | une entrée |
| `name(p=1) body` | déclare un module |
