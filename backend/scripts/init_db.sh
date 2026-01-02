#!/bin/bash

# Script to initialize database

set -e

echo "Starting PostgreSQL with Docker Compose..."
docker-compose up -d postgres

echo "Waiting for PostgreSQL to be ready..."
sleep 5

echo "Database initialized successfully!"
echo "You can now run: ./scripts/run_migrations.sh"
