---
name: todo-tracking
description: >-
  Maintient ou relit todo.md pour reprendre un travail long entre sessions ou
  après compaction. À utiliser pour un suivi durable, pas pour une tâche ponctuelle.
---

# Suivi des tâches

`todo.md` est un simple fichier Markdown à la racine du projet (ce n'est pas l'outil de tâches intégré). Il conserve l'état d'un travail en cours entre les compactions et les sessions.

## Quand l'utiliser

- Créer ou mettre à jour `todo.md` si un suivi durable aide une tâche en plusieurs étapes ou sessions et si la tâche autorise l'écriture.
- Pour une explication, un diagnostic ou une relecture sans modification, lire le suivi utile s'il existe et donner le bilan dans la conversation sans créer ni modifier de fichier.
- Lire le fichier existant avant de commencer et le confronter à la demande actuelle. Ne pas relancer une ancienne tâche simplement parce qu'elle reste inscrite dans le suivi.
- Le mettre à jour après chaque étape importante et avant de terminer la session.

## Contenu attendu

- objectif actuel ;
- étapes terminées et restantes ;
- décisions importantes ;
- fichiers modifiés ;
- commandes et validations exécutées ;
- difficultés ou incertitudes connues.

## Règles

- Rester concis : pas de code source complet ni de longs journaux.
- Ne consigner aucun secret, valeur d'environnement sensible ou donnée personnelle inutile.
- Préserver le suivi d'un autre travail ; si son remplacement est nécessaire et que l'intention n'est pas claire, demander une précision.
- Ne pas en faire une note de réflexion vague : il doit permettre de reprendre le travail immédiatement.
- Avant de terminer, ajouter une courte section « Reprendre ici » avec la prochaine action précise.
- Au début d'une nouvelle session, relire `todo.md`, puis comparer avec `git status`, les diffs indexés et non indexés et les fichiers pertinents avant toute modification. Sans Git, vérifier les fichiers disponibles et indiquer les limites de la comparaison.
- Distinguer ce qui est constaté de ce qui reste à vérifier. Marquer une tâche terminée seulement si son résultat attendu est atteint.

## Forme du suivi

Utiliser des sections courtes : « Objectif », « Terminé », « À faire », « Décisions », « Fichiers modifiés », « Validations et limites », puis « Reprendre ici ». Dans les validations, conserver la commande, son résultat et les prérequis manquants ; un test non exécuté reste explicitement non exécuté.

Le fichier est un aide-mémoire. Il ne remplace ni la demande actuelle, ni le dépôt, ni une vérification effective des résultats.
