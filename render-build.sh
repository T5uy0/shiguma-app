#!/usr/bin/env bash
# exit on error
set -o errexit


cat <<EOF > config/database.yml
production:
  adapter: mysql2
  encoding: utf8mb4
  reconnect: false
  database: ${DATABASE_NAME}
  username: ${DATABASE_USER}
  password: ${DATABASE_PASSWORD}
  host: ${DATABASE_HOST}
  port: ${DATABASE_PORT:-22647}
EOF
bundle binstubs bundler --force
bundle install