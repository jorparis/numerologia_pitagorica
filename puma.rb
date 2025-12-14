# Puma configuration for Railway

# Get port from environment
port ENV.fetch("PORT") { 3000 }

# Bind to all network interfaces
bind "tcp://0.0.0.0:#{ENV.fetch('PORT') { 3000 }}"

# Set environment
environment ENV.fetch("RACK_ENV") { "production" }

# Number of worker processes
workers ENV.fetch("WEB_CONCURRENCY") { 1 }

# Number of threads per worker
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Preload the app for better performance
preload_app!
