# frozen_string_literal: true

require_relative 'numerologia_pitagorica/mappings'
require_relative 'numerologia_pitagorica/calculator'
require_relative 'numerologia_pitagorica/interpreter'

module NumerologiaPitagorica
  class Error < StandardError; end

  # Calcula todos los números de una persona
  def self.analizar_completo(nombre_completo, fecha_nacimiento)
    {
      vida: numero_vida(fecha_nacimiento),
      expresion: numero_expresion(nombre_completo),
      alma: numero_alma(nombre_completo),
      personalidad: numero_personalidad(nombre_completo)
    }
  end

  # Número de vida (camino de vida)
  def self.numero_vida(fecha_nacimiento)
    Calculator.numero_vida(fecha_nacimiento)
  end

  # Número de expresión (número del destino)
  def self.numero_expresion(nombre_completo)
    Calculator.numero_expresion(nombre_completo)
  end

  # Número del alma (número del corazón)
  def self.numero_alma(nombre_completo)
    Calculator.numero_alma(nombre_completo)
  end

  # Número de personalidad (número exterior)
  def self.numero_personalidad(nombre_completo)
    Calculator.numero_personalidad(nombre_completo)
  end

  # Obtener interpretación de un número
  def self.interpretar(numero)
    Interpreter.interpretar(numero)
  end
end
