# Puma configuration for Railway deployment

# Bind to all interfaces (0.0.0.0) not just localhost
port ENV.fetch("PORT") { 3000 }
bind "tcp://0.0.0.0:#{ENV.fetch('PORT') { 3000 }}"

# Environment
environment ENV.fetch("RACK_ENV") { "production" }

# Workers
workers ENV.fetch("WEB_CONCURRENCY") { 1 }

# Threads
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Preload app for better performance
preload_app!
