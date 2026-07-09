#!/usr/bin/env bash
set -euo pipefail

# Installe la config Vibe (AGENTS.md + skills + system prompt) dans le dossier Vibe de l'utilisateur.
# Respecte $VIBE_HOME si defini, sinon ~/.vibe.

VIBE_HOME="${VIBE_HOME:-$HOME/.vibe}"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/vibe" && pwd)"

echo "Cible : $VIBE_HOME"
mkdir -p "$VIBE_HOME/skills" "$VIBE_HOME/prompts"

# Sauvegarde l'AGENTS.md existant avant de l'ecraser
if [ -f "$VIBE_HOME/AGENTS.md" ]; then
  BACKUP="$VIBE_HOME/AGENTS.md.bak.$(date +%Y%m%d%H%M%S)"
  cp "$VIBE_HOME/AGENTS.md" "$BACKUP"
  echo "AGENTS.md existant sauvegarde : $BACKUP"
fi

cp "$SRC/AGENTS.md" "$VIBE_HOME/AGENTS.md"
echo "AGENTS.md installe."

# Copie chaque skill (fusion, n'efface pas les autres skills existants)
cp -r "$SRC/skills/." "$VIBE_HOME/skills/"
echo "Skills installes :"
find "$SRC/skills" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort | sed 's/^/  - /'

# System prompt custom (base : prompt integre de Vibe 2.19.1 + regles style/skills/git)
cp "$SRC/prompts/cli-caveman.md" "$VIBE_HOME/prompts/cli-caveman.md"
echo "System prompt cli-caveman installe."

# Active le system prompt dans config.toml si present
CONFIG="$VIBE_HOME/config.toml"
if [ -f "$CONFIG" ]; then
  if grep -q '^system_prompt_id' "$CONFIG"; then
    if ! grep -q '^system_prompt_id = "cli-caveman"' "$CONFIG"; then
      sed -i.bak 's/^system_prompt_id = .*/system_prompt_id = "cli-caveman"/' "$CONFIG"
      echo "config.toml : system_prompt_id passe a cli-caveman (backup : config.toml.bak)."
    else
      echo "config.toml : system_prompt_id deja sur cli-caveman."
    fi
  else
    printf '\nsystem_prompt_id = "cli-caveman"\n' >> "$CONFIG"
    echo "config.toml : system_prompt_id = cli-caveman ajoute."
  fi
else
  echo "ATTENTION : $CONFIG introuvable. Ajoute manuellement : system_prompt_id = \"cli-caveman\""
fi

echo
echo "Termine. Relance Vibe pour recharger la config."
echo "Skills invocables avec /nom (ex : /init, /terraform-guide)."
