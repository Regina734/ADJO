#!/bin/bash

# Script to run database migrations

set -e

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

echo "Running database migrations..."

# Run each migration file in order
for migration in migrations/*.sql; do
    echo "Applying migration: $migration"
    psql "$DATABASE_URL" -f "$migration"
done

echo "All migrations completed successfully!"
