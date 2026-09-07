# Utiliser OpenCode à l'ISIMA

OpenCode est un assistant de programmation qui travaille dans votre terminal et dans le dossier du projet. Il peut vous aider à comprendre du code, chercher une erreur, proposer une modification ou lancer les tests. Il ne remplace ni votre raisonnement ni la validation de votre travail.

Ce guide vise un démarrage serein : vous installez OpenCode, vous utilisez la clé qui vous a été fournie sans jamais la diffuser, puis vous l'employez comme un binôme de programmation.

> Pressé ? Le [README](README.md#opencode-rapidement) résume l'installation en 4 commandes avec un script qui vérifie tout automatiquement. Ce guide-ci détaille chaque étape et sert de référence en cas de problème.

## 1. Avant de commencer

Vous avez besoin de :

- votre ordinateur et un terminal ;
- OpenCode installé, en suivant la [documentation officielle](https://opencode.ai/docs) ;
- la clé d'accès communiquée par l'équipe ISIMA ;
- le dépôt de votre projet cloné localement.

> Votre clé est personnelle. Ne la placez jamais dans un fichier, un dépôt Git, une capture d'écran, un compte-rendu, un message ou le prompt envoyé à OpenCode. Si elle est exposée, prévenez immédiatement l'équipe ISIMA.

## 2. Configurer la clé sans la stocker

La clé doit être définie dans l'environnement du terminal **avant** de démarrer OpenCode. Dans le terminal, copiez cette commande et remplacez uniquement `VOTRE_CLE_FOURNIE_PAR_L_ISIMA` par la valeur reçue :

```bash
export LITELLM_API_KEY="VOTRE_CLE_FOURNIE_PAR_L_ISIMA"
```

La variable est alors disponible pour le terminal courant. Lancez OpenCode depuis ce même terminal. Si vous le fermez, vous devrez exécuter cette commande à nouveau la prochaine fois.

Vérifiez seulement que la variable existe, sans afficher sa valeur :

```bash
test -n "$LITELLM_API_KEY" && echo "Clé configurée" || echo "Clé absente"
```

L'exemple [opencode.json](doc/config-globale/opencode.json) utilise la référence suivante :

```json
"apiKey": "{env:LITELLM_API_KEY}"
```

Cette ligne ne contient pas la clé : elle indique à OpenCode où la lire. Ne remplacez pas cette référence par la valeur reçue.

## 3. Données et confidentialité

Dans le cadre du service configuré par l'ISIMA, les données personnelles ne sortent pas de l'infrastructure du laboratoire. Les demandes envoyées à OpenCode, les extraits de code utiles à la tâche et les réponses du modèle transitent par le service LiteLLM du laboratoire.

Cette garantie concerne la configuration fournie par l'ISIMA. Installer un autre fournisseur de LLM, une API ou un serveur MCP externe vous expose à des fuites potentielles de vos données : ces outils ne bénéficient pas de la garantie de confidentialité du service du laboratoire. Demandez l'accord de l'équipe ISIMA avant d'en ajouter un.

Même dans ce cadre, appliquez le principe de minimisation : ne transmettez que ce qui est utile à votre tâche. Pour toute question sur les données ou le service, contactez l'équipe ISIMA.

## 4. Installer la configuration ISIMA

Le fichier [doc/config-globale/opencode.json](doc/config-globale/opencode.json) est un modèle pour le service ISIMA. Il n'a pas besoin d'être modifié pour y ajouter une clé.

Le script [`installer.sh`](installer.sh) (voir le [README](README.md#opencode-rapidement)) fait la copie et les vérifications ci-dessous automatiquement, sans écraser une configuration existante différente. Les étapes manuelles qui suivent expliquent ce qu'il fait, utile pour comprendre un message d'erreur ou installer sans le script.

Copiez-le dans votre configuration locale après avoir sauvegardé toute configuration personnelle existante. N'écrasez pas une configuration qui vous appartient sans en conserver une copie. En cas de doute, contactez l'équipe ISIMA.

### Où copier le fichier ?

Les commandes de ce guide sont prévues pour Bash ou Zsh sous Linux, macOS, ou dans un terminal WSL sous Windows. Exécutez OpenCode dans ce même environnement.

La destination habituelle est `~/.config/opencode/opencode.json` : `~` désigne votre dossier personnel. Si vous avez personnalisé `XDG_CONFIG_HOME`, la destination devient `$XDG_CONFIG_HOME/opencode/opencode.json`. La commande `opencode debug paths` indique le répertoire de configuration utilisé.

Pour une première installation avec le chemin habituel, placez-vous à la racine de **ce dépôt de documentation**, puis exécutez :

```bash
mkdir -p ~/.config/opencode
cp -i doc/config-globale/opencode.json ~/.config/opencode/opencode.json
```

`cp -i` demande confirmation si le fichier existe déjà. Dans ce cas, répondez `n`, conservez une copie de votre configuration et faites intégrer ces paramètres avec l'équipe ISIMA. Vérifiez aussi si un `opencode.jsonc` existe déjà dans ce répertoire : c'est une autre forme de configuration, qui accepte des commentaires.

Le dossier `doc/config-globale/` contient les modèles fournis par l'ISIMA ; OpenCode ne le charge pas automatiquement. Le fichier JSON s'installe une fois et sera réutilisé aux lancements suivants.

### Configuration globale et configuration de projet

La configuration globale contient ici le fournisseur et les modèles du laboratoire. Un `opencode.json` à la racine d'un projet peut ajouter des paramètres qui lui sont propres. Les configurations sont fusionnées : pour une même clé, celle du projet prend le dessus ; les autres valeurs globales restent présentes. Par exemple, changer seulement `model` ne supprime pas un modèle fixé explicitement dans `agent.build.model`. La [documentation officielle](https://opencode.ai/docs/config/#locations) détaille les autres sources et leur priorité.

Ne recopiez pas toute la configuration globale dans chaque projet. Le `AGENTS.md` du projet, lui, se place à sa racine et décrit ses consignes et commandes, comme expliqué dans [Agents et skills](agents-et-skills.md).

### Vérifier l'installation en trois étapes

1. Exécutez `opencode --version`. La version de référence est **1.18.29** ; si elle diffère, signalez-le en cas de problème.
2. Vérifiez que la configuration est chargée avec la commande suivante :

```bash
opencode models litellm
```

La liste doit notamment contenir `litellm/GLM-5.3-Flash` et `litellm/dev-model`. Elle contient aussi les alias `litellm/general` et `litellm/general_nothink`. Cette étape confirme que les modèles sont connus d'OpenCode ; elle ne teste pas encore la clé ni une réponse du serveur.

3. Une fois la clé définie dans ce terminal, effectuez un appel court :

```bash
opencode run --model litellm/GLM-5.3-Flash --agent plan "Réponds uniquement OK, sans utiliser d'outil."
```

Une réponse sans erreur d'accès confirme qu'une requête a abouti. Ce test utilise le service du laboratoire ; il ne vérifie pas encore les outils, les tests de votre projet ou les longues conversations. Si la liste ou cet appel échoue, contactez l'équipe ISIMA avec la version, le nom du modèle et le message d'erreur, sans la clé. Ne modifiez pas l'URL du service au hasard.

### Comprendre les limites du modèle

Le modèle principal est `litellm/GLM-5.3-Flash`, fixé pour Build, Plan et General. `litellm/dev-model` sert de modèle auxiliaire via `small_model`. Les deux utilisent les budgets suivants :

| Paramètre | Valeur | Rôle |
|---|---:|---|
| `limit.context` | 196 608 | Fenêtre totale de contexte déclarée pour ce service |
| `limit.input` | 155 000 | Plafond d'entrée choisi pour les consignes, l'historique et les résultats d'outils |
| `limit.output` | 8 192 | Plafond de tokens pour une réponse du modèle |

Un token est une unité de texte utilisée par le modèle ; il ne correspond pas exactement à un mot. `input` et `output` sont ici des budgets prudents repris de la configuration `dev-model`, pas l'affirmation que les deux modèles ont les mêmes capacités maximales. Les déclarer dans OpenCode n'augmente pas les limites du serveur.

La compaction résume une conversation devenue longue. Avec OpenCode 1.18.29, `input: 155000` et la réserve `compaction.reserved: 32768`, son seuil préventif est de **122 232 tokens comptabilisés** : OpenCode garde de la marge avant la saturation. Les autres réglages de compaction et de sortie d'outils sont fournis par l'équipe ISIMA ; il n'est pas nécessaire de les ajuster pour commencer. [Calcul du seuil dans OpenCode 1.18.29](https://github.com/anomalyco/opencode/blob/v1.18.29/packages/opencode/src/session/overflow.ts).

## 5. Premier lancement

Placez-vous dans le dossier de votre projet, puis lancez :

```bash
opencode
```

Dans l'interface, utilisez `Tab` pour passer entre les agents principaux. Choisissez **Plan** pour comprendre et préparer le travail, puis **Build** lorsque vous souhaitez appliquer une modification. Le nom de l'agent actif est affiché dans l'interface. [Utilisation des agents intégrés](https://opencode.ai/docs/agents/#usage).

Plan est destiné à l'analyse et limite les modifications ; Build peut modifier les fichiers et exécuter des commandes selon les permissions configurées. Un agent n'est pas un modèle : Plan et Build utilisent ici le même modèle GLM avec des rôles différents. Une demande d'explication ne vous oblige pas à autoriser une modification.

Commencez dans Plan par une demande courte, sans modifier de fichier :

> Présente l'organisation de ce projet et indique la commande de test à utiliser. Ne modifie aucun fichier.

Lisez la réponse, ouvrez les fichiers cités et vérifiez les commandes proposées. Une bonne utilisation d'OpenCode reste interactive : vous gardez la décision finale.

## 6. Bien formuler une demande

Une demande utile donne le contexte, le but et les limites. Préférez :

> Dans `src/...`, explique la cause de cette erreur. Propose une correction minimale. N'applique rien avant mon accord.

> Ajoute un test pour le cas limite décrit dans les spécifications. Utilise le framework déjà présent, puis lance uniquement ce test.

> Relis les fichiers modifiés. Signale les problèmes par ordre d'importance, sans modifier le code.

Évitez les demandes vagues comme « fais tout ». Découpez le travail : comprendre, proposer, modifier, tester, puis relire.

## 7. Une méthode de travail simple

1. **Comprendre** — demandez une explication de l'arborescence, des spécifications ou d'une fonction.
2. **Planifier** — demandez les fichiers à examiner et les étapes, sans modification.
3. **Modifier** — demandez une correction ciblée et relisez le diff produit.
4. **Vérifier** — lancez les tests ou le formatage indiqués par le projet.
5. **Expliquer** — soyez capable de justifier le résultat : OpenCode est une aide, pas une réponse à recopier.

Avant une modification importante, demandez à OpenCode de citer les fichiers concernés. Après modification, demandez-lui un résumé précis et consultez `git diff`.

## 8. Sécurité et bonnes pratiques

- N'acceptez pas une commande que vous ne comprenez pas, surtout si elle supprime, déplace ou publie des fichiers.
- Ne demandez pas à OpenCode de contourner des consignes ou des règles qui s'appliquent à votre travail.
- Vérifiez le code, les tests et les explications avant de les considérer terminés.
- Ne lancez pas `git commit`, `git push`, `git clean` ou `git reset --hard` sans savoir précisément ce qu'ils font.

Le fichier [AGENTS.md](doc/config-globale/AGENTS.md) propose des consignes simples que vous pouvez adapter dans un projet. Elles incitent OpenCode à expliquer ses actions et à protéger les fichiers sensibles.

## 9. En cas de problème

| Symptôme | Premier réflexe |
|---|---|
| OpenCode ne démarre pas | Vérifiez l'installation avec la documentation officielle, puis demandez de l'aide. |
| L'accès au modèle échoue | Vérifiez la présence de `LITELLM_API_KEY` sans l'afficher ; contactez l'équipe ISIMA. |
| Une commande semble dangereuse | Refusez-la et demandez une explication. |
| La réponse est imprécise | Donnez le fichier, le message d'erreur et le résultat attendu. |
| Le travail est long | Installez puis utilisez le skill optionnel [todo-tracking](doc/config-globale/skills/todo-tracking/SKILL.md), selon le [guide d'installation des exemples](agents-et-skills.md#installer-les-exemples-dans-un-projet). |

## Pour aller plus loin

Plan et Build suffisent pour utiliser OpenCode comme aide au codage et à la mise au point : comprendre une erreur, proposer une correction, lancer un test. Créer un agent ou un skill n'est jamais nécessaire pour avancer sur votre projet — c'est une option pour qui veut personnaliser son usage une fois à l'aise, à explorer dans [agents-et-skills.md](agents-et-skills.md#lidée-en-une-minute) quand le besoin se présente réellement, pas avant.

Ressource de référence : [documentation officielle OpenCode](https://opencode.ai/docs). La suite du parcours est le guide [Agents et skills](agents-et-skills.md).
