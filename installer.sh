#!/usr/bin/env bash
# Installe la configuration OpenCode du cours et vérifie que tout fonctionne.
#
# Peut être relancé autant de fois que nécessaire, avec ou sans clé API déjà
# définie dans le terminal : aucune étape n'écrase un fichier personnalisé ni
# ne laisse le dépôt dans un état incohérent si la clé manque encore.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$REPO_ROOT/doc/config-globale/opencode.json"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
CONFIG_DEST="$CONFIG_DIR/opencode.json"
REF_VERSION="1.18.29"

echo "== 1. OpenCode installé ? =="
if ! command -v opencode >/dev/null 2>&1; then
  echo "opencode n'est pas trouvé dans le PATH."
  echo "Installe-le d'abord : https://opencode.ai/docs"
  exit 1
fi

INSTALLED_VERSION="$(opencode --version 2>/dev/null || echo inconnue)"
echo "Version installée : $INSTALLED_VERSION (référence du cours : $REF_VERSION)"
if [ "$INSTALLED_VERSION" != "$REF_VERSION" ]; then
  echo "Différence avec la référence : pas forcément un problème, signale-le en cas de souci."
fi

echo
echo "== 2. Configuration du cours =="
mkdir -p "$CONFIG_DIR"
if [ ! -f "$CONFIG_DEST" ]; then
  cp "$CONFIG_SRC" "$CONFIG_DEST"
  echo "Configuration installée : $CONFIG_DEST"
elif diff -q "$CONFIG_SRC" "$CONFIG_DEST" >/dev/null 2>&1; then
  echo "Déjà installée et à jour : $CONFIG_DEST"
else
  echo "Un fichier existe déjà à $CONFIG_DEST et diffère du modèle du cours."
  echo "Rien n'a été écrasé. Compare les deux avant de les fusionner :"
  echo "  diff \"$CONFIG_SRC\" \"$CONFIG_DEST\""
fi

echo
echo "== 3. Clé API =="
if [ -z "${LITELLM_API_KEY:-}" ]; then
  echo "LITELLM_API_KEY n'est pas définie dans ce terminal."
  echo "Définis-la puis relance ce script :"
  echo '  export LITELLM_API_KEY="ta_clé_fournie_par_l_ISIMA"'
  echo
  echo "(La configuration est installée, tu peux t'arrêter là pour l'instant.)"
  exit 0
fi
echo "Clé détectée (valeur non affichée)."

echo
echo "== 4. Modèles connus d'OpenCode =="
if ! opencode models litellm; then
  echo "Impossible de lister les modèles. Vérifie la configuration, puis contacte l'encadrant si besoin."
  exit 1
fi

echo
echo "== 5. Appel de test =="
if opencode run --model litellm/GLM-5.3-Flash --agent plan "Réponds uniquement OK, sans utiliser d'outil."; then
  echo
  echo "Tout fonctionne. Place-toi dans le dossier de ton TP et lance : opencode"
else
  echo "L'appel de test a échoué. Contacte l'encadrant avec la version, le modèle et le message d'erreur (sans la clé)."
  exit 1
fi
