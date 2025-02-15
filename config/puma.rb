# Nombre de workers (processus Puma)
workers Integer(ENV.fetch('WEB_CONCURRENCY', 2))

# Nombre de threads par worker
threads_count = Integer(ENV.fetch('MAX_THREADS', 5))
threads threads_count, threads_count

port  10000

# Écouter sur toutes les interfaces réseau
bind 'tcp://0.0.0.0:' + ENV.fetch('PORT', '10000')

# Définir l’environnement
environment ENV.fetch('RACK_ENV', 'production')

# Preload l’application pour de meilleures performances
preload_app!

environment ENV['RACK_ENV'] || 'development'
bind 'tcp://0.0.0.0'
environment ENV.fetch("RACK_ENV") { "development" }
