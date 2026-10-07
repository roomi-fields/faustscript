# Suivi de la supervision

Tenu par la compétence `superviseur`. Une question s'écrit ici dès qu'elle naît ; tranchée, elle en
sort et sa réponse va dans son ticket.

## Dernier tour

- Date : 2026-10-07, après-midi.
- Chantier courant : faustx-zj5 (FaustX au niveau de BPScript).
- Agents lancés : zj5-7-exemples (faustx-zj5.7, `tests/unit/language-examples*`) ; zj5-27-releve
  (lecture seule : box API de faustwasm, conventions de paquets de bp-mono, imports de `src/`).
- Tickets de code suspendus derrière faustx-zj5.27 (paquets séparés) : rien ne bouge dans `src/`
  avant la structure.
- À vérifier au prochain tour : la fermeture de faustx-zj5.7 ; le relevé de zj5-27-releve.

## R — à confirmer par le responsable

- **Architecture en paquets (faustx-zj5.27)** — contexte : Romain a tranché « des paquets séparés
  c'est la convention » ; le découpage, la publication et la forme du composant Faust restent à
  griller. Recommandation : syntaxe, graphe, Faust (AST + imprimeur), catalogue, transpileur.
- **`docs/ARCHITECTURE.md` (faustx-zj5.3)** — écrit au dépôt, en attente de relecture ; remplacé
  en partie par la nouvelle architecture.

## S — à surveiller

- Le module FaustX de BPScript : la séance BPScript a reçu le matériau des §1, §4, §6 de l'ancienne
  fiche ; ferme quand bp-mono l'a versé.

## F — fermés

- Interface (faustx-zj5.2), spécification et principes (faustx-zj5.4), lexique (faustx-zj5.5),
  charte (faustx-zj5.6), alignement sur le lexique (faustx-zj5.23).
