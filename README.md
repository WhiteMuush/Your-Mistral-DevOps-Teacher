# Your 𝐅𝐑𝐄𝐍𝐂𝐇 Mistral DevOps Teacher 🇫🇷

[BETA VERSION]
    Config prête à l'emploi pour [Mistral Vibe](https://mistral.ai/products/vibe/code/) : un `AGENTS.md` (règles + style compressé), 11 skills DevOps / dev, et un system prompt custom qui force la lecture des skills, le git systématique et les réponses courtes. Installable en une commande.

> 📖 **[Le wiki](https://github.com/WhiteMuush/Your-Mistral-DevOps-Teacher/wiki)** explique comment tout ça est construit et pourquoi : architecture des 3 couches, le system prompt en détail, les problèmes réels rencontrés et leurs diagnostics.

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
├── prompts/
│   └── cli-caveman.md # system prompt custom (voir section dédiée)
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

## Le system prompt custom

`AGENTS.md` seul ne suffit pas : Vibe l'encadre d'un avertissement "peut être pertinent ou non" et le modèle dérive sur les sessions longues. Le system prompt est un canal plus fort.

`vibe/prompts/cli-caveman.md` = le prompt intégré de Vibe (copié tel quel, version 2.19.0) + 4 sections ajoutées à la fin :

1. **Style compressé** : réponses courtes, jamais recopier un fichier lu, règles de lisibilité (une idée par ligne, gras, listes)
2. **Skills obligatoires** : lire le `SKILL.md` du domaine avant d'agir, même si le prompt donne déjà la structure. Le skill fait autorité sur les connaissances d'entraînement
3. **Git systématique** : `git init` + commits atomiques sur tout projet neuf, sans le demander. Jamais de push non demandé
4. **Vraies justifications** : chaque choix technique non trivial = "X plutôt que Y : raison concrète". Les justifications creuses ("robuste", "scalable") sont interdites

L'installeur le copie dans `~/.vibe/prompts/` et bascule `system_prompt_id = "cli-caveman"` dans `config.toml` (backup automatique).

**Après une grosse mise à jour de Vibe** : le prompt intégré évolue mais cette copie reste figée. Re-copier le nouveau `cli.md` depuis le paquet installé et re-coller les 4 sections.

## À savoir sur Vibe

Vibe peux ne pas déclencher les skills automatiquement sur mots-clés : ils se chargent via `/nom`, ou parce que la table de routage dans `AGENTS.md` et le system prompt disent au modèle de lire le bon `SKILL.md` avant d'agir. Testé sur un prompt d'infra ouvert : les 3 skills pertinents sont lus avant d'écrire.

## Mise à jour

Re-run `bash install.sh` après un `git pull`. L'ancien `AGENTS.md` est sauvegardé à chaque fois.

