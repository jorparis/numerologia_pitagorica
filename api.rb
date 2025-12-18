require 'sinatra/base'
require 'json'
require 'rack/cors'

# CORRECCIÓN DE RUTAS: Ahora apuntamos a donde realmente están tus archivos
require_relative 'lib/numerologia_pitagorica/calculator'
require_relative 'lib/numerologia_pitagorica/content'

# CORRECCIÓN DE IDENTIDAD: Definimos la clase que busca tu config.ru
class NumerologiaAPI < Sinatra::Base

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :options]
    end
  end

  # Esto ayuda a Render a encontrar el puerto correcto
  set :bind, '0.0.0.0'
  set :port, ENV['PORT'] || 8080

  post '/api/v1/calculate' do
    content_type :json
    
    begin
      payload = JSON.parse(request.body.read)
      name = payload['name'] || ""
      birthdate = payload['birthDate'] || Time.now.strftime("%Y-%m-%d")

      # Cálculo
      life_path_data = Numerologia::Calculator.calculate_life_path(birthdate)
      expression_data = Numerologia::Calculator.calculate_name(name, :all)
      soul_data = Numerologia::Calculator.calculate_name(name, :vowels)
      personality_data = Numerologia::Calculator.calculate_name(name, :consonants)

      # Respuesta
      response_data = {
        profile: { name: name, birth_date: birthdate },
        chart: {
          life_path: {
            number: life_path_data[:number],
            karma_debt: life_path_data[:karma],
            karma_desc: Numerologia::Content.get_karma(life_path_data[:karma]),
            meta: Numerologia::Content.get_meaning(life_path_data[:number])
          },
          expression: {
            number: expression_data[:number],
            meta: Numerologia::Content.get_meaning(expression_data[:number])
          },
          soul_urge: {
            number: soul_data[:number],
            meta: Numerologia::Content.get_meaning(soul_data[:number])
          },
          personality: {
            number: personality_data[:number],
            meta: Numerologia::Content.get_meaning(personality_data[:number])
          }
        }
      }

      response_data.to_json

    rescue StandardError => e
      status 400
      { error: "Error en el cálculo: #{e.message}" }.to_json
    end
  end

  # Arrancar si se ejecuta directamente
  run! if app_file == $0
end
