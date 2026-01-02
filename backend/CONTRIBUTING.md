# Guide de contribution - Adjó Backend

Merci de contribuer au backend Adjó ! Ce guide vous aidera à démarrer.

## Table des matières

1. [Code de conduite](#code-de-conduite)
2. [Comment contribuer](#comment-contribuer)
3. [Standards de code](#standards-de-code)
4. [Workflow Git](#workflow-git)
5. [Pull Requests](#pull-requests)
6. [Architecture](#architecture)

---

## Code de conduite

- Soyez respectueux et professionnel
- Acceptez les critiques constructives
- Focalisez sur ce qui est meilleur pour le projet
- Aidez les nouveaux contributeurs

---

## Comment contribuer

### 1. Issues

Avant de créer une issue:
- ✅ Vérifiez qu'elle n'existe pas déjà
- ✅ Utilisez un titre clair et descriptif
- ✅ Fournissez un maximum de contexte

**Template d'issue:**
```markdown
## Description
[Description claire du problème]

## Steps to reproduce
1. ...
2. ...

## Expected behavior
[Ce qui devrait se passer]

## Actual behavior
[Ce qui se passe réellement]

## Environment
- OS: [Ubuntu 22.04, macOS 13, etc.]
- Rust version: [1.75.0]
- PostgreSQL version: [16.1]
```

### 2. Features

Pour proposer une nouvelle fonctionnalité:
1. Créez une issue avec le label `feature`
2. Décrivez le use case
3. Expliquez pourquoi c'est important
4. Proposez une implémentation (optionnel)

---

## Standards de code

### Style Rust

Suivre les conventions Rust officielles:

```bash
# Formater automatiquement le code
cargo fmt

# Vérifier avec Clippy
cargo clippy -- -D warnings

# Pas d'erreurs ni warnings acceptés
```

### Conventions de nommage

- **Fichiers**: `snake_case.rs`
- **Modules**: `mod my_module;`
- **Structs**: `PascalCase`
- **Functions**: `snake_case()`
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Variables**: `snake_case`

```rust
// ✅ Bon
pub struct UserService {
    db: DatabaseConnection,
}

impl UserService {
    pub fn new(db: DatabaseConnection) -> Self {
        Self { db }
    }

    pub async fn create_user(&self, data: CreateUserRequest) -> Result<User, AppError> {
        // ...
    }
}

const MAX_LOGIN_ATTEMPTS: u32 = 5;

// ❌ Mauvais
pub struct userservice {  // PascalCase requis
    DB: DatabaseConnection,  // snake_case requis
}

pub fn CreateUser() {}  // snake_case requis
```

### Documentation

Documenter toutes les fonctions publiques:

```rust
/// Crée un nouvel utilisateur dans la base de données
///
/// # Arguments
///
/// * `data` - Les données de l'utilisateur à créer
///
/// # Returns
///
/// * `Ok(User)` - L'utilisateur créé avec son ID
/// * `Err(AppError)` - Si l'utilisateur existe déjà ou erreur DB
///
/// # Examples
///
/// ```
/// let user = service.create_user(data).await?;
/// ```
pub async fn create_user(&self, data: CreateUserRequest) -> Result<User, AppError> {
    // ...
}
```

### Gestion des erreurs

Utiliser le type `AppError` personnalisé:

```rust
// ✅ Bon
pub async fn get_user(&self, id: Uuid) -> Result<User, AppError> {
    let user = self.db
        .find_by_id(id)
        .await
        .map_err(|e| AppError::DatabaseError(e.to_string()))?;

    user.ok_or_else(|| AppError::NotFound(format!("User {} not found", id)))
}

// ❌ Mauvais - Utiliser panic!
pub async fn get_user(&self, id: Uuid) -> User {
    self.db.find_by_id(id).await.unwrap()  // ❌ Jamais de unwrap!
}
```

### Logging

Utiliser `tracing` pour les logs:

```rust
use tracing::{info, warn, error, debug};

// Logs structurés
info!(user_id = %user.id, "User created successfully");
warn!(attempts = login_attempts, "Multiple failed login attempts");
error!(error = %e, "Database connection failed");
debug!(query = %sql, "Executing query");
```

### Tests

Chaque fonctionnalité doit avoir des tests:

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_create_user_success() {
        // Arrange
        let service = setup_test_service().await;
        let data = CreateUserRequest {
            phone: "0161762591".to_string(),
            password: "Password123!".to_string(),
        };

        // Act
        let result = service.create_user(data).await;

        // Assert
        assert!(result.is_ok());
        let user = result.unwrap();
        assert_eq!(user.phone, "0161762591");
    }

    #[tokio::test]
    async fn test_create_user_duplicate_phone() {
        // Test des erreurs
        let service = setup_test_service().await;
        let data = CreateUserRequest {
            phone: "0161762591".to_string(),
            password: "Password123!".to_string(),
        };

        // Premier utilisateur OK
        service.create_user(data.clone()).await.unwrap();

        // Deuxième avec même téléphone doit échouer
        let result = service.create_user(data).await;
        assert!(matches!(result, Err(AppError::ValidationError(_))));
    }
}
```

### Sécurité

- ✅ **Jamais** de secrets en dur dans le code
- ✅ Toujours hasher les mots de passe (bcrypt)
- ✅ Valider toutes les entrées utilisateur
- ✅ Utiliser des queries paramétrées (SeaORM)
- ✅ Sanitize les logs (pas de mots de passe)

```rust
// ✅ Bon
info!(user_id = %user.id, "User logged in");

// ❌ Mauvais - Expose le mot de passe
debug!(password = %password, "Login attempt");  // ❌ Dangereux!
```

---

## Workflow Git

### Branches

Structure des branches:

```
main (production)
  ↓
develop (dev principal)
  ↓
feature/nom-feature
fix/nom-bug
hotfix/nom-urgence
```

### Créer une branche

```bash
# Toujours partir de develop
git checkout develop
git pull origin develop

# Créer votre branche
git checkout -b feature/auth-jwt

# Ou pour un fix
git checkout -b fix/login-validation
```

### Nommage des branches

Format: `type/description-courte`

**Types:**
- `feature/` - Nouvelle fonctionnalité
- `fix/` - Correction de bug
- `hotfix/` - Correction urgente en production
- `refactor/` - Refactoring sans changement fonctionnel
- `docs/` - Documentation seulement
- `test/` - Ajout de tests

**Exemples:**
```bash
feature/user-registration
feature/tontine-smart-contract
fix/jwt-expiration
fix/database-connection-pool
refactor/error-handling
docs/api-endpoints
test/integration-tests
```

### Commits

Format: `type(scope): description`

**Types de commits:**
- `feat` - Nouvelle fonctionnalité
- `fix` - Correction de bug
- `docs` - Documentation
- `style` - Formatage (sans changement de code)
- `refactor` - Refactoring
- `test` - Ajout de tests
- `chore` - Maintenance (deps, config, etc.)

**Exemples:**
```bash
git commit -m "feat(auth): add JWT token generation"
git commit -m "fix(database): resolve connection pool leak"
git commit -m "docs(api): update Postman collection"
git commit -m "test(auth): add login integration tests"
git commit -m "refactor(handlers): extract validation logic"
git commit -m "chore(deps): update axum to 0.7.1"
```

**Message complet:**
```bash
git commit -m "feat(auth): add JWT token generation

- Implement JWT service with access and refresh tokens
- Add token expiration configuration
- Add tests for token generation and verification

Closes #123"
```

---

## Pull Requests

### Avant de soumettre

Checklist:
- [ ] Le code compile sans erreurs
- [ ] `cargo fmt` exécuté
- [ ] `cargo clippy` sans warnings
- [ ] Tests passent: `cargo test`
- [ ] Documentation à jour
- [ ] Migrations SQL incluses (si applicable)
- [ ] `.env.example` mis à jour (si nouvelles variables)

### Template PR

```markdown
## Description
[Description claire de ce qui a été fait]

## Type de changement
- [ ] Feature (nouvelle fonctionnalité)
- [ ] Fix (correction de bug)
- [ ] Refactor (refactoring sans changement fonctionnel)
- [ ] Docs (documentation seulement)

## Checklist
- [ ] Code formaté avec `cargo fmt`
- [ ] Pas de warnings `cargo clippy`
- [ ] Tests ajoutés/mis à jour
- [ ] Tests passent localement
- [ ] Documentation mise à jour
- [ ] Migrations incluses (si DB change)

## Tests
[Comment tester cette PR]

```bash
# Exemple de test
cargo test auth::test_jwt_generation
curl -X POST http://localhost:8000/api/auth/login -d '{"phone":"...","password":"..."}'
```

## Screenshots (si UI)
[Si applicable]

## Related Issues
Closes #123
Related to #456
```

### Review Process

1. **Auto-checks**: CI doit passer (tests, clippy, fmt)
2. **Code review**: Au moins 1 approbation requise
3. **Testing**: Reviewer doit tester localement
4. **Merge**: Squash & merge dans develop

### Merge

```bash
# Ne jamais merge directement dans main
# Passer par develop d'abord

# Après approbation PR
git checkout develop
git pull origin develop
git merge --no-ff feature/ma-feature
git push origin develop
```

---

## Architecture

### Structure des dossiers

```
src/
├── main.rs              # Point d'entrée
├── router.rs            # Routes API
├── config/              # Configuration
│   ├── app.rs
│   └── database.rs
├── handlers/            # HTTP handlers (contrôleurs)
│   ├── auth.rs
│   ├── tontine.rs
│   └── ...
├── services/            # Business logic
│   ├── auth_service.rs
│   ├── tontine_service.rs
│   └── ...
├── repositories/        # Data access (à venir)
│   ├── user_repository.rs
│   └── ...
├── models/              # DTOs
│   ├── auth.rs
│   ├── common.rs
│   └── ...
├── errors/              # Error handling
│   └── app_error.rs
├── middleware/          # Middleware
│   ├── auth.rs
│   └── rate_limit.rs
├── blockchain/          # Stellar integration
│   ├── wallet.rs
│   └── transactions.rs
└── utils/               # Utilities
    ├── crypto.rs
    └── validator.rs
```

### Patterns

#### 1. Handler → Service → Repository

```rust
// Handler (HTTP layer)
pub async fn create_user(
    State(state): State<AppState>,
    Json(data): Json<CreateUserRequest>,
) -> Result<Json<ApiResponse<User>>, AppError> {
    let user = state.auth_service.create_user(data).await?;
    Ok(Json(ApiResponse::success(user)))
}

// Service (business logic)
impl AuthService {
    pub async fn create_user(&self, data: CreateUserRequest) -> Result<User, AppError> {
        // Validation
        data.validate()?;

        // Hash password
        let password_hash = hash_password(&data.password)?;

        // Call repository
        let user = self.user_repo.create(User {
            phone: data.phone,
            password_hash,
            ...
        }).await?;

        // Create Stellar wallet
        let wallet = self.blockchain_service.create_wallet().await?;

        Ok(user)
    }
}

// Repository (data access)
impl UserRepository {
    pub async fn create(&self, user: User) -> Result<User, DbErr> {
        let user_model = user.into_active_model();
        user_model.insert(&self.db).await
    }
}
```

#### 2. Dependency Injection

```rust
// main.rs
#[derive(Clone)]
pub struct AppState {
    pub db: DatabaseConnection,
    pub config: Arc<AppConfig>,
    pub auth_service: Arc<AuthService>,
    pub tontine_service: Arc<TontineService>,
}

let state = AppState {
    db: db.clone(),
    config: Arc::new(app_config),
    auth_service: Arc::new(AuthService::new(db.clone())),
    tontine_service: Arc::new(TontineService::new(db)),
};
```

---

## Ressources

- [Rust Book](https://doc.rust-lang.org/book/)
- [Axum Documentation](https://docs.rs/axum)
- [SeaORM Documentation](https://www.sea-ql.org/SeaORM/)
- [Stellar Developer Docs](https://developers.stellar.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## Questions?

- Créez une issue avec le label `question`
- Consultez les discussions GitHub
- Lisez la documentation dans `/docs`

Merci de contribuer à Adjó ! 🚀
