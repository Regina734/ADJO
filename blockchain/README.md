#  Adjó Blockchain - Stellar Smart Contracts

Smart contracts sur Stellar pour Adjó.

##  En développement

Cette partie du projet est en cours de développement.

##  Stack technique prévu

- **Blockchain**: Stellar
- **Smart Contracts**: Soroban (Rust)
- **SDK**: Stellar SDK
- **Network**: Testnet puis Mainnet

##  Structure prévue
```
blockchain/
├── contracts/
│   ├── tontine.rs          # Gestion des cycles de tontine
│   ├── staking.rs          # Système de récompenses
│   └── wallet.rs           # Gestion des portefeuilles
├── tests/
│   ├── tontine_test.rs
│   └── integration_tests.rs
└── scripts/
    ├── deploy.sh
    └── test.sh
```

##  Smart Contracts prévus

### 1. Tontine Contract
- Création de tontines
- Gestion des tours
- Distribution automatique
- Règles personnalisables

### 2. Staking Contract
- Système de récompenses
- Verrouillage de tokens
- Distribution des gains

### 3. Wallet Contract
- Gestion sécurisée des fonds
- Multi-signature
- Historique transparent

##  Installation (à venir)
```bash
# Installer Soroban CLI
cargo install --locked soroban-cli

# Build contracts
soroban contract build

# Deploy sur testnet
soroban contract deploy --wasm target/wasm32-unknown-unknown/release/tontine.wasm --network testnet
```

##  Tests
```bash
cargo test
```

##  Documentation

- [Stellar Developers](https://developers.stellar.org/)
- [Soroban Docs](https://soroban.stellar.org/)
- [Smart Contracts Guide](https://soroban.stellar.org/docs)