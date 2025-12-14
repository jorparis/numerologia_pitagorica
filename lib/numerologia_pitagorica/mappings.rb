# frozen_string_literal: true

module NumerologiaPitagorica
  module Mappings
    # Tabla de conversión letras a números (Pitagórica)
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
      # Letras con acentos
      'Á' => 1, 'É' => 5, 'Í' => 9, 'Ó' => 6, 'Ú' => 3,
      'Ñ' => 5
    }.freeze

    # Vocales (para número del alma)
    VOCALES = %w[A E I O U Á É Í Ó Ú].freeze

    # Consonantes (para número de personalidad)
    CONSONANTES = %w[
      B C D F G H J K L M N Ñ P Q R S T V W X Y Z
    ].freeze

    # Números maestros (no se reducen)
    NUMEROS_MAESTROS = [11, 22, 33].freeze

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
  end
end
