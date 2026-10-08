# Suivi de la supervision

Tenu par la compétence `pitmaster`. Une question s'écrit ici dès qu'elle naît ; tranchée, elle en
sort et sa réponse va dans son ticket.

## Dernier tour

- Date : 2026-10-08, matin.
- Chantier courant : faustx-zj5 (FaustScript au niveau de BPScript).
- Aucun agent ne tourne. Suite de la file, dans l'ordre : faustx-zj5.54 (le transpileur : define,
  conflits de noms, largeur du bus master, agrandir une banque, plages de voies, « sink » → bus
  master), puis faustx-zj5.51, puis les documents des paquets internes (faustx-zj5.29).
- À vérifier au prochain tour : la relecture de Romain sur les documents en français.

## R — à confirmer par le responsable

- **Relecture des documents de référence, en français** (faustx-zj5.28, zj5.48, zj5.53) —
  `CONTEXT.md`, `docs/PRINCIPES.md`, `docs/LANGUAGE.md`, `docs/ARCHITECTURE.md`,
  `packages/040-faustscript/docs/CADRE.md` et `INTERFACE.md`. Quatre détails de zj5.53 à confirmer
  en lisant : le premier port cité par NAME_IS_INSTANCE, la phrase de CHANNEL_OUT_OF_RANGE,
  RangeError pour createSession, le code de sortie 2 pour `--channels` invalide.
- **Q65, étiquettes des schémas de l'architecture** — restées en anglais. Recommandation : les
  traduire ; la garde des traductions ne compare plus à l'identique que les exemples de code.
- **Q66, écarts de rédaction hérités de l'anglais** (formules ramassées, négations, numéros de
  ticket et « aujourd'hui » dans ARCHITECTURE §9, « décision de Romain » dans PRINCIPES).
  Recommandation : un ticket les corrige dans les deux langues.
- **Branche locale `zj5.53`**, fusionnée — la suppression attend son accord (règle globale).
- **Retour sur le métacadre** — la règle « un seul équipier commite » ne nomme pas l'équipier, et
  contredit « l'agent écrit … les commits ».

## S — à surveiller

- Le module FaustScript de BPScript : la séance BPScript a reçu le matériau des §1, §4, §6 de
  l'ancienne fiche et le renommage ; ferme quand bp-mono l'a versé.
- La branche `box-signal-api-wasm` de faustwasm : si elle fusionne, `000-faust` peut construire
  les arbres de Faust au lieu d'écrire du texte.

## F — fermés

- Grill faustx-zj5.27 (Q15–Q28), notation faustx-zj5.46 (Q44–Q52), nécessité faustx-zj5.52
  (Q63), règles Q53–Q64, renommage FaustScript (zj5.47, zj5.50), Faust épinglé et montée 0.19.0
  (zj5.37–zj5.39), documents en français et en anglais (zj5.55).
