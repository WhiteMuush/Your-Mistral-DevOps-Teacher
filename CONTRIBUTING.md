# Contribuer

Les contributions sont bienvenues : nouveau skill, amélioration d'un guide existant, correction du system prompt.

## Avant de proposer

1. Lisez le [wiki](https://github.com/WhiteMuush/Your-Mistral-DevOps-Teacher/wiki) : il explique pourquoi la config est structurée en trois couches. Une règle au mauvais endroit (AGENTS.md au lieu du system prompt, ou l'inverse) sera refusée avec renvoi vers la page Architecture
2. Chaque règle doit venir d'un **problème observé**, pas d'une intuition. Décrivez le cas d'échec dans la PR

## Tester vos changements

Installez dans un dossier jetable, sans toucher votre vraie config :

```bash
VIBE_HOME=/tmp/vibe-test bash install.sh
```

Pour une modification du system prompt ou d'un skill, joignez à la PR un **test différentiel** : une question dont la réponse diffère selon que la règle est active ou non, et les deux réponses observées. Voir la page wiki "Les skills" pour la méthode.

## Conventions

- **Skills** : un dossier par skill, `SKILL.md` à l'intérieur, frontmatter avec `name`, `description` et `user-invocable: true`. La description doit lister les mots-clés déclencheurs
- **Français** : tout le contenu utilisateur est en français
- **Pas de tiret cadratin** dans les textes : virgule, deux-points ou parenthèses
- **Commits** : format conventionnel (`feat:`, `fix:`, `docs:`), sujet à 50 caractères max, pas de ligne `Co-Authored-By`
- **Branches** : lettres, chiffres, tirets et slash uniquement (`feat/nouveau-skill-k8s`)

## Ce qui ne sera pas accepté

- Des règles qui affaiblissent les protections de Vibe (auto-approve, push automatique, contournement des confirmations)
- Des skills sans méthode concrète (les collections de généralités "utilisez les bonnes pratiques" n'aident personne)
- Du contenu en anglais dans les prompts utilisateur
