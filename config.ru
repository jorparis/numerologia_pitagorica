require './api'

# Ensure proper configuration
set :bind, '0.0.0.0'
set :port, ENV['PORT'] || 3000
set :server, :puma

run Sinatra::Application
