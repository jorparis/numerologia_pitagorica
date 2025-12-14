puts "=== STARTING API.RB LOAD ==="

begin
  puts "Loading sinatra/base..."
  require 'sinatra/base'
  puts "✓ sinatra/base loaded"
  
  puts "Loading json..."
  require 'json'
  puts "✓ json loaded"
  
  puts "Loading rack/cors..."
  require 'rack/cors'
  puts "✓ rack/cors loaded"
  
  puts "Loading lib/numerologia_pitagorica..."
  require_relative 'lib/numerologia_pitagorica'
  puts "✓ lib/numerologia_pitagorica loaded"
  
rescue LoadError => e
  puts "!!! LOAD ERROR: #{e.message}"
  puts "!!! BACKTRACE:"
  puts e.backtrace.join("\n")
  raise
rescue => e
  puts "!!! ERROR: #{e.class} - #{e.message}"
  puts "!!! BACKTRACE:"
  puts e.backtrace.join("\n")
  raise
end

puts "Defining NumerologiaAPI class..."

class NumerologiaAPI < Sinatra::Base
  
  puts "Setting up CORS..."
  
  # CORS configuration
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', 
        headers: :any, 
        methods: [:get, :post, :options]
    end
  end
  
  puts "Defining routes..."
  
  # Health check endpoint
  get '/health' do
    content_type :json
    { status: 'ok', timestamp: Time.now.iso8601 }.to_json
  end
  
  # Complete numerology analysis
  post '/calculate' do
    content_type :json
    
    begin
      data = JSON.parse(request.body.read)
      
      nombre = data['nombre']
      fecha = data['fecha_nacimiento']
      
      unless nombre && fecha
        halt 400, { error: 'Se requieren nombre y fecha_nacimiento' }.to_json
      end
      
      numeros = NumerologiaPitagorica.analizar_completo(nombre, fecha)
      
      interpretaciones = {
        vida: NumerologiaPitagorica.interpretar(numeros[:vida]),
        expresion: NumerologiaPitagorica.interpretar(numeros[:expresion]),
        alma: NumerologiaPitagorica.interpretar(numeros[:alma]),
        personalidad: NumerologiaPitagorica.interpretar(numeros[:personalidad])
      }
      
      {
        numeros: numeros,
        interpretaciones: interpretaciones
      }.to_json
      
    rescue JSON::ParserError
      halt 400, { error: 'JSON inválido' }.to_json
    rescue => e
      halt 500, { error: e.message }.to_json
    end
  end
  
  # Life path number only
  post '/life-path' do
    content_type :json
    
    begin
      data = JSON.parse(request.body.read)
      fecha = data['fecha_nacimiento']
      
      unless fecha
        halt 400, { error: 'Se requiere fecha_nacimiento' }.to_json
      end
      
      numero = NumerologiaPitagorica.numero_vida(fecha)
      interpretacion = NumerologiaPitagorica.interpretar(numero)
      
      {
        numero: numero,
        interpretacion: interpretacion
      }.to_json
      
    rescue JSON::ParserError
      halt 400, { error: 'JSON inválido' }.to_json
    rescue => e
      halt 500, { error: e.message }.to_json
    end
  end
  
  # Name numbers (expression, soul, personality)
  post '/name-numbers' do
    content_type :json
    
    begin
      data = JSON.parse(request.body.read)
      nombre = data['nombre']
      
      unless nombre
        halt 400, { error: 'Se requiere nombre' }.to_json
      end
      
      numeros = {
        expresion: NumerologiaPitagorica.numero_expresion(nombre),
        alma: NumerologiaPitagorica.numero_alma(nombre),
        personalidad: NumerologiaPitagorica.numero_personalidad(nombre)
      }
      
      interpretaciones = {
        expresion: NumerologiaPitagorica.interpretar(numeros[:expresion]),
        alma: NumerologiaPitagorica.interpretar(numeros[:alma]),
        personalidad: NumerologiaPitagorica.interpretar(numeros[:personalidad])
      }
      
      {
        numeros: numeros,
        interpretaciones: interpretaciones
      }.to_json
      
    rescue JSON::ParserError
      halt 400, { error: 'JSON inválido' }.to_json
    rescue => e
      halt 500, { error: e.message }.to_json
    end
  end
  
  puts "✓ Routes defined"
  
  # Start the server if this file is executed directly
  run! if app_file == $0
end

puts "=== API.RB LOADED SUCCESSFULLY ==="
