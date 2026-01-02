# Adjó Backend - Rust API

API REST en Rust pour Adjó, une application de tontine décentralisée avec blockchain Stellar.

## Stack Technique

- **Language**: Rust 1.75+
- **Framework**: Axum (async web framework)
- **Database**: PostgreSQL 16
- **ORM**: SeaORM
- **Auth**: JWT + bcrypt
- **Blockchain**: Stellar SDK
- **SMS**: Twilio

## Prérequis

- Rust 1.75 ou supérieur
- Docker & Docker Compose
- PostgreSQL 16 (ou via Docker)
- psql client (pour les migrations)

## Installation

### 1. Cloner et configurer

```bash
cd backend
cp .env.example .env
# Éditer .env avec vos configurations
```

### 2. Démarrer la base de données

```bash
# Démarrer PostgreSQL avec Docker Compose
docker-compose up -d postgres

# Ou sur votre système local
# Assurez-vous que PostgreSQL est en cours d'exécution
```

### 3. Exécuter les migrations

```bash
chmod +x scripts/run_migrations.sh
./scripts/run_migrations.sh
```

### 4. Compiler et lancer le serveur

```bash
cargo build
cargo run
```

Le serveur démarre sur `http://0.0.0.0:8000`

## Structure du Projet

```
backend/
├── Cargo.toml                  # Dépendances Rust
├── docker-compose.yml          # PostgreSQL + Redis
├── Dockerfile                  # Image Docker production
├── .env                        # Variables d'environnement
├── migrations/                 # Migrations SQL
│   ├── 001_create_users.sql
│   ├── 002_create_auth_tables.sql
│   ├── 003_create_boxes.sql
│   ├── 004_create_communities.sql
│   ├── 005_create_tontines.sql
│   └── 006_create_faq_and_notifications.sql
├── src/
│   ├── main.rs                 # Point d'entrée
│   ├── router.rs               # Définition des routes
│   ├── config/                 # Configuration (app, database)
│   ├── handlers/               # HTTP handlers
│   ├── services/               # Business logic
│   ├── models/                 # DTOs Request/Response
│   ├── errors/                 # Gestion des erreurs
│   ├── middleware/             # Middleware (auth, rate limit)
│   ├── blockchain/             # Intégration Stellar
│   ├── sms/                    # Provider SMS (Twilio)
│   └── utils/                  # Utilities (crypto, validation)
└── tests/                      # Tests

```

## Endpoints API

### Health Check
- `GET /health` - Vérifier le statut du serveur

### À implémenter (selon le plan)

#### Auth (7 endpoints)
- `POST /api/auth/register` - Inscription + OTP
- `POST /api/auth/verify-otp` - Vérification OTP
- `POST /api/auth/login` - Connexion JWT
- `POST /api/auth/logout` - Déconnexion
- `POST /api/auth/forgot-password` - Envoi OTP reset
- `POST /api/auth/reset-password` - Réinitialisation mot de passe
- `POST /api/auth/refresh` - Refresh token

#### Tontines (10 endpoints)
- `POST /api/tontines` - Créer tontine
- `GET /api/tontines` - Lister tontines
- `GET /api/tontines/:id` - Détails tontine
- `PUT /api/tontines/:id` - Modifier tontine
- `DELETE /api/tontines/:id` - Supprimer tontine
- Plus...

#### Box (8 endpoints)
- `POST /api/box` - Créer box
- `GET /api/box` - Lister boxes
- Plus...

#### Communities (9 endpoints)
#### User (5 endpoints)
#### Subscription (4 endpoints)
#### FAQ & Learning (3 endpoints)
#### Ads (2 endpoints)
#### Blockchain (3 endpoints)

## Schéma de Base de Données

### Tables principales

1. **users** - Utilisateurs de l'application
2. **subscriptions** - Abonnements (free/premium)
3. **tontines** - Tontines (classiques ou blockchain)
4. **tontine_members** - Membres des tontines
5. **tontine_contributions** - Contributions aux tontines
6. **boxes** - Épargne individuelle
7. **box_transactions** - Transactions des boxes
8. **communities** - Communautés
9. **community_members** - Membres des communautés
10. **faq_items** - FAQ multilingue (FR, EN, FON)
11. **advertisements** - Publicités
12. **notifications** - Notifications utilisateur
13. **otp_codes** - Codes OTP pour authentification
14. **jwt_blacklist** - Tokens révoqués

## Tests

```bash
# Tests unitaires
cargo test

# Tests avec coverage
cargo tarpaulin --out Html
```

## Docker

### Build et lancer avec Docker

```bash
# Build l'image
docker build -t adjo-backend .

# Lancer tout (PostgreSQL + backend)
docker-compose up -d

# Logs
docker-compose logs -f backend
```

## Développement

### Ordre d'implémentation (Phases)

**Phase 1 (Actuelle)**: Infrastructure de base ✅
- [x] Setup projet
- [x] Configuration
- [x] Database migrations
- [x] Error handling
- [x] Logging

**Phase 2**: Authentification JWT + OTP
- [ ] User model & repository
- [ ] Auth services
- [ ] JWT service
- [ ] OTP service
- [ ] SMS integration (Twilio)
- [ ] Auth handlers

**Phase 3**: Blockchain Stellar
- [ ] Stellar client
- [ ] Wallet management
- [ ] Basic transactions

**Phase 4**: My Box (Épargne)
**Phase 5**: My Tontine
**Phase 6**: My Community
**Phase 7**: Subscription & Monétisation
**Phase 8**: FAQ & Demo
**Phase 9**: Notifications
**Phase 10**: Tests & Deployment

## Sécurité

- **Passwords**: bcrypt (cost 10-12)
- **JWT**: HS256, expiration 1h access / 30j refresh
- **Private Keys**: Chiffrement AES-256
- **OTP**: 5 min expiration, 5 tentatives max
- **Rate Limiting**: 100 req/min
- **SQL Injection**: Queries paramétrées (SeaORM)
- **CORS**: Whitelist origins

## Configuration Environnement

Voir `.env.example` pour toutes les variables disponibles.

Variables critiques:
- `DATABASE_URL` - URL PostgreSQL
- `JWT_SECRET` - Secret pour JWT (changer en production!)
- `ENCRYPTION_KEY` - Clé pour chiffrer les private keys Stellar
- `TWILIO_*` - Credentials Twilio pour SMS
- `STELLAR_*` - Configuration blockchain Stellar

## Contribution

1. Suivre le plan d'implémentation (voir `/home/eben/.claude/plans/floofy-sprouting-fox.md`)
2. Écrire des tests pour chaque feature
3. Respecter les conventions Rust (cargo fmt, cargo clippy)

## Licence

Propriétaire - Adjó Project

## Support

Pour toute question technique, consulter:
- [Documentation Axum](https://docs.rs/axum)
- [Documentation SeaORM](https://www.sea-ql.org/SeaORM/)
- [Stellar Docs](https://developers.stellar.org/)
