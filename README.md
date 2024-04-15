# Smart Contract de Vesting sur Tezos 📜

Bienvenue dans le dépôt du Smart Contract de Vesting pour Tezos ! Ce projet contient un smart contract conçu pour gérer les processus de vesting sur la blockchain Tezos. Il permet aux administrateurs de mettre en place des calendriers de vesting pour les bénéficiaires, qui peuvent ensuite réclamer leurs montants alloués au fil du temps.

## Fonctionnalités 🌟

- **Contrôles Administrateur** : Seul l'administrateur peut initier le contrat, ajouter des bénéficiaires, et arrêter le contrat.
- **Calendrier de Vesting** : Les bénéficiaires reçoivent leurs tokens selon un calendrier de vesting prédéfini.
- **Mécanisme de Réclamation** : Les bénéficiaires peuvent réclamer leur montant vesté selon le calendrier.
- **Vérifications de Sécurité** : Assure que le contrat est dans le bon état avant toute opération critique.

## Pour Commencer 🚀

### Prérequis

- [Ligo](https://ligolang.org/docs/intro/installation) installé sur votre machine ou utiliser une image Docker.
- [Node.js](https://nodejs.org/) et npm pour le déploiement du contrat.

### Installation

1. Clonez le dépôt :

   ```bash
   git clone https://github.com/hmzaakun/vestingTezos.git
   cd https://github.com/hmzaakun/vestingTezos.git
   ```

2. Installez les dépendances :
   ```bash
   make install
   ```

### Compiler le Contrat

Pour compiler le smart contract en Michelson :

```bash
make compile
```

### Tests

Exécutez les tests pour vous assurer que le contrat se comporte comme prévu :

```bash
make test
```

### coming soon : Déploiement

Pour déployer le smart contract sur un testnet ou le mainnet de Tezos :

```bash
make deploy // coming soon
```

## Utilisation 🛠

- **Démarrer le Vesting** : Seul l'administrateur peut démarrer le calendrier de vesting.
- **Ajouter un Bénéficiaire** : L'administrateur peut ajouter des bénéficiaires avant de démarrer le contrat.
- **Réclamer des Tokens** : Les bénéficiaires peuvent réclamer leurs tokens selon le calendrier de vesting.
- **Arrêter le Contrat** : L'administrateur peut arrêter le contrat si nécessaire.

## Contribution 🤝

Les contributions sont ce qui rend la communauté open-source si fantastique pour apprendre, inspirer et créer. Toutes les contributions que vous faites sont **grandement appréciées**. 🫡

## Licence 📄

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE.md) pour les détails.
