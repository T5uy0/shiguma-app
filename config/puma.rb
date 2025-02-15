workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup DefaultRackup
port  10000
environment ENV['RACK_ENV'] || 'development'
bind 'tcp://0.0.0.0'
environment ENV.fetch("RACK_ENV") { "development" }
