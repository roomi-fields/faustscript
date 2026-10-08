# FaustScript — le cadre

FaustScript est un sur-ensemble de Faust pour le live coding, et son transpileur : il lit un texte FaustScript ligne par ligne, applique chaque ligne comme un geste sur un graphe vivant d'instances nommées, et écrit le Faust que décrit ce graphe. Le paquet `faustscript` (`packages/040-faustscript`) porte cette frontière : un hôte crée une session par morceau, lui envoie du texte, et compile et joue le Faust qu'elle retourne avec la version de faustwasm que le paquet déclare.

## 1. Le rôle

- **R1.** FaustScript traduit du texte FaustScript en texte Faust : le programme entier du graphe, et, pour un geste qui change le circuit d'une instance, le Faust de cette seule instance.
- **R2.** FaustScript tient l'état d'un morceau comme un graphe d'instances et de câbles, un graphe par session ; une ligne de texte est le seul moyen de le changer.

## 2. Ce qu'il reçoit

- **R3.** À la création d'une session, le nombre de canaux de son bus master ; le catalogue appartient à la bibliothèque, qui le lit une fois pour toutes les sessions.
- **R4.** Ensuite, du texte FaustScript, tel que l'auteur l'a écrit, une ou plusieurs lignes à la fois.

## 3. Ce qu'il retourne

- **R5.** Pour chaque ligne qui porte une instruction, dans l'ordre : la ligne, le geste, l'instance qu'il a touchée, et soit son issue, soit son refus ; pour un geste qui recompile, le Faust de l'instance et les instances que ce Faust cite ; pour une définition Faust, les instances à recompiler ; pour un réglage, le port, la valeur et le chemin de contrôle. Une ligne vide ou un commentaire ne retourne rien.
- **R6.** Sur demande, le programme Faust entier du graphe à cet instant, une vue figée du graphe, la liste des contrôles du programme avec leurs chemins, bornes, unités, valeurs de départ et lissages, et le catalogue comme une valeur figée qui marque les modules que faustwasm ne fournit pas.
- **R17.** Pour un éditeur, l'analyseur de la grammaire, et ce qu'un texte ferait sur la session qui joue : ses refus comme diagnostics du Language Server Protocol, sans changer la session.

## 4. Ce qu'il connaît

- **R7.** La syntaxe de Faust et les modules que ses bibliothèques déclarent, avec leurs paramètres, valeurs de départ et bornes, par le catalogue, généré à partir des bibliothèques de la version de faustwasm que le paquet déclare.
- **R8.** Les signes de FaustScript, par la grammaire qui génère son analyseur et par les gabarits.

## 5. Ce qu'il ne connaît pas

- **R9.** L'hôte, le contexte audio, le temps musical, les scènes et les consommateurs de son paquet ; le compilateur Faust à l'exécution, que l'hôte appelle.

## 6. Ce qu'il refuse

- **R10.** Une ligne qui ne se lit pas, une expression vide, une forme inconnue, un nom déjà placé, un nom qui n'existe pas, un module que faustwasm ne fournit pas, un réglage incomplet ou qui vise un port que l'instance ne porte pas (un paramètre de son module, ou un `key=value` que son auteur a nommé dans son corps Faust), un port piloté par un signal qui porte l'une des entrées du programme, un câble qui n'existe pas, une définition Faust du nom d'une instance ou une instance sur le nom d'une définition Faust, un bus master doté de paramètres, une plage de canaux qui dépasse une largeur : le refus porte une faute avec les champs de celle de BPScript : un code stable, une phrase qui nomme la cause et le nom en jeu, les valeurs dont elle est écrite, et la position de l'écriture fautive ; la ligne ne change rien.
- **R11.** Une erreur que le compilateur Faust lève sur le Faust qu'écrit FaustScript reste le message du compilateur ; l'hôte la reçoit du compilateur.

## 7. Les invariants

- **R12.** Le même texte, dans le même ordre de gestes, donne le même résultat, au caractère près.
- **R13.** Une ligne refusée laisse le graphe tel qu'il était.
- **R14.** Les signes du langage vivent seulement dans la grammaire et dans les fichiers de `lib/`, que le code lit.
- **R15.** Tout le calcul du signal appartient à Faust, que FaustScript laisse tel que GRAME le publie ; sa sortie est du Faust que la version déclarée de faustwasm compile.
- **R18.** Le catalogue figé est le seul état que les sessions partagent.

## 8. Le coût

- **R16.** Une ligne appliquée a un coût mesuré, et un plafond qui ne fait que baisser. Un geste qui recompile retourne le Faust d'une seule instance, pour que l'hôte compile une instance au lieu du programme.
