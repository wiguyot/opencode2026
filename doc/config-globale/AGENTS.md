# Consignes de projet (modèle)

Ce fichier est un modèle à copier à la racine d'un projet sous le nom `AGENTS.md`. Malgré son rangement dans `doc/config-globale/`, il est destiné ici au projet, pas à la configuration générale. Complétez la section suivante avec les informations vérifiées du dépôt ; une indication « non renseigné » n'est pas une commande à exécuter.

## Repères propres au projet

- Objectif et emplacement des spécifications : non renseignés.
- Installation et prérequis : non renseignés.
- Commande de test ciblé et répertoire d'exécution : non renseignés.
- Commande de validation complète : non renseignée.
- Commande de vérification du formatage sans correction : non renseignée.
- Contraintes du projet et fichiers à préserver : non renseignés.
- Critères de réussite et livrables attendus : non renseignés.

Si un repère manque, consulte le README, les spécifications et les scripts existants. Indique ce qui reste inconnu plutôt que d'inventer une commande.

## Avant toute modification

- Réponds en français, sauf demande contraire.
- Lis les fichiers utiles avant de proposer une modification.
- Si une information manque, dis-le clairement et indique ce qu'il faut vérifier.
- Explique en une phrase ce que tu vas changer et cite les fichiers concernés.

## Pendant le travail

- Fais des changements petits et ciblés ; respecte l'organisation et le style déjà en place.
- Préserve les modifications déjà en cours ; ne les annule pas pour faciliter ta tâche.
- Pour une demande d'explication, de diagnostic ou de relecture, réponds sans appliquer de correction.
- Appuie les explications sur le code ou sur un exemple court. Aide à justifier la correction et les tests, en respectant les spécifications du projet.
- N'invente ni commande, ni fichier, ni dépendance. Vérifie d'abord.
- N'ajoute pas de dépendance sans expliquer son intérêt.
- Ne supprime, ne renomme et ne déplace pas de fichiers sans accord explicite.
- Ne lis, n'affiche et ne modifie jamais de clé API, de mot de passe, de token ou de fichier `.env`.

## Qualité et vérification

- Utilise les commandes de test ou de formatage déjà présentes dans le projet.
- Distingue une vérification de formatage d'une commande qui réécrit les fichiers. Une demande de vérification ne vaut pas demande de correction.
- Indique les commandes réellement exécutées et leur résultat.
- Distingue les validations réussies, échouées et non exécutées ; explique les blocages sans masquer les erreurs.
- N'affirme jamais qu'un test a réussi s'il n'a pas été lancé.
- Privilégie un code lisible, des noms explicites et une gestion claire des erreurs.

## Git

- Consulte `git status` et le diff avant une modification importante.
- Ne lance jamais `git commit`, `git push`, `git reset --hard` ou `git clean` sans demande explicite.

## Travaux longs

Pour une tâche qui s'étale sur plusieurs étapes ou sessions, utilise le skill `todo-tracking` s'il est installé et si la tâche autorise l'écriture, afin de conserver un `todo.md` court à la racine du projet. S'il n'est pas disponible, résume les étapes et la prochaine action dans la conversation ; son installation n'est pas un préalable pour commencer.
