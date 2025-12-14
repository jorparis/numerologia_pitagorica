# Puma configuration for Railway
port ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RACK_ENV") { "development" }

# Bind to all interfaces (not just localhost)
bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { 3000 }}"

# Specifies the number of `workers` to boot in clustered mode.
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

on_worker_boot do
  # Worker specific setup for Rails 4.1+
end
