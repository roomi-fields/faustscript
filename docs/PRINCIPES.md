# FaustScript — principes

Ce document énonce les directives qui valent pour tout le projet : chaque document de référence, chaque règle du dépôt et chaque ticket s'y conforme.

## 1. Le langage

- FaustScript est Faust pour le live coding. Il ajoute ce que le jeu en direct exige et que Faust n'a pas : placer une instance nommée, agir sur elle pendant que le son joue, et rendre son nom. Le calcul du signal reste celui des fonctions de Faust.
- FaustScript est à Faust ce que TypeScript est à JavaScript. Tout texte que la grammaire de Faust accepte est un texte FaustScript, avec son sens Faust. Un ajout occupe seulement une écriture que la grammaire de Faust refuse, une erreur de syntaxe : un symbole que Faust ne définit pas reste une écriture que Faust accepte, et qu'une bibliothèque peut définir plus tard.
- Chaque signe de FaustScript est un signe de Faust, décoré. `=` donne une valeur et `:` connecte, comme en Faust ; ce qui entoure le `:` le qualifie : `:8` sur huit copies, `!:` coupe. Le langage se compose des signes de Faust et de leurs décorations.
- `let` est la seule exception : Faust porte déjà `letrec`, et `let` est le mot le plus courant pour une liaison simple.
- Une décoration a un seul sens dans toutes les positions : un `!` devant annule le signe qu'il précède, un nombre après dit combien, un point entre dans une instance. Une règle qui vaut partout l'emporte sur plusieurs signes distincts.
- Une décoration sert un geste fait pendant que le son joue. Les constructions de Faust qui s'écrivent une fois — `seq`, `sum`, `prod`, la substitution — restent telles que Faust les écrit.
- Une écriture Faust reste toujours valide, et FaustScript ajoute au plus une écriture pour le même acte, une écriture décorée : `fi.lowpass(3, 800)` est l'appel de Faust, `fi.lowpass(N=3, fc=800)` son écriture FaustScript.
- Là où Faust a une convention, FaustScript la reprend : les canaux se comptent à partir de 1, le bus master est `process`, une entrée est `_`.
- FaustScript dérive ce qu'il sait dériver : toute autre valeur passe telle qu'elle est écrite.
- Le son continue quelle que soit l'écriture : les largeurs s'adaptent au lieu d'être refusées, et une ligne refusée laisse le graphe tel qu'il était pendant que le reste s'applique. FaustScript vérifie l'écriture : une ligne acceptée qui sonne faux reste acceptée.

## 2. Le transpileur

- Le transpileur écrit du Faust, et Faust le compile ; tout le calcul du signal appartient à Faust. Son rôle et sa frontière sont dans `packages/040-faustscript/docs/CADRE.md`.
- Les signes du langage vivent dans la grammaire et dans les fichiers de `lib/`, que le code lit ; renommer un signe ne change que ces fichiers.
- Le catalogue est généré à partir des bibliothèques de Faust par `tools/` ; il se corrige dans son générateur, puis se génère à nouveau.

## 3. Les documents

- `LANGUAGE.md` est la spécification : ce qu'il décrit existe, et un écart entre lui et le transpileur est un défaut du transpileur. Ses exemples sont exécutés par un test.
- Une règle est affirmative, au présent, sans date ni auteur ; elle dit ce qu'est la chose, avec sa raison.
- Une information vit à une seule adresse : un autre document qui en a besoin la cite par un renvoi.

## 4. L'arbitrage

Quand deux règles écrites se contredisent, la première force de cette liste qui s'applique l'emporte, et le choix la nomme. Deux règles de même force demandent une décision du responsable.

1. **Faust est la référence.** Une écriture que Faust lit garde le sens de Faust. Une affirmation sur ce que fait Faust cite son niveau : l'exécution du compilateur, puis son code source, puis sa documentation.
2. **Le son continue.** Entre refuser une écriture et lui donner le sens qui garde le son, le second l'emporte quand ce sens est unique.
3. **Les signes sont fixés.** Les signes du langage sont ceux de `LANGUAGE.md` ; une expressivité nouvelle compose les décorations existantes, et ajouter un signe est une décision du responsable.
4. **La dépendance va de l'hôte vers FaustScript.** Ce qui concerne les périphériques de sortie, le temps musical, les scènes ou la substitution d'une instance en cours de jeu appartient à l'hôte, qui connaît FaustScript.
5. **Une seule personne maintient le projet**, assistée d'agents. À mérite égal sur tout le reste, la solution qu'une seule personne peut maintenir l'emporte.
