#!/usr/bin/env bash
# exit on error
set -o errexit

if [[ -z "$DATABASE_NAME" || -z "$DATABASE_USER" || -z "$DATABASE_PASSWORD" || -z "$DATABASE_HOST" ]]; then
  echo "❌ ERREUR : Une ou plusieurs variables d'environnement ne sont pas définies."
  exit 1
fi

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

echo "🛠️ Génération du fichier config/database.yml..."

echo $DATABASE_USER
echo $DATABASE_PASSWORD
echo $DATABASE_HOST
echo $DATABASE_PORT

bundle install