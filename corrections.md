# Corrections

- bon README
- code compile, 
- tests run (un seul test)
mais
- pas de repertoire `deploy` ni de script de déploiement ou des tests d'integrations
- pas de transfer de token dasn le smart contract 
- la fonctionnalité `kill` version dégradée (sans remboursement)
- pas de gestion de la periode de gel.

## Remarques

## Dans le README

- ne pas dire qu'on peux déployer si les scripts ne sont pas fourni

## Dans le code

- bonne structure de données
- bonne organisation de code (fonctions) mais pas de module d'erreur

- l'entrypoint `start` ne lock pas les fonds sur le contrat (`get_self_address`) comme stipulé dans l'énoncé.

- l'entrypoint `kill` ne rembourse pas les beneficiaires  comme stipulé dans l'énoncé.

- l'entrypoint `claim` ne rembourse pas le beneficiaire, le storage est bien mis à jour mais il manque le transfer de token (comme stipulé dans l'énoncé).



## Dans les tests unitaires

- il n'y a qu'un seul test
- pas de tests en milieu de vesting


## Dans le script de déploiement

- pas de script de déploiement
