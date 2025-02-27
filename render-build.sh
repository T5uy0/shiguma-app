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

1=$(yq '.production.database' config/database.yml)
2=$(yq '.production.username' config/database.yml)
3=$(yq '.production.password' config/database.yml)
4=$(yq '.production.host' config/database.yml)
DATABASE_PORT=$(yq '.production.port' config/database.yml)

echo "📡 Connexion à $1@$2:$3 avec $4"



bundle install