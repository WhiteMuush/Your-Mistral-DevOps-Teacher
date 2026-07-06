---
name: init
description: Analyse un projet une fois et génère un AGENTS.md à sa racine (stack, commandes clés, conventions, skills pertinents). À lancer au début du travail sur un nouveau repo. Se déclenche avec "init", "initialise le projet", "onboard", "génère AGENTS.md", "découvre le projet".
user-invocable: true
---

# /init : découverte de projet, une fois

But : produire un `AGENTS.md` à la racine du repo qui résume le projet, pour que les sessions suivantes démarrent déjà informées. À faire une seule fois par projet (ou après un gros changement de stack).

Ne PAS tout recharger à chaque session : ce fichier existe justement pour éviter ça.

## Étape 1 — Scanner la structure

- Lister l'arbre du projet (dossiers principaux, profondeur raisonnable, ignorer `node_modules`, `.git`, `dist`, `vendor`, `.terraform`).
- Repérer les points d'entrée et l'organisation générale.

## Étape 2 — Détecter la stack

Chercher les marqueurs et en déduire les technos :

- Langage / paquets : `package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`, `Gemfile`.
- Conteneurs : `Dockerfile`, `docker-compose.yml`, `docker-stack.yml`.
- IaC : `*.tf`, `main.tf` (Terraform), `Chart.yaml` (Helm), `playbook.yml` / `roles/` (Ansible).
- Kubernetes / GitOps : `k8s/`, `manifests/`, `Application` ArgoCD.
- CI/CD : `.github/workflows/`, `.gitlab-ci.yml`.
- Monitoring : `prometheus.yml`, dashboards Grafana.

## Étape 3 — Lire les docs et conventions

- `README.md` : but du projet, install, usage.
- `CONTRIBUTING.md` : règles de contribution, format commits, branches.
- `.editorconfig`, config linter/formateur.
- `git log --oneline -15` et `git branch -a` : style commits + nommage branches réels.

## Étape 4 — Charger les skills pertinents

Vibe ne déclenche PAS les skills tout seul. Donc, selon la stack détectée, LIRE directement le fichier du skill concerné avec read_file pour charger sa méthode en contexte :

`~/.vibe/skills/<nom>/SKILL.md`

Correspondances stack → skill à lire :

- Terraform : `terraform-guide`
- Helm / Kubernetes : `helm-chart-builder`
- Ansible : `ansible-playbook-builder`
- Docker Swarm : `docker-swarm-guide`
- ArgoCD / GitOps : `argocd-guide`
- Prometheus / Grafana : `prometheus-grafana-setup`
- Azure : `azure-cloud-advisor`
- GitHub Actions : `github-actions-expert`
- GitLab CI : `gitlab-ci-guide`
- Toujours (code / commit / branche) : `dev-conventions`

Ne lire QUE les skills correspondant à la stack réelle du projet, pas les 11. `dev-conventions` : toujours le lire.

## Étape 5 — Écrire ./AGENTS.md à la racine

Générer un fichier COURT (pas un roman). Modèle :

```markdown
# AGENTS.md — <nom du projet>

## Stack
<langages, frameworks, outils infra détectés>

## Commandes clés
- Build : <cmd>
- Test : <cmd>
- Lint / format : <cmd>
- Run local : <cmd>

## Conventions
- Commits : <format observé dans git log>
- Branches : <motif observé dans git branch>
- Style code : <de .editorconfig / linter>

## Skills pertinents
<liste des skills de l'étape 4>

## Pièges connus
<gotchas repérés : setup non évident, service à lancer avant, etc.>
```

Règles de rédaction :

- Une info par ligne, aéré, gras sur les ancres.
- Ne mettre que le NON évident (ce que le code ne dit pas tout seul).
- Ne pas recopier le README en entier, pointer dessus.
- Jamais le tiret cadratin.

## Après génération

Montrer un résumé bref à l'utilisateur : stack détectée + skills retenus + chemin du fichier écrit. Ne pas commit sans qu'il le demande.
