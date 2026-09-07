---
name: verifier-projet
description: >-
  Vérifie un projet avant de le considérer terminé : confronte le travail aux
  consignes, exécute les validations du projet autorisées et rapporte les
  résultats sans corriger le code. À utiliser pour un bilan de validation, pas
  pour implémenter une fonctionnalité.
---

# Vérifier le projet

## Préparer les vérifications

1. Lis le README, le fichier `AGENTS.md` et les spécifications disponibles pour identifier les critères de réussite et les commandes de validation. Respecte le périmètre demandé.
2. Consulte `git status` et les diffs si Git est disponible pour connaître le travail à vérifier. Ne modifie pas l'index. Si des informations manquent, indique-les ; n'invente ni exigence ni commande.
3. Vérifie les commandes dans les scripts ou fichiers de configuration du projet, leur répertoire d'exécution et leurs prérequis. Privilégie les tests ciblés, puis les validations complètes attendues.
4. Annonce brièvement les vérifications prévues et ce qu'elles contrôlent. Si la demande porte uniquement sur la préparation, arrête-toi à cette liste.

## Exécuter sans corriger

- Lance les validations demandées dans la limite des permissions de l'agent. Utilise le mode de vérification sans correction pour le formatage, s'il existe. Si la seule commande réécrit les sources, explique-le et ne la lance pas dans cette procédure.
- Une vérification peut produire des caches ou des rapports de test. Si l'exigence est qu'aucun fichier ne soit écrit, propose les commandes sans les exécuter à moins d'avoir vérifié qu'elles respectent cette contrainte.
- N'installe pas de dépendance, ne change pas la configuration et ne lance pas de service ou de commande qui réinitialise des données pour débloquer un test sans demande correspondante.
- En cas d'échec, conserve le message utile, explique ce qu'il permet de conclure et propose la prochaine vérification. Ne corrige pas le code ou les tests, et ne relance pas la même commande sans élément nouveau.

## Restituer le résultat

Présente un bilan court, en utilisant les commandes réellement exécutées :

| Vérification ou critère | Commande et répertoire, si applicable | État | Preuve ou limite |
|---|---|---|---|

Utilise les états « réussi », « échoué » ou « non exécuté » pour les commandes ; « vérifié » ou « à vérifier » pour les critères examinés sans commande. Ne transforme pas un test bloqué par un prérequis en test réussi.

Termine par les critères encore non couverts et la prochaine action utile. La réussite des tests exécutés ne suffit pas à garantir le respect de toutes les spécifications. Invite à expliquer une correction ou un cas limite pertinent, sans rédiger le compte-rendu à la place de l'utilisateur.
