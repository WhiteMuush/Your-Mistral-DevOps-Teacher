---
name: dev-conventions
description: Écrit du code, des commits et des branches conformes aux conventions du projet. Lit automatiquement CONTRIBUTING.md, AGENTS.md, .editorconfig et les configs de linter avant d'écrire, puis calque le style existant. Se déclenche avant toute écriture ou modification de code, avant un commit, avant la création d'une branche, ou avec "commit", "branche", "contributing", "convention", "code style", "linter".
user-invocable: true
---

# Conventions dev : code, commits, branches

Objectif : ne jamais écrire au hasard. Toujours détecter les règles du projet d'abord, puis s'y conformer.

## Étape 1 — Détecter les conventions (AVANT d'écrire)

Lire, si présents, dans cet ordre (le plus spécifique gagne) :

1. `CONTRIBUTING.md` (et `CONTRIBUTING` sans extension, `docs/CONTRIBUTING.md`)
2. `AGENTS.md`, `CLAUDE.md`, `.cursorrules` (règles agent du repo)
3. `.editorconfig` (indentation, fins de ligne, charset)
4. Config du formateur / linter selon la stack :
   - JS/TS : `.prettierrc`, `.eslintrc*`, `biome.json`
   - Python : `pyproject.toml` (ruff, black), `setup.cfg`, `.flake8`
   - Go : `gofmt` implicite. Ruby : `.rubocop.yml`
5. Scripts du gestionnaire de paquets (`package.json` scripts, `Makefile`, `justfile`) pour connaître lint/format/test.

Si un `CONTRIBUTING.md` existe, ses règles priment sur les habitudes génériques.

## Étape 2 — Calquer le code existant

Avant d'écrire dans un fichier, regarder les fichiers voisins et imiter :

- Indentation, guillemets, points-virgules.
- Style de nommage (camelCase, snake_case, PascalCase).
- Organisation des imports.
- Densité de commentaires (ne pas commenter plus que le code autour).

Règles :

- Ne pas introduire un style nouveau non justifié.
- Pas de commentaire sauf pour un POURQUOI non évident.
- Faire tourner le formateur / linter du projet si disponible, pas un format perso.
- Jamais le tiret cadratin dans le code, les commentaires ou la doc. Virgule, deux-points ou parenthèses.

## Étape 3 — Commits

1. Lire le style existant : `git log --oneline -20`.
2. Si le repo utilise Conventional Commits (`feat:`, `fix:`, `chore:`...), suivre. Sinon, copier le style dominant du log.
3. Sujet à l'impératif, court (≈50 caractères), sans point final.
4. Corps seulement si le POURQUOI n'est pas évident. Expliquer le pourquoi, pas le quoi.
5. Interdits stricts :
   - Jamais de ligne `Co-Authored-By:`.
   - Jamais le tiret cadratin.

Exemple :

```
feat(auth): ajoute refresh token

Session expirait au bout d'1h, forçait reconnexion. Refresh silencieux évite ça.
```

## Étape 4 — Branches

1. Lire les noms existants : `git branch -a`.
2. Suivre le motif dominant. Si aucun, défaut : `type/description-courte` en kebab-case.
   - `feat/`, `fix/`, `chore/`, `docs/`, `refactor/`.
   - Exemple : `feat/refresh-token`, `fix/login-timeout`.
3. Pas d'espaces, pas de majuscules, pas d'accents.
4. Si `CONTRIBUTING.md` impose un format de branche, il prime.

## Rappel

Ne jamais commit ni push sans que l'utilisateur le demande. Sur branche par défaut (main/master), créer une branche d'abord.
