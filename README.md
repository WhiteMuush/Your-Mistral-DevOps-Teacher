# Your 𝐅𝐑𝐄𝐍𝐂𝐇 Mistral DevOps Teacher 🇫🇷

[BETA VERSION]
    Config prête à l'emploi pour [Mistral Vibe](https://mistral.ai/products/vibe/code/) : un `AGENTS.md` (règles + style compressé) et 11 skills DevOps / dev, installables en une commande.

## Installation

```bash
git clone https://github.com/WhiteMuush/Your-Mistral-DevOps-Teacher.git
cd Your-Mistral-DevOps-Teacher
bash install.sh
```

Puis relance Vibe. C'est tout.

L'installeur copie vers `~/.vibe/` (ou `$VIBE_HOME` si défini). Un `AGENTS.md` déjà présent est sauvegardé (`.bak.<date>`) avant écrasement. Les skills sont fusionnés, pas les autres skills existants ne sont supprimés.

## Contenu

```
vibe/
├── AGENTS.md          # règles globales + style compressé toujours actif + routage skills
└── skills/
    ├── init/                     # /init : scanne un repo, écrit un AGENTS.md projet
    ├── dev-conventions/          # code, commits, branches conformes au projet
    ├── terraform-guide/
    ├── helm-chart-builder/
    ├── ansible-playbook-builder/
    ├── docker-swarm-guide/
    ├── argocd-guide/
    ├── prometheus-grafana-setup/
    ├── azure-cloud-advisor/
    ├── github-actions-expert/
    └── gitlab-ci-guide/
```

## Usage

Chaque skill est invocable en slash-command : `/init`, `/terraform-guide`, `/dev-conventions`, etc.

Sur un nouveau repo, lance `/init` une fois : il détecte la stack, lit les skills utiles, et écrit un `AGENTS.md` à la racine du projet que Vibe relira à chaque session.

## À savoir sur Vibe

Vibe peux ne pas déclencher les skills automatiquement sur mots-clés : ils se chargent via `/nom`, ou parce que la table de routage dans `AGENTS.md` dit au modèle de lire le bon `SKILL.md` avant d'agir. C'est un rappel permanent, pas une garantie stricte : si tu veux être sûr, invoque le skill à la main.

## Mise à jour

Re-run `bash install.sh` après un `git pull`. L'ancien `AGENTS.md` est sauvegardé à chaque fois.

