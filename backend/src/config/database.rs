use sea_orm::{Database, DatabaseConnection, DbErr};
use std::env;

#[derive(Debug, Clone)]
pub struct DatabaseConfig {
    pub url: String,
    pub max_connections: u32,
    pub min_connections: u32,
}

impl DatabaseConfig {
    pub fn from_env() -> Result<Self, String> {
        Ok(Self {
            url: env::var("DATABASE_URL")
                .map_err(|_| "DATABASE_URL must be set".to_string())?,
            max_connections: env::var("DATABASE_MAX_CONNECTIONS")
                .unwrap_or_else(|_| "100".to_string())
                .parse()
                .map_err(|e| format!("Invalid DATABASE_MAX_CONNECTIONS: {}", e))?,
            min_connections: env::var("DATABASE_MIN_CONNECTIONS")
                .unwrap_or_else(|_| "5".to_string())
                .parse()
                .map_err(|e| format!("Invalid DATABASE_MIN_CONNECTIONS: {}", e))?,
        })
    }

    pub async fn connect(&self) -> Result<DatabaseConnection, DbErr> {
        let mut opt = sea_orm::ConnectOptions::new(&self.url);
        opt.max_connections(self.max_connections)
            .min_connections(self.min_connections)
            .sqlx_logging(true);

        Database::connect(opt).await
    }
}
