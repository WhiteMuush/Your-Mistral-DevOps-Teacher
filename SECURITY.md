# Sécurité

## Portée

Ce dépôt ne contient pas de code applicatif : un script d'installation (`install.sh`), des fichiers de configuration et des prompts. Les risques principaux sont donc :

- **`install.sh`** : il écrit dans `$VIBE_HOME` (par défaut `~/.vibe`) et modifie `config.toml`. Il ne télécharge rien, ne lance rien d'autre, ne demande jamais d'élévation de privilèges. Lisez-le avant de l'exécuter, il fait 50 lignes
- **Les prompts et skills** : ils orientent le comportement d'un agent IA qui, lui, exécute des commandes. Aucune règle de ce dépôt n'affaiblit les protections de Vibe (les permissions d'outils restent celles de votre `config.toml`). Le system prompt interdit explicitement les push git non demandés

## Ce que ce dépôt ne fait jamais

- Collecter ou transmettre des données
- Toucher aux clés API ou aux secrets (les patterns `.env` restent protégés par la config Vibe de l'utilisateur)
- Désactiver les confirmations d'outils de Vibe

## Signaler une vulnérabilité

Si vous trouvez un problème de sécurité (par exemple une règle de prompt qui pourrait pousser l'agent à un comportement dangereux) :

1. De préférence : [GitHub Security Advisories](https://github.com/WhiteMuush/Your-Mistral-DevOps-Teacher/security/advisories/new) (rapport privé)
2. Sinon : ouvrez une issue en décrivant le contexte, sans détailler l'exploitation si elle est sensible

Pas de programme de bug bounty : c'est un projet personnel, mais les rapports sont lus et traités.
