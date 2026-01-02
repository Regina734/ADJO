use axum::{extract::State, Json};
use serde_json::{json, Value};

use crate::AppState;

pub async fn health_check(State(state): State<AppState>) -> Json<Value> {
    // Try to ping database
    let db_status = match state.db.ping().await {
        Ok(_) => "healthy",
        Err(_) => "unhealthy",
    };

    Json(json!({
        "status": "ok",
        "app": state.config.app_name,
        "version": env!("CARGO_PKG_VERSION"),
        "environment": state.config.app_env,
        "database": db_status,
    }))
}
