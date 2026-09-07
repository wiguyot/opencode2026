# Agents et skills : choisir le bon outil

**Lecture optionnelle.** Plan et Build, décrits dans le [guide de démarrage](presentation-opencode.md), suffisent pour utiliser OpenCode comme aide au codage et à la mise au point : rien ici n'est nécessaire pour avancer sur votre projet. Ce document explique comment donner à OpenCode des comportements réutilisables, pour qui veut aller plus loin — un rôle avec des permissions différentes, une procédure réutilisable — sans compliquer inutilement votre projet.

## L'idée en une minute

Un **agent** est un intervenant avec un rôle précis. On lui donne une mission, des consignes et des permissions. Exemple : un relecteur qui examine le code et propose des corrections sans les appliquer.

Un **skill** est une procédure réutilisable. Il explique à l'agent comment traiter une situation particulière. Exemple : la marche à suivre pour reprendre un travail long avec un `todo.md`.

Un fichier **`AGENTS.md`** n'est ni un agent ni un skill : il contient des consignes communes. Dans ce parcours, on le place à la racine du projet pour ses règles. OpenCode accepte aussi des consignes personnelles dans `~/.config/opencode/AGENTS.md`. [Emplacements des consignes](https://opencode.ai/docs/rules/#types).

| Besoin | Choix |
|---|---|
| Donner des règles communes au travail dans un dépôt | `AGENTS.md` |
| Créer un rôle distinct ou restreindre des permissions | Agent |
| Décrire une recette à appliquer quand elle est utile | Skill |

Le **modèle** est le moteur qui produit les réponses. Changer d'agent ne change pas nécessairement de modèle : dans la configuration ISIMA, Plan et Build utilisent tous deux GLM. Charger un skill ajoute une méthode à l'agent actif, sans lui accorder de permission supplémentaire.

## Commencer avec Plan et Build

Avant de créer un agent, utilisez ceux qui sont intégrés à OpenCode :

| Agent | Quand l'utiliser | Exemple de demande |
|---|---|---|
| **Plan**, agent principal | Comprendre le projet et préparer une modification | « Explique cette erreur et propose les étapes d'une correction. » |
| **Build**, agent principal | Appliquer une modification ciblée et la vérifier | « Applique la correction retenue et lance le test pertinent. » |
| **General**, sous-agent intégré | Prendre en charge une tâche déléguée par l'agent principal | À découvrir ensuite ; il peut agir sur les fichiers selon ses permissions. |

