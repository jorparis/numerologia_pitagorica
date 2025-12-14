require 'sinatra/base'
require 'json'
require 'rack/cors'

# ============================================
# MÓDULO NUMEROLOGÍA (TODO INCLUIDO)
# ============================================
module NumerologiaPitagorica
  
  # Tabla de conversión Pitagórica
  LETRA_A_NUMERO = {
    'A' => 1, 'J' => 1, 'S' => 1,
    'B' => 2, 'K' => 2, 'T' => 2,
    'C' => 3, 'L' => 3, 'U' => 3,
    'D' => 4, 'M' => 4, 'V' => 4,
    'E' => 5, 'N' => 5, 'W' => 5,
    'F' => 6, 'O' => 6, 'X' => 6,
    'G' => 7, 'P' => 7, 'Y' => 7,
    'H' => 8, 'Q' => 8, 'Z' => 8,
    'I' => 9, 'R' => 9,
    'Á' => 1, 'É' => 5, 'Í' => 9, 'Ó' => 6, 'Ú' => 3,
    'Ñ' => 5
  }.freeze
  
  VOCALES = %w[A E I O U Á É Í Ó Ú].freeze
  CONSONANTES = %w[B C D F G H J K L M N Ñ P Q R S T V W X Y Z].freeze
  NUMEROS_MAESTROS = [11, 22, 33].freeze
  
  # Métodos auxiliares
  def self.es_vocal?(letra)
    VOCALES.include?(letra.upcase)
  end
  
  def self.es_consonante?(letra)
    CONSONANTES.include?(letra.upcase)
  end
  
  def self.letra_a_numero(letra)
    LETRA_A_NUMERO[letra.upcase] || 0
  end
  
  def self.es_numero_maestro?(numero)
    NUMEROS_MAESTROS.include?(numero)
  end
  
  def self.reducir_a_un_digito(numero)
    return numero if es_numero_maestro?(numero)
    
    while numero > 9
      numero = numero.to_s.chars.map(&:to_i).sum
      return numero if es_numero_maestro?(numero)
    end
    
    numero
  end
  
  # Número de vida (camino de vida) - desde fecha de nacimiento
  def self.numero_vida(fecha_nacimiento)
    partes = fecha_nacimiento.to_s.gsub('-', '/').split('/')
    
    if partes.length == 3
      if partes[0].length == 4
        dia, mes, anio = partes[2].to_i, partes[1].to_i, partes[0].to_i
      else
        dia, mes, anio = partes[0].to_i, partes[1].to_i, partes[2].to_i
      end
    else
      raise ArgumentError, "Formato de fecha inválido: #{fecha_nacimiento}"
    end
    
    dia_reducido = reducir_a_un_digito(dia)
    mes_reducido = reducir_a_un_digito(mes)
    anio_reducido = reducir_a_un_digito(anio)
    
    total = dia_reducido + mes_reducido + anio_reducido
    reducir_a_un_digito(total)
  end
  
  # Número de expresión (destino) - desde nombre completo
  def self.numero_expresion(nombre_completo)
    suma = sumar_nombre(nombre_completo, :todas)
    reducir_a_un_digito(suma)
  end
  
  # Número del alma (corazón) - solo vocales
  def self.numero_alma(nombre_completo)
    suma = sumar_nombre(nombre_completo, :vocales)
    reducir_a_un_digito(suma)
  end
  
  # Número de personalidad - solo consonantes
  def self.numero_personalidad(nombre_completo)
    suma = sumar_nombre(nombre_completo, :consonantes)
    reducir_a_un_digito(suma)
  end
  
  # Método auxiliar para sumar nombre
  def self.sumar_nombre(nombre, tipo)
    nombre = nombre.to_s.gsub(/[^A-ZÁÉÍÓÚÑa-záéíóúñ]/, '')
    suma = 0
    
    nombre.each_char do |letra|
      case tipo
      when :vocales
        suma += letra_a_numero(letra) if es_vocal?(letra)
      when :consonantes
        suma += letra_a_numero(letra) if es_consonante?(letra)
      when :todas
        suma += letra_a_numero(letra)
      end
    end
    
    suma
  end
  
  # Interpretaciones
  INTERPRETACIONES = {
    1 => {
      titulo: "El Líder",
      descripcion: "Independencia, liderazgo, iniciativa y originalidad.",
      fortalezas: "Pionero, innovador, valiente, determinado",
      desafios: "Evitar el egoísmo, la impaciencia y la dominación"
    },
    2 => {
      titulo: "El Diplomático",
      descripcion: "Cooperación, sensibilidad, equilibrio y armonía.",
      fortalezas: "Pacificador, intuitivo, sensible, cooperativo",
      desafios: "Evitar la timidez, la dependencia y la indecisión"
    },
    3 => {
      titulo: "El Creativo",
      descripcion: "Expresión creativa, comunicación, alegría y optimismo.",
      fortalezas: "Artístico, comunicativo, alegre, social",
      desafios: "Evitar la dispersión, la superficialidad y el exceso"
    },
    4 => {
      titulo: "El Constructor",
      descripcion: "Estabilidad, orden, trabajo duro y practicidad.",
      fortalezas: "Organizado, confiable, trabajador, disciplinado",
      desafios: "Evitar la rigidez, el exceso de trabajo y la terquedad"
    },
    5 => {
      titulo: "El Aventurero",
      descripcion: "Libertad, cambio, versatilidad y experiencia.",
      fortalezas: "Adaptable, curioso, versátil, aventurero",
      desafios: "Evitar la irresponsabilidad, la inquietud y la impulsividad"
    },
    6 => {
      titulo: "El Cuidador",
      descripcion: "Responsabilidad, amor, familia y servicio.",
      fortalezas: "Amoroso, responsable, protector, armonizador",
      desafios: "Evitar la preocupación excesiva, el sacrificio y el control"
    },
    7 => {
      titulo: "El Buscador",
      descripcion: "Espiritualidad, análisis, sabiduría y introspección.",
      fortalezas: "Analítico, espiritual, sabio, introspectivo",
      desafios: "Evitar el aislamiento, el escepticismo y el perfeccionismo"
    },
    8 => {
      titulo: "El Ejecutivo",
      descripcion: "Poder, autoridad, éxito material y ambición.",
      fortalezas: "Ambicioso, eficiente, organizado, poderoso",
      desafios: "Evitar el materialismo, la ambición excesiva y la dominación"
    },
    9 => {
      titulo: "El Humanitario",
      descripcion: "Compasión universal, idealismo, servicio y finalización.",
      fortalezas: "Compasivo, idealista, generoso, sabio",
      desafios: "Evitar el idealismo excesivo, el martirio y la frustración"
    },
    11 => {
      titulo: "El Visionario (Maestro)",
      descripcion: "Iluminación espiritual, intuición elevada, inspiración.",
      fortalezas: "Inspirador, visionario, intuitivo, espiritual",
      desafios: "Evitar la tensión nerviosa, el fanatismo y la impracticidad"
    },
    22 => {
      titulo: "El Constructor Maestro",
      descripcion: "Manifestación de grandes sueños, liderazgo universal.",
      fortalezas: "Visionario práctico, constructor, líder universal",
      desafios: "Evitar la presión extrema, el estrés y las expectativas elevadas"
    },
    33 => {
      titulo: "El Maestro Sanador",
      descripcion: "Amor universal, compasión ilimitada, enseñanza elevada.",
      fortalezas: "Sanador, maestro, compasivo, inspirador universal",
      desafios: "Evitar el sacrificio extremo, el agotamiento emocional"
    }
  }.freeze
  
  def self.interpretar(numero)
    INTERPRETACIONES[numero] || {
      titulo: "Número #{numero}",
      descripcion: "Interpretación no disponible",
      fortalezas: "",
      desafios: ""
    }
  end
  
  # Análisis completo
  def self.analizar_completo(nombre, fecha)
    {
      vida: numero_vida(fecha),
      expresion: numero_expresion(nombre),
      alma: numero_alma(nombre),
      personalidad: numero_personalidad(nombre)
    }
  end
end

# ============================================
# API SINATRA
# ============================================
class NumerologiaAPI < Sinatra::Base
  
  # CORS
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :options]
    end
  end
  
  # Health check
  get '/health' do
    content_type :json
    { status: 'ok', timestamp: Time.now.iso8601 }.to_json
  end
  
  # Análisis completo
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
      
      { numeros: numeros, interpretaciones: interpretaciones }.to_json
      
    rescue JSON::ParserError
      halt 400, { error: 'JSON inválido' }.to_json
    rescue => e
      halt 500, { error: e.message }.to_json
    end
  end
  
  # Número de vida solamente
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
      
      { numero: numero, interpretacion: interpretacion }.to_json
      
    rescue JSON::ParserError
      halt 400, { error: 'JSON inválido' }.to_json
    rescue => e
      halt 500, { error: e.message }.to_json
    end
  end
  
  # Números del nombre
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
      
      { numeros: numeros, interpretaciones: interpretaciones }.to_json
      
    rescue JSON::ParserError
      halt 400, { error: 'JSON inválido' }.to_json
    rescue => e
      halt 500, { error: e.message }.to_json
    end
  end
  
  run! if app_file == $0
end
