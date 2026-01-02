use std::env;

#[derive(Debug, Clone)]
pub struct AppConfig {
    pub app_name: String,
    pub app_env: String,
    pub host: String,
    pub port: u16,
    pub log_level: String,
    pub jwt_secret: String,
    pub jwt_access_expiry: i64,
    pub jwt_refresh_expiry: i64,
    pub bcrypt_cost: u32,
    pub otp_expiry_minutes: i64,
    pub otp_max_attempts: u32,
    pub cors_origins: Vec<String>,
    pub encryption_key: String,
}

impl AppConfig {
    pub fn from_env() -> Result<Self, String> {
        dotenv::dotenv().ok();

        Ok(Self {
            app_name: env::var("APP_NAME").unwrap_or_else(|_| "Adjo".to_string()),
            app_env: env::var("APP_ENV").unwrap_or_else(|_| "development".to_string()),
            host: env::var("APP_HOST").unwrap_or_else(|_| "0.0.0.0".to_string()),
            port: env::var("APP_PORT")
                .unwrap_or_else(|_| "8000".to_string())
                .parse()
                .map_err(|e| format!("Invalid APP_PORT: {}", e))?,
            log_level: env::var("LOG_LEVEL").unwrap_or_else(|_| "debug".to_string()),
            jwt_secret: env::var("JWT_SECRET")
                .map_err(|_| "JWT_SECRET must be set".to_string())?,
            jwt_access_expiry: env::var("JWT_ACCESS_TOKEN_EXPIRY")
                .unwrap_or_else(|_| "3600".to_string())
                .parse()
                .map_err(|e| format!("Invalid JWT_ACCESS_TOKEN_EXPIRY: {}", e))?,
            jwt_refresh_expiry: env::var("JWT_REFRESH_TOKEN_EXPIRY")
                .unwrap_or_else(|_| "2592000".to_string())
                .parse()
                .map_err(|e| format!("Invalid JWT_REFRESH_TOKEN_EXPIRY: {}", e))?,
            bcrypt_cost: env::var("BCRYPT_COST")
                .unwrap_or_else(|_| "10".to_string())
                .parse()
                .map_err(|e| format!("Invalid BCRYPT_COST: {}", e))?,
            otp_expiry_minutes: env::var("OTP_EXPIRY_MINUTES")
                .unwrap_or_else(|_| "5".to_string())
                .parse()
                .map_err(|e| format!("Invalid OTP_EXPIRY_MINUTES: {}", e))?,
            otp_max_attempts: env::var("OTP_MAX_ATTEMPTS")
                .unwrap_or_else(|_| "5".to_string())
                .parse()
                .map_err(|e| format!("Invalid OTP_MAX_ATTEMPTS: {}", e))?,
            cors_origins: env::var("CORS_ALLOWED_ORIGINS")
                .unwrap_or_else(|_| "http://localhost:3000".to_string())
                .split(',')
                .map(|s| s.trim().to_string())
                .collect(),
            encryption_key: env::var("ENCRYPTION_KEY")
                .map_err(|_| "ENCRYPTION_KEY must be set".to_string())?,
        })
    }

    pub fn is_production(&self) -> bool {
        self.app_env == "production"
    }

    pub fn is_development(&self) -> bool {
        self.app_env == "development"
    }
}
