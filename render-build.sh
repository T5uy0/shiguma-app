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

1=$(grep -E '^  database:' config/database.yml | awk '{print $2}')
2=$(grep -E '^  username:' config/database.yml | awk '{print $2}')
3=$(grep -E '^  password:' config/database.yml | awk '{print $2}')
4=$(grep -E '^  host:' config/database.yml | awk '{print $2}')
DATABASE_PORT=$(grep -E '^  port:' config/database.yml | awk '{print $2}')

echo "📡 Connexion à $1@$2:$3 avec $4"



bundle install