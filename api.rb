require 'sinatra'
require 'json'
require_relative 'lib/numerologia_pitagorica'

# Configuración CORS para que FlutterFlow pueda conectarse
before do
  headers['Access-Control-Allow-Origin'] = '*'
  headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
  headers['Access-Control-Allow-Headers'] = 'Content-Type'
end

options '*' do
  200
end

# Endpoint de salud (verificar que la API está viva)
get '/health' do
  content_type :json
  { status: 'ok', message: 'Numerología API Running' }.to_json
end

# Endpoint principal: Cálculo completo de numerología
post '/calculate' do
  content_type :json
  
  begin
    # Parsear datos del request
    data = JSON.parse(request.body.read)
    
    nombre = data['nombre']
    dia = data['dia']
    mes = data['mes']
    anio = data['anio']
    
    # Validaciones
    return { error: 'Nombre requerido' }.to_json, 400 if nombre.nil? || nombre.empty?
    return { error: 'Fecha completa requerida' }.to_json, 400 if dia.nil? || mes.nil? || anio.nil?
    
    # Cálculos usando tu gema
    numero_vida = NumerologiaPitagorica.calculate_life_path_number(dia, mes, anio)
    numero_expresion = NumerologiaPitagorica.calculate_expression_number(nombre)
    numero_alma = NumerologiaPitagorica.calculate_soul_urge_number(nombre)
    numero_personalidad = NumerologiaPitagorica.calculate_personality_number(nombre)
    
    # Interpretaciones
    interpretacion_vida = NumerologiaPitagorica.get_meaning(numero_vida)
    interpretacion_expresion = NumerologiaPitagorica.get_meaning(numero_expresion)
    interpretacion_alma = NumerologiaPitagorica.get_meaning(numero_alma)
    interpretacion_personalidad = NumerologiaPitagorica.get_meaning(numero_personalidad)
    
    # Respuesta JSON completa
    {
      success: true,
      datos_entrada: {
        nombre: nombre,
        fecha_nacimiento: "#{dia}/#{mes}/#{anio}"
      },
      numeros: {
        vida: numero_vida,
        expresion: numero_expresion,
        alma: numero_alma,
        personalidad: numero_personalidad
      },
      interpretaciones: {
        vida: interpretacion_vida,
        expresion: interpretacion_expresion,
        alma: interpretacion_alma,
        personalidad: interpretacion_personalidad
      },
      es_maestro: [11, 22, 33].any? { |n| [numero_vida, numero_expresion, numero_alma, numero_personalidad].include?(n) }
    }.to_json
    
  rescue JSON::ParserError
    status 400
    { error: 'JSON inválido' }.to_json
  rescue => e
    status 500
    { error: 'Error interno', detalles: e.message }.to_json
  end
end

# Endpoint adicional: Solo calcular número de vida
post '/life-path' do
  content_type :json
  
  begin
    data = JSON.parse(request.body.read)
    numero = NumerologiaPitagorica.calculate_life_path_number(data['dia'], data['mes'], data['anio'])
    
    {
      numero: numero,
      interpretacion: NumerologiaPitagorica.get_meaning(numero)
    }.to_json
  rescue => e
    status 400
    { error: e.message }.to_json
  end
end

# Endpoint adicional: Solo calcular por nombre
post '/name-numbers' do
  content_type :json
  
  begin
    data = JSON.parse(request.body.read)
    nombre = data['nombre']
    
    {
      expresion: NumerologiaPitagorica.calculate_expression_number(nombre),
      alma: NumerologiaPitagorica.calculate_soul_urge_number(nombre),
      personalidad: NumerologiaPitagorica.calculate_personality_number(nombre)
    }.to_json
  rescue => e
    status 400
    { error: e.message }.to_json
  end
end
