# Index des interfaces

Généré par `node scripts/index-interfaces.mjs` depuis les `INTERFACE.md` ; ne pas éditer.
Une ligne par composant, puis une par élément qu'il fournit ; l'interface donne le détail.

## 040-faustscript — FaustScript — l'interface

Le paquet public de FaustScript, `faustscript` (`packages/040-faustscript`), exporte une seule fonction, `createSession`, qui retourne une session contenant un graphe d'instances et de câbles : le morceau joué. (`packages/040-faustscript/docs/INTERFACE.md`)

- **1. Le paquet** — Le paquet déclare `@grame/faustwasm` comme dépendance de pair à une version exacte, écrite dans son `package.json`.
- **2. `createSession`** — Elle retourne une session dont le graphe est vide et dont le bus master, `process`, a `channels` canaux : l'hôte fixe ce nombre une fois, quand il crée la session, et chaque source vers le bus master s'y adapte (`LANGUAGE.md` §8).
- **3. La session** — `apply` est la seule méthode qui change le graphe.
- **4. `apply` et le résultat d'une ligne** — `apply` reçoit du texte FaustScript, une ou plusieurs lignes, tel que l'auteur l'a écrit.
- **5. Les refus** — Une ligne refusée ne change rien au graphe, et les lignes qui la suivent s'appliquent.
- **6. `write`** — `write` retourne le programme Faust entier du graphe à cet instant : l'import de la bibliothèque, une définition par instance dans le flux, et `process`.
- **7. `graph`** — `graph` retourne une copie du graphe à l'instant de l'appel, figée en profondeur : un `apply` ultérieur ne la change pas, et écrire dedans lève une erreur sans atteindre le graphe.
- **8. `controls`** — `controls` retourne les contrôles du programme que `write` retourne au même instant, comme une valeur figée en profondeur : pour chaque instance dans le flux, dans l'ordre où les instances ont été placées, ses contrôles dans l'ordre où son corps les écrit.
- **9. `catalogue`** — `catalogue` retourne les modules que déclare le catalogue, chacun sous son nom Faust, préfixe compris (`fi.lowpass`), comme une valeur figée en profondeur, la même à chaque appel et pour chaque session.
- **10. `diagnose` et l'entrée de l'éditeur** — `session.diagnose(text)` dit ce qu'un texte ferait sur la session qui joue, dans l'état de son graphe à cet instant, et ne change rien : il lit les lignes comme `apply` le ferait, chacune dans l'état que laisseraient les lignes qui la précèdent, avec le bus master de la session et son nombre de canaux, et n'en garde aucun effet.
- **11. La ligne de commande** — La commande applique le fichier à une nouvelle session dont le bus master a les canaux que donne `--channels`, 2 quand l'option est absente, et écrit le programme Faust sur la sortie standard, ou dans le fichier que donne `-o`.
