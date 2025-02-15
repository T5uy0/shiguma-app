# Définition des workers (nombre de processus Puma)
workers ENV.fetch('WEB_CONCURRENCY', 2).to_i

# Définition des threads par worker
threads_count = ENV.fetch('MAX_THREADS', 5).to_i
threads threads_count, threads_count

# Définition du port (Render assigne un port dynamique)
port 10000

# Lier le serveur à toutes les interfaces réseau
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 10000)}"

# Définition de l'environnement
environment ENV.fetch('RACK_ENV', 'production')

# Préchargement de l'application avant le fork (améliore les performances)
preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Activer la journalisation si nécessaire
stdout_redirect 'log/puma.stdout.log', 'log/puma.stderr.log', true if ENV['RACK_ENV'] == 'production'
