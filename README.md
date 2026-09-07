# OpenCode à l'ISIMA

Ce dépôt accompagne l'utilisation d'[OpenCode](https://opencode.ai/) à l'ISIMA, pour un projet de cours comme pour une activité de recherche. Il ne contient ni clé API ni donnée personnelle : la vôtre, fournie par l'équipe ISIMA, reste uniquement dans votre environnement local — ne la partagez jamais, ne la commitez jamais.

## OpenCode rapidement

Vous voulez juste que ça marche, sans tout lire ? Ces 4 étapes suffisent pour coder avec l'aide d'OpenCode.

1. Installez OpenCode en suivant la [documentation officielle](https://opencode.ai/docs) (une seule fois).
2. Récupérez votre clé auprès de l'équipe ISIMA, puis dans votre terminal :
   ```bash
   export LITELLM_API_KEY="votre_clé_fournie_par_l_ISIMA"
   ```
3. Depuis la racine de **ce dépôt**, lancez :
   ```bash
   ./installer.sh
   ```
   Vous pouvez le relancer autant de fois que nécessaire, avant ou après avoir défini votre clé : il ne casse rien et n'écrase jamais un fichier que vous auriez déjà personnalisé.
4. Une fois le script satisfait, placez-vous dans le dossier de votre projet et lancez `opencode`. Utilisez `Tab` pour choisir **Plan** (comprendre, préparer) ou **Build** (modifier, exécuter), puis posez votre question.

C'est tout ce dont vous avez besoin pour utiliser OpenCode comme aide au codage et à la mise au point.

## Choisissez votre parcours

L'installation ci-dessus est commune à tout le monde. Ensuite, deux façons d'utiliser ce dépôt selon ce que vous cherchez :

**Utiliser OpenCode comme un assistant de codage** — comprendre une erreur, proposer une correction, lancer un test, comme un binôme de programmation. Suffisant pour avancer sur vos projets, sans agent ni skill à créer.
→ [presentation-opencode.md](presentation-opencode.md)

**Aller vers l'agentique** — créer vos propres agents et skills, restreindre des permissions, écrire un `AGENTS.md` de projet. À lire quand le besoin se présente réellement, pas avant.
→ [agents-et-skills.md](agents-et-skills.md)

Les deux guides repartent de l'installation faite ci-dessus ; vous pouvez lire l'un sans l'autre, ou le premier avant le second.

Les fichiers dans `doc/` sont des modèles à copier aux emplacements indiqués : cloner ce dépôt ne les installe pas dans OpenCode (`installer.sh` s'en charge pour `opencode.json`). En cas de doute sur l'installation, le modèle à choisir ou l'accès à la clé, contactez l'équipe ISIMA avant de modifier votre configuration.

## Version de référence

Version de référence : OpenCode **1.18.29**, le 7 septembre 2026. `installer.sh` compare automatiquement votre version installée à cette référence.
