# Suivi de la supervision

Tenu par la compétence `pitmaster`. Une question s'écrit ici dès qu'elle naît ; tranchée, elle en
sort et sa réponse va dans son ticket.

## Dernier tour

- Date : 2026-10-07, fin d'après-midi.
- Chantier courant : faustx-zj5 (FaustX au niveau de BPScript).
- La séance a redémarré : l'agent de faustx-zj5.7 est perdu ; ses deux fichiers
  `tests/unit/language-examples*.js` restent non suivis, ticket en cours. Un agent neuf le reprend.
- Tickets de code suspendus derrière faustx-zj5.27 (six paquets) : rien ne bouge dans `src/`
  avant la structure.
- À vérifier au prochain tour : la fermeture de faustx-zj5.7.

## R — à confirmer par le responsable

- **Le morceau joué (faustx-zj5.27, Q26)** — contexte : `createTranspiler()` crée en réalité un
  graphe vivant ; Romain : « FaustX est le transpileur FaustX il n'y e a qu'un ». Exemple : les
  tests créent un graphe neuf par test ; BPScript n'a pas tranché un graphe par scène, par acteur
  ou par séance. Référence mature : SuperCollider, un serveur et des espaces de proxys séparés ;
  TypeScript, un compilateur et un « programme » par projet. Existant : aucun. Exigence :
  déterminisme (deux graphes ne partagent rien). Recommandation : le transpileur est la
  bibliothèque et possède le catalogue lu une fois ; `createSession()` crée un morceau qui possède
  son graphe et son compteur. Question : le nom (`Session` ou autre).
- **`docs/ARCHITECTURE.md` (faustx-zj5.3)** — écrit au dépôt, en attente de relecture ; il sera
  remplacé par l'architecture en six paquets.

## S — à surveiller

- Le module FaustX de BPScript : la séance BPScript a reçu le matériau des §1, §4, §6 de l'ancienne
  fiche ; ferme quand bp-mono l'a versé.

## F — fermés

- Interface (faustx-zj5.2), spécification et principes (faustx-zj5.4), lexique (faustx-zj5.5),
  charte (faustx-zj5.6), alignement sur le lexique (faustx-zj5.23), « Comment on arbitre »
  (faustx-zj5.27, Q18–Q20).
- Grill faustx-zj5.27 : six paquets (Q15), un seul paquet public `040-faustx` (Q16), dossiers
  numérotés comme BPScript (Q17), faute propre aux champs de BPScript (Q21), corps typé lu une fois
  (Q22), citations tenues par le graphe (Q23), largeurs déclarées (Q24), fichier des modèles
  dissous (Q25).
