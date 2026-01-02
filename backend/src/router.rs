use axum::{routing::get, Router};
use tower_http::trace::TraceLayer;

use crate::handlers;
use crate::AppState;

pub fn create_router(state: AppState) -> Router {
    Router::new()
        // Health check
        .route("/health", get(handlers::health::health_check))

        // API routes will be added here
        // Auth routes
        // .route("/api/auth/register", post(handlers::auth::register))
        // .route("/api/auth/login", post(handlers::auth::login))
        // etc.

        .with_state(state)
        .layer(TraceLayer::new_for_http())
}
