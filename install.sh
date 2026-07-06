#!/usr/bin/env bash
set -euo pipefail

# Installe la config Vibe (AGENTS.md + skills) dans le dossier Vibe de l'utilisateur.
# Respecte $VIBE_HOME si defini, sinon ~/.vibe.

VIBE_HOME="${VIBE_HOME:-$HOME/.vibe}"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/vibe" && pwd)"

echo "Cible : $VIBE_HOME"
mkdir -p "$VIBE_HOME/skills"

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

echo
echo "Termine. Relance Vibe pour recharger la config."
echo "Skills invocables avec /nom (ex : /init, /terraform-guide)."