Un agent principal est celui avec lequel vous dialoguez ; `Tab` permet d'en changer. Un sous-agent traite une mission délimitée dans une session enfant et renvoie son résultat. Vous pouvez l'appeler avec `@nom`, ou l'agent principal peut le choisir d'après sa description. Donnez-lui les fichiers, l'objectif et les contraintes utiles ; ne supposez pas qu'il dispose de toute la conversation du parent. [Agents OpenCode](https://opencode.ai/docs/agents/).

## Agent ou skill ?

Choisissez un **agent** quand vous avez besoin d'un rôle durable ou de droits différents. Un relecteur sans outil d'édition est un bon exemple. Un agent personnalisé peut être principal (`mode: primary`) ou délégué (`mode: subagent`).

Choisissez un **skill** quand le même agent doit apprendre une méthode ponctuelle. Le skill `todo-tracking`, par exemple, lui indique comment tenir un fichier de suivi pendant un travail long. Le contenu complet du skill n'est chargé que lorsque l'agent en a besoin.

N'en créez pas pour tout. Une règle de trois lignes propre à un seul dépôt appartient généralement à `AGENTS.md`. Un prompt utilisé une seule fois n'a besoin ni d'agent ni de skill.

## Général ou spécifique au projet ?

La portée dépend de la question suivante : « Cette règle ou cette procédure est-elle vraie dans presque tous mes projets ? »

| Portée | Emplacement | Bon exemple | À ne pas y mettre |
|---|---|---|---|
| **Générale** | `~/.config/opencode/agents/` ou `~/.config/opencode/skills/` | Un agent de relecture sans écriture ; une procédure de suivi de tâches | Les commandes de test d'un projet précis, son architecture ou ses critères de réussite |
| **Projet** | `.opencode/agents/` ou `.opencode/skills/` à la racine du dépôt | Un skill expliquant comment lancer les tests du projet ; un agent qui connaît ses conventions | Votre clé API ou une règle personnelle valable partout |

Les éléments généraux vivent dans votre configuration locale : ils ne doivent donc pas être ajoutés au dépôt du projet. Les éléments de projet vivent dans le dépôt : toute l'équipe dispose ainsi des mêmes règles. Ne placez jamais de clé API dans l'un ou l'autre.

> Pour un projet, commencez par un `AGENTS.md` qui lui est propre. Créez ensuite un skill ou un agent seulement si le besoin revient réellement.

## Installer les exemples dans un projet

Ce dépôt fournit des fichiers complets. Pour un premier essai, installez-les **dans votre projet** :

| Exemple dans ce dépôt | Destination dans le projet | À adapter |
|---|---|---|
| [Modèle de consignes](doc/config-globale/AGENTS.md) | `AGENTS.md` | Spécifications, commandes vérifiées, contraintes et critères de réussite |
| [Relecteur](doc/config-par-projet/agents/relecteur.md) | `.opencode/agents/relecteur.md` | Le rôle peut être utilisé tel quel |
| [Vérifier le projet](doc/config-par-projet/skills/verifier-projet/SKILL.md) | `.opencode/skills/verifier-projet/SKILL.md` | Vérifier que les spécifications du projet fournissent les commandes et critères utiles |
| [Suivi optionnel](doc/config-globale/skills/todo-tracking/SKILL.md) | `.opencode/skills/todo-tracking/SKILL.md` | Seulement pour un travail nécessitant un suivi durable |

Créez les répertoires parents, puis copiez les fichiers aux destinations du tableau. Ces chemins sont relatifs à la racine de **votre projet**, pas à celle de ce dépôt de documentation. Si un fichier existe déjà, adaptez-le en conservant les consignes utiles au projet. Les dossiers `doc/config-globale/` et `doc/config-par-projet/` servent à ranger les exemples ; ils ne sont pas des emplacements chargés automatiquement par OpenCode.

Les fichiers de projet peuvent être versionnés pour que toute l'équipe utilise les mêmes consignes. Pour un usage personnel dans plusieurs projets, les destinations deviennent `~/.config/opencode/agents/relecteur.md` et `~/.config/opencode/skills/<nom>/SKILL.md`. Évitez d'installer deux variantes du même nom sans savoir laquelle est chargée.

## Comprendre l'agent de relecture

Un agent est un fichier Markdown dont l'en-tête YAML, entre deux lignes `---`, indique le rôle et les permissions. Le [fichier complet du relecteur](doc/config-par-projet/agents/relecteur.md) utilise les choix suivants :

| Champ | Choix de l'exemple | Effet |
|---|---|---|
| `description` | Relecture avant validation d'une modification | Aide l'agent principal à choisir ce rôle |
| `mode` | `subagent` | Permet une mission déléguée, notamment via `@relecteur` |
| `permission."*"` | `deny` | Refuse les outils par défaut, sauf autorisation explicite ensuite |
| `read`, `glob`, `grep`, `list` | Lecture et recherche ; l'outil `read` refuse certains fichiers sensibles | Permet de consulter le contexte nécessaire |
| `edit` | `deny` | Refuse les outils d'édition de fichiers |
| `bash` | Trois commandes Git exactes, toutes les autres refusées | Permet de consulter l'état et les diffs sans ouvrir l'accès général au shell |

L'exemple autorise `git status --short`, `git diff --no-ext-diff --no-textconv` et la même commande avec `--cached`. Cela couvre les changements non indexés et indexés ; les fichiers nouveaux doivent être lus séparément. Les options du diff évitent les programmes de comparaison ou de conversion externes de Git. Il n'autorise ni tests, ni chargement de skills, ni délégation supplémentaire.

La consigne « ne modifie aucun fichier » guide le comportement. `edit: deny` bloque les outils d'édition, mais ne suffirait pas à empêcher une écriture via un shell autorisé : c'est pourquoi `bash` possède sa propre restriction. Les permissions OpenCode sont des contrôles d'outils, pas une isolation complète du système. `watcher.ignore` règle la surveillance des fichiers ; `.gitignore` règle ce que Git ignore : aucun des deux ne remplace une permission. [Fonctionnement des permissions](https://opencode.ai/docs/permissions/), [surveillance des fichiers](https://opencode.ai/docs/config/#watcher).

Le corps du fichier explique comment relire : partir du diff, lire le contexte nécessaire, étayer chaque problème et indiquer ses conséquences. Un rapport utile peut aussi conclure qu'aucune anomalie n'a été identifiée, en précisant les limites de la relecture. Le relecteur n'a pas de modèle fixé : il peut ainsi hériter du modèle de l'agent principal qui l'appelle.

## Créer un skill de procédure

Un skill est un dossier qui contient obligatoirement un fichier `SKILL.md`. Pour un projet, sa structure est la suivante :

```text
.opencode/
└── skills/
    └── verifier-projet/
        └── SKILL.md
```

Contenu minimal de `.opencode/skills/verifier-projet/SKILL.md` :

```markdown
---
name: verifier-projet
description: >-
  Vérifie un projet avant de le considérer terminé : consulte les consignes du
  projet et rapporte les validations demandées sans corriger le code. À utiliser
  pour un bilan avant de conclure.
---

# Vérifier le projet

1. Lire le README, le fichier AGENTS.md et les spécifications disponibles.
2. Identifier les critères de réussite et les commandes réellement définies.
3. Annoncer les validations prévues, puis exécuter celles demandées et autorisées.
4. Ne pas utiliser de commande de formatage qui corrige les sources.
5. Rapporter les validations réussies, échouées et non exécutées, avec leurs limites.
```

Cet exemple court montre la structure ; le [skill complet fourni](doc/config-par-projet/skills/verifier-projet/SKILL.md) précise aussi les prérequis, les échecs et le format du bilan. Il trouve les commandes propres au projet dans ses documents : elles doivent y être renseignées et vérifiées. Un skill ne rend pas une commande correcte simplement parce qu'elle y figure.

Le champ `name` doit correspondre au dossier : de 1 à 64 caractères, en minuscules, chiffres et tirets, sans tiret au début, à la fin ou doublé. `description` explique ce que fait le skill et quand l'utiliser. L'écriture `>-` permet une description sur plusieurs lignes, notamment avec un deux-points, sans ambiguïté YAML. [Format des skills OpenCode](https://opencode.ai/docs/skills/).

Une procédure utile précise ce qu'elle consulte, les étapes qui changent ses décisions, les limites de son action et le résultat attendu. Ici, un test échoué, un test réussi et un test non exécuté sont trois résultats distincts. Demander un bilan ne demande pas de corriger automatiquement le projet.

Un skill général se place plutôt dans `~/.config/opencode/skills/<nom>/SKILL.md`. Le [skill de suivi fourni](doc/config-globale/skills/todo-tracking/SKILL.md) est un exemple de procédure générale : il reste utile quel que soit le langage ou le dépôt.

## Vérifier et utiliser un agent ou un skill

Après avoir créé ou modifié un agent ou un skill de projet, quittez puis relancez OpenCode depuis la racine du dépôt. Cette précaution évite de travailler dans une session qui ne connaît pas encore le nouveau fichier.

Pour vérifier l'agent `relecteur`, commencez votre demande par son nom :

```text
@relecteur Relis les modifications en cours. N'écris aucun fichier.
```

Son nom doit être proposé lorsque vous saisissez `@`. Dans un terminal à la racine du projet, `opencode agent list` permet aussi de vérifier sa présence. `opencode debug agent relecteur` affiche ses permissions et les outils disponibles. Une permission shell détaillée doit être lue avec sa liste de commandes : voir `bash` disponible ne signifie pas que toutes les commandes sont autorisées.

S'il n'apparaît pas, vérifiez le chemin `.opencode/agents/relecteur.md`, l'en-tête YAML et le dossier de lancement. Après la relecture, comparez `git status --short`, `git diff` et `git diff --cached` à leur état initial pour vérifier que le travail en cours est préservé.

Pour un skill, demandez-le explicitement pendant le premier essai :

```text
Utilise le skill verifier-projet. Pour cette première demande, liste seulement les validations prévues et leurs prérequis, sans lancer de commande ni modifier de fichier.
```

Observez dans les actions de la session le chargement du skill `verifier-projet`, puis comparez la proposition aux commandes du projet. Une réponse qui affirme utiliser un skill ne suffit pas à vérifier son chargement. Pour lancer ensuite les validations retenues, passez dans Build et demandez : « Exécute les vérifications proposées, sans corriger le code. » Les tests peuvent produire des caches ou des rapports ; cela se distingue d'une correction des sources.

Pour vérifier la découverte, utilisez `opencode debug skill` depuis la racine du projet : le résultat doit contenir le nom du skill et le chemin attendu. S'il manque, vérifiez le nom exact `SKILL.md`, le nom du dossier, les champs `name` et `description` et les permissions de l'agent. Le relecteur de cet exemple ne charge pas de skills ; utilisez Plan pour préparer la vérification et Build pour l'exécuter. [Commandes de diagnostic](https://opencode.ai/docs/cli/#debug).

Le skill `todo-tracking` suit la même installation. Demandez-le lors d'un travail long, puis vérifiez qu'il tient un suivi concis et qu'il confronte une reprise au dépôt. Il ne doit pas créer un fichier pendant une demande sans modification. Dans ce dépôt de documentation, `todo.md` est ignoré par Git ; dans un projet, son éventuel versionnement dépend de ses propres consignes.

## Situations pratiques : problème et réponse apportée

Ces situations servent de repères pendant votre travail. La « réponse apportée » décrit une aide attendue ; à vous d'en vérifier le résultat.

| Problème rencontré | Demande ou outil adapté | Réponse apportée et point à vérifier |
|---|---|---|
| « Je découvre le dépôt et je ne sais pas par où commencer. » | Dans Plan : « Présente l'organisation et retrouve la commande de test. Cite les fichiers utiles. » | Une explication reliée aux fichiers réels ; ouvrir les références et vérifier la commande. |
| « Je comprends l'erreur, mais je veux vérifier mon idée de correction. » | Dans Plan : « Voici mon hypothèse. Confronte-la au code et indique un cas qui permettrait de la tester. » | Une hypothèse confirmée ou corrigée, avec un scénario reproductible ; distinguer preuve et supposition. |
| « La correction est décidée ; je veux la réaliser proprement. » | Dans Build : « Applique cette correction minimale et lance le test ciblé. » | Un changement limité et un résultat de test réel ; examiner le diff et expliquer pourquoi il corrige le défaut. |
| « Je veux un second regard sur mes changements. » | `@relecteur Relis les modifications en cours et signale les défauts étayés.` | Des constats classés, avec fichier, ligne et conséquence ; vérifier que la relecture n'a pas changé les fichiers. |
| « Je veux m'assurer de ne rien avoir oublié avant de considérer que c'est terminé. » | Dans Build : « Utilise le skill verifier-projet pour contrôler le travail selon les spécifications. » | Un bilan des critères et des commandes, avec réussites, échecs et vérifications non exécutées ; traiter les limites restantes. |
| « Un test ne démarre pas car un prérequis manque. » | « Explique ce qui bloque la validation et la prochaine action nécessaire. Ne modifie pas l'environnement. » | Une validation marquée non exécutée et un prérequis identifié ; ne pas confondre problème d'environnement et défaut du code. |
| « Je reprends demain une modification en plusieurs étapes. » | Dans Build : « Utilise todo-tracking pour conserver l'état utile à la reprise. » | Un suivi bref avec prochaine action ; le lendemain, confronter ce suivi au dépôt avant de continuer. |
| « Mon agent ou mon skill n'apparaît pas. » | Vérifier les chemins, puis `opencode agent list` ou `opencode debug skill`. | Un diagnostic de découverte avant de changer les consignes ; vérifier le nom, le chemin et l'en-tête réellement chargés. |

Pour améliorer vos propres skills, partez d'une procédure réellement utilisée, observez les actions et corrigez les étapes ambiguës. Un cas où le skill doit s'appliquer et un cas où il doit rester inactif constituent un premier contrôle utile. [Bonnes pratiques Agent Skills](https://agentskills.io/skill-creation/best-practices).

## Une démarche raisonnable pour un projet

1. Ajoutez ou adaptez un `AGENTS.md` dans le dépôt pour les règles et commandes propres au projet.
2. Si une procédure revient dans plusieurs tâches du même projet, créez un skill de projet.
3. Si vous avez besoin d'un rôle séparé avec des permissions distinctes, créez un agent de projet.
4. Ne promouvez un agent ou un skill vers votre configuration générale qu'après l'avoir utilisé avec succès dans plusieurs projets.

Cette progression évite deux pièges : une configuration générale trop encombrée et des règles de projet oubliées dans votre ordinateur personnel.

## À retenir

- `AGENTS.md` : les règles du dépôt.
- Agent : un rôle spécialisé, éventuellement limité par des permissions.
- Skill : une procédure réutilisable, chargée à la demande.
- Général : utile dans presque tous vos projets, installé localement.
- Projet : dépend du dépôt concerné, versionné avec lui.

Pour les détails à jour, consultez la documentation officielle : [agents](https://opencode.ai/docs/agents/) et [skills](https://opencode.ai/docs/skills/).
