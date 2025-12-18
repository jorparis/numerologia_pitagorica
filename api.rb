require 'sinatra'
require 'json'
require 'rack/cors'
require_relative 'lib/calculator'
require_relative 'lib/content'

# Configuración de Seguridad
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :options]
  end
end

# Endpoint Principal
post '/api/v1/calculate' do
  content_type :json
  
  begin
    payload = JSON.parse(request.body.read)
    name = payload['name'] || ""
    birthdate = payload['birthDate'] || Time.now.strftime("%Y-%m-%d")

    life_path_data = Numerologia::Calculator.calculate_life_path(birthdate)
    expression_data = Numerologia::Calculator.calculate_name(name, :all)
    soul_data = Numerologia::Calculator.calculate_name(name, :vowels)
    personality_data = Numerologia::Calculator.calculate_name(name, :consonants)

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
