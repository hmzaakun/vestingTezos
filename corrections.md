# Corrections

Merci pour ton travail, le ligo semble bien compris, ainsi que l'utilisation du framework de test. 
La prise en main du repo (README, et commandes qui fonctionnent) est bien. 
Malheureusement, les consignes ne sont pas entièrement respectées (pas de transfer de token, pas de freeze, kill dégradé, pas de script de déploiement). C'est dommage car le transfer de token était le but de l'exercice.

## Remarques

- bon README
- code compile, 
- tests run (un seul test)
mais
- pas de repertoire `deploy` ni de script de déploiement ou des tests d'integrations
- pas de transfer de token dasn le smart contract 
- la fonctionnalité `kill` version dégradée (sans remboursement)
- pas de gestion de la periode de gel.


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
