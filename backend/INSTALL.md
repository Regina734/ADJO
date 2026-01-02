# Guide d'installation - Adjó Backend API

Guide complet pour installer et configurer le backend Rust d'Adjó sur votre machine de développement.

## Table des matières

1. [Prérequis](#prérequis)
2. [Installation pas à pas](#installation-pas-à-pas)
3. [Configuration](#configuration)
4. [Lancement](#lancement)
5. [Tests](#tests)
6. [Troubleshooting](#troubleshooting)
7. [Documentation API](#documentation-api)

---

## Prérequis

### Système d'exploitation supportés
- Linux (Ubuntu 20.04+, Debian 11+, Fedora 35+)
- macOS 11+
- Windows 10/11 (avec WSL2 recommandé)

### Logiciels requis

#### 1. Rust 1.75+
```bash
# Installation via rustup (recommandé)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Recharger l'environnement
source $HOME/.cargo/env

# Vérifier l'installation
rustc --version
cargo --version
```

#### 2. PostgreSQL 16+

**Linux (Ubuntu/Debian):**
```bash
# Ajouter le repository PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install postgresql-16 postgresql-client-16
```

**macOS:**
```bash
brew install postgresql@16
brew services start postgresql@16
```

**Ou via Docker (recommandé):**
```bash
# Docker et Docker Compose sont requis
docker --version
docker-compose --version

# Le projet inclut un docker-compose.yml
```

#### 3. psql client
```bash
# Ubuntu/Debian
sudo apt install postgresql-client

# macOS
brew install libpq
```

#### 4. Git
```bash
# Ubuntu/Debian
sudo apt install git

# macOS
brew install git
```

---

## Installation pas à pas

### Étape 1: Cloner le repository

```bash
# Cloner le projet
git clone <repository-url>
cd ADJO/backend

# Vérifier la structure
ls -la
```

Vous devriez voir:
```
backend/
├── Cargo.toml
├── docker-compose.yml
├── .env.example
├── migrations/
├── src/
└── ...
```

### Étape 2: Configuration de l'environnement

```bash
# Copier le fichier d'exemple
cp .env.example .env

# Éditer avec vos configurations
nano .env  # ou vim, code, etc.
```

**Variables critiques à configurer:**

```env
# Base de données (si vous utilisez PostgreSQL local)
DATABASE_URL=postgresql://adjo_user:adjo_password@localhost:5432/adjo_db

# JWT Secret (IMPORTANT: Changer en production!)
JWT_SECRET=your-unique-secret-key-here-minimum-32-chars

# Encryption key pour les private keys Stellar (32 bytes)
ENCRYPTION_KEY=your-32-byte-encryption-key-change-this!!

# SMS Twilio (optionnel en dev)
TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_PHONE_NUMBER=+1234567890

# Stellar (testnet pour dev)
STELLAR_NETWORK=testnet
STELLAR_HORIZON_URL=https://horizon-testnet.stellar.org
```

### Étape 3: Base de données

**Option A: Utiliser Docker (recommandé)**

```bash
# Démarrer PostgreSQL avec Docker Compose
docker-compose up -d postgres

# Attendre que PostgreSQL soit prêt (10-15 secondes)
sleep 10

# Vérifier que le container est en cours d'exécution
docker ps | grep adjo-postgres
```

**Option B: PostgreSQL local**

```bash
# Se connecter à PostgreSQL
sudo -u postgres psql

# Dans psql, créer la base de données et l'utilisateur
CREATE DATABASE adjo_db;
CREATE USER adjo_user WITH PASSWORD 'adjo_password';
GRANT ALL PRIVILEGES ON DATABASE adjo_db TO adjo_user;
\q
```

### Étape 4: Exécuter les migrations

```bash
# Rendre le script exécutable
chmod +x scripts/run_migrations.sh

# Exécuter les migrations
./scripts/run_migrations.sh
```

Ou manuellement:
```bash
# Via Docker
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -f migrations/001_create_users.sql
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -f migrations/002_create_auth_tables.sql
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -f migrations/003_create_boxes.sql
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -f migrations/004_create_communities.sql
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -f migrations/005_create_tontines.sql
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -f migrations/006_create_faq_and_notifications.sql

# Via PostgreSQL local (port 5432)
PGPASSWORD=adjo_password psql -h localhost -U adjo_user -d adjo_db -f migrations/001_create_users.sql
# ... répéter pour les autres migrations
```

**Vérifier les tables:**
```bash
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -c "\dt"
```

Vous devriez voir 15 tables:
- users
- subscriptions
- otp_codes
- jwt_blacklist
- tontines
- tontine_members
- tontine_contributions
- community_tontines
- boxes
- box_transactions
- communities
- community_members
- faq_items
- advertisements
- notifications

### Étape 5: Compiler le projet

```bash
# Première compilation (peut prendre 5-10 minutes)
cargo build

# Pour un build de production optimisé
cargo build --release
```

**Note:** La première compilation télécharge toutes les dépendances. Les compilations suivantes seront beaucoup plus rapides.

**Résolution des erreurs de compilation courantes:**

```bash
# Si erreur "openssl not found"
sudo apt install pkg-config libssl-dev  # Ubuntu/Debian
brew install openssl  # macOS

# Si erreur "postgresql not found"
sudo apt install libpq-dev  # Ubuntu/Debian
brew install postgresql  # macOS
```

---

## Lancement

### Développement

```bash
# Lancer le serveur en mode debug
cargo run

# Ou avec logs détaillés
RUST_LOG=debug cargo run
```

Le serveur démarre sur `http://0.0.0.0:8000`

### Production

```bash
# Compiler en mode release
cargo build --release

# Lancer le binaire optimisé
./target/release/adjo-backend
```

### Avec Docker Compose (tout-en-un)

```bash
# Décommenter la section backend dans docker-compose.yml
# Puis lancer:
docker-compose up -d

# Voir les logs
docker-compose logs -f backend

# Arrêter
docker-compose down
```

---

## Tests

### Tester le serveur

```bash
# Health check
curl http://localhost:8000/health

# Réponse attendue:
{
  "status": "ok",
  "app": "Adjo",
  "version": "0.1.0",
  "environment": "development",
  "database": "healthy"
}
```

### Tests unitaires

```bash
# Lancer tous les tests
cargo test

# Avec logs détaillés
cargo test -- --nocapture

# Test d'un module spécifique
cargo test config::
```

### Tests d'intégration

```bash
# À venir - les tests d'intégration seront dans tests/integration/
cargo test --test '*'
```

### Coverage

```bash
# Installer tarpaulin
cargo install cargo-tarpaulin

# Générer le coverage
cargo tarpaulin --out Html
```

---

## Configuration

### Variables d'environnement complètes

| Variable | Description | Valeur par défaut | Requis |
|----------|-------------|-------------------|--------|
| `APP_NAME` | Nom de l'application | Adjo | Non |
| `APP_ENV` | Environnement | development | Non |
| `APP_HOST` | Host du serveur | 0.0.0.0 | Non |
| `APP_PORT` | Port du serveur | 8000 | Non |
| `LOG_LEVEL` | Niveau de logs | debug | Non |
| `DATABASE_URL` | URL PostgreSQL | - | **Oui** |
| `DATABASE_MAX_CONNECTIONS` | Pool max | 100 | Non |
| `DATABASE_MIN_CONNECTIONS` | Pool min | 5 | Non |
| `JWT_SECRET` | Secret JWT | - | **Oui** |
| `JWT_ACCESS_TOKEN_EXPIRY` | Expiration access token (sec) | 3600 | Non |
| `JWT_REFRESH_TOKEN_EXPIRY` | Expiration refresh token (sec) | 2592000 | Non |
| `BCRYPT_COST` | Coût bcrypt | 10 | Non |
| `OTP_EXPIRY_MINUTES` | Expiration OTP | 5 | Non |
| `OTP_MAX_ATTEMPTS` | Tentatives OTP max | 5 | Non |
| `ENCRYPTION_KEY` | Clé chiffrement Stellar keys | - | **Oui** |
| `TWILIO_ACCOUNT_SID` | Twilio SID | - | Non (dev) |
| `TWILIO_AUTH_TOKEN` | Twilio token | - | Non (dev) |
| `TWILIO_PHONE_NUMBER` | Numéro Twilio | - | Non (dev) |
| `STELLAR_NETWORK` | Réseau Stellar | testnet | Non |
| `STELLAR_HORIZON_URL` | URL Horizon | https://horizon-testnet.stellar.org | Non |
| `CORS_ALLOWED_ORIGINS` | Origins CORS | http://localhost:3000 | Non |

### Ports utilisés

| Service | Port par défaut | Configurable |
|---------|----------------|--------------|
| API Backend | 8000 | Oui (APP_PORT) |
| PostgreSQL (Docker) | 5433 | Oui (docker-compose.yml) |
| PostgreSQL (local) | 5432 | - |
| Redis (Docker) | 6379 | - |

---

## Documentation API

### Postman Collection

Importer dans Postman:
```bash
# Fichier à importer
Adjo_API.postman_collection.json
```

**Utilisation:**
1. Ouvrir Postman
2. File → Import → Sélectionner `Adjo_API.postman_collection.json`
3. La collection "Adjó API" apparaît avec tous les endpoints
4. Configurer la variable `{{baseUrl}}` = `http://localhost:8000`
5. Pour les endpoints auth: le token est auto-sauvegardé après login

### Endpoints disponibles

**Phase 1 (Actuelle):**
- ✅ `GET /health` - Health check

**Phase 2+ (À venir):**
- 🔄 Auth (7 endpoints): register, login, logout, verify-otp, forgot-password, reset-password, refresh
- 🔄 Tontines (10 endpoints): CRUD + contribute + distribute + members
- 🔄 Box (8 endpoints): CRUD + deposit + withdraw + transactions
- 🔄 Communities (9 endpoints): CRUD + members + tontines + join by code
- 🔄 User (5 endpoints): profile + dashboard + notifications
- 🔄 Subscription (4 endpoints): plans + upgrade + cancel + status
- 🔄 FAQ (3 endpoints): faq + demo scenarios + simulate
- 🔄 Ads (2 endpoints): get ads + track view
- 🔄 Blockchain (3 endpoints): wallet + balance + transactions

---

## Troubleshooting

### Problème: "Port already in use"

```bash
# Trouver le processus utilisant le port 8000
sudo lsof -i :8000

# Ou changer le port dans .env
APP_PORT=8001
```

### Problème: "Database connection failed"

```bash
# Vérifier que PostgreSQL est actif
docker ps | grep postgres  # Si Docker
sudo systemctl status postgresql  # Si local

# Tester la connexion manuellement
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -c "SELECT 1;"

# Vérifier DATABASE_URL dans .env
cat .env | grep DATABASE_URL
```

### Problème: "JWT_SECRET must be set"

```bash
# Ajouter dans .env
JWT_SECRET=$(openssl rand -base64 32)
echo "JWT_SECRET=$JWT_SECRET" >> .env
```

### Problème: Compilation lente

```bash
# Utiliser le linker mold (Linux)
cargo install mold
# Ajouter dans ~/.cargo/config.toml:
# [target.x86_64-unknown-linux-gnu]
# linker = "clang"
# rustflags = ["-C", "link-arg=-fuse-ld=mold"]

# Ou utiliser sccache
cargo install sccache
export RUSTC_WRAPPER=sccache
```

### Problème: "Migration already applied"

```bash
# Vérifier l'état des tables
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -c "\dt"

# Si besoin de reset (ATTENTION: supprime toutes les données)
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

# Puis relancer les migrations
./scripts/run_migrations.sh
```

### Problème: Erreur Stellar SDK

```bash
# Les packages Stellar sont optionnels
# Si erreur de compilation, désactiver temporairement:
cargo build --no-default-features
```

---

## Commandes utiles

### Développement

```bash
# Formater le code
cargo fmt

# Linter
cargo clippy

# Vérifier sans compiler
cargo check

# Watch mode (recompile automatiquement)
cargo install cargo-watch
cargo watch -x run

# Nettoyer les builds
cargo clean
```

### Base de données

```bash
# Connexion psql
PGPASSWORD=adjo_password psql -h localhost -p 5433 -U adjo_user -d adjo_db

# Dump de la base
pg_dump -h localhost -p 5433 -U adjo_user adjo_db > backup.sql

# Restore
psql -h localhost -p 5433 -U adjo_user -d adjo_db < backup.sql

# Voir les tables
\dt

# Décrire une table
\d users

# Compter les lignes
SELECT COUNT(*) FROM users;
```

### Docker

```bash
# Logs PostgreSQL
docker logs adjo-postgres

# Shell dans le container
docker exec -it adjo-postgres psql -U adjo_user -d adjo_db

# Restart container
docker-compose restart postgres

# Voir l'utilisation des ressources
docker stats
```

---

## Structure du code

```
src/
├── main.rs              # Point d'entrée
├── router.rs            # Définition des routes
├── config/              # Configuration (app, database, jwt)
├── handlers/            # HTTP handlers (controllers)
├── services/            # Business logic
├── repositories/        # Data access layer (à venir)
├── models/              # DTOs Request/Response
├── errors/              # Gestion des erreurs
├── middleware/          # Middleware (auth, rate limit)
├── blockchain/          # Intégration Stellar
├── sms/                 # Provider SMS (Twilio)
└── utils/               # Utilities (crypto, validation)
```

---

## Prochaines étapes

Après installation réussie:

1. **Lire le plan d'implémentation**: `~/.claude/plans/floofy-sprouting-fox.md`
2. **Consulter le README**: `README.md` pour la roadmap
3. **Implémenter Phase 2**: Authentification JWT + OTP
4. **Contribuer**: Suivre les conventions Rust (`cargo fmt`, `cargo clippy`)
5. **Tester**: Ajouter des tests pour chaque feature

---

## Support

Pour toute question:
- **Documentation Axum**: https://docs.rs/axum
- **Documentation SeaORM**: https://www.sea-ql.org/SeaORM/
- **Documentation Stellar**: https://developers.stellar.org/
- **Rust Book**: https://doc.rust-lang.org/book/

---

## Licence

Propriétaire - Adjó Project © 2026
