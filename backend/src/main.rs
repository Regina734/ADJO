mod config;
mod errors;
mod handlers;
mod middleware;
mod models;
mod router;
mod services;
mod utils;

use config::{AppConfig, DatabaseConfig};
use sea_orm::DatabaseConnection;
use std::sync::Arc;
use tower_http::cors::{Any, CorsLayer};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[derive(Clone)]
pub struct AppState {
    pub db: DatabaseConnection,
    pub config: Arc<AppConfig>,
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Load configuration
    let app_config = AppConfig::from_env()?;
    let db_config = DatabaseConfig::from_env()?;

    // Initialize tracing
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| format!("{}={}", env!("CARGO_PKG_NAME"), app_config.log_level).into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();

    tracing::info!("Starting {} v{}", app_config.app_name, env!("CARGO_PKG_VERSION"));
    tracing::info!("Environment: {}", app_config.app_env);

    // Connect to database
    tracing::info!("Connecting to database...");
    let db = db_config.connect().await?;
    tracing::info!("Database connected successfully");

    // Create application state
    let state = AppState {
        db,
        config: Arc::new(app_config.clone()),
    };

    // Configure CORS
    let cors = CorsLayer::new()
        .allow_origin(
            app_config
                .cors_origins
                .iter()
                .map(|origin| origin.parse().unwrap())
                .collect::<Vec<_>>(),
        )
        .allow_methods(Any)
        .allow_headers(Any);

    // Build router
    let app = router::create_router(state).layer(cors);

    // Start server
    let addr = format!("{}:{}", app_config.host, app_config.port);
    tracing::info!("Server listening on {}", addr);

    let listener = tokio::net::TcpListener::bind(&addr).await?;
    axum::serve(listener, app).await?;

    Ok(())
}
