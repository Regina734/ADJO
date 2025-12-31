#  Adjó Backend - Rust API

API REST en Rust pour Adjó.

##  En développement

Cette partie du projet est en cours de développement.

##  Stack technique prévu

- **Language**: Rust 1.75+
- **Framework**: Actix-web / Rocket
- **Database**: PostgreSQL
- **ORM**: Diesel / SeaORM
- **Auth**: JWT
- **Blockchain**: Intégration Stellar

##  Structure prévue
```
backend/
├── src/
│   ├── main.rs
│   ├── api/
│   │   ├── auth.rs
│   │   ├── tontine.rs
│   │   ├── community.rs
│   │   └── box.rs
│   ├── models/
│   ├── services/
│   ├── database/
│   └── blockchain/
├── migrations/
├── tests/
└── Cargo.toml
```

##  Installation (à venir)
```bash
cargo build
cargo run
```

##  Endpoints prévus

- `POST /api/auth/register` - Inscription
- `POST /api/auth/login` - Connexion
- `GET /api/tontines` - Liste des tontines
- `POST /api/tontines` - Créer une tontine
- `GET /api/communities` - Liste des communautés
- `POST /api/communities` - Créer une communauté
- `GET /api/box` - Épargne individuelle

##  Tests
```bash
cargo test
```

##  Documentation

- [Rust Book](https://doc.rust-lang.org/book/)
- [Actix Web](https://actix.rs/)