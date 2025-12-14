# frozen_string_literal: true

module NumerologiaPitagorica
  module Calculator
    extend self

    # Número de vida (camino de vida) - desde fecha de nacimiento
    def numero_vida(fecha_nacimiento)
      # Formato esperado: "DD/MM/YYYY" o "YYYY-MM-DD"
      partes = fecha_nacimiento.to_s.gsub('-', '/').split('/')
      
      if partes.length == 3
        if partes[0].length == 4 # YYYY-MM-DD
          dia, mes, anio = partes[2].to_i, partes[1].to_i, partes[0].to_i
        else # DD/MM/YYYY
          dia, mes, anio = partes[0].to_i, partes[1].to_i, partes[2].to_i
        end
      else
        raise ArgumentError, "Formato de fecha inválido: #{fecha_nacimiento}"
      end

      # Reducir cada componente
      dia_reducido = reducir_a_un_digito(dia)
      mes_reducido = reducir_a_un_digito(mes)
      anio_reducido = reducir_a_un_digito(anio)

      # Sumar y reducir
      total = dia_reducido + mes_reducido + anio_reducido
      reducir_a_un_digito(total)
    end

    # Número de expresión (destino) - desde nombre completo
    def numero_expresion(nombre_completo)
      suma = sumar_nombre(nombre_completo, :todas)
      reducir_a_un_digito(suma)
    end

    # Número del alma (corazón) - solo vocales
    def numero_alma(nombre_completo)
      suma = sumar_nombre(nombre_completo, :vocales)
      reducir_a_un_digito(suma)
    end

    # Número de personalidad - solo consonantes
    def numero_personalidad(nombre_completo)
      suma = sumar_nombre(nombre_completo, :consonantes)
      reducir_a_un_digito(suma)
    end

    private

    def sumar_nombre(nombre, tipo)
      nombre = nombre.to_s.upcase.gsub(/[^A-ZÁÉÍÓÚÑ]/, '')
      suma = 0

      nombre.each_char do |letra|
        case tipo
        when :vocales
          suma += Mappings.letra_a_numero(letra) if Mappings.es_vocal?(letra)
        when :consonantes
          suma += Mappings.letra_a_numero(letra) if Mappings.es_consonante?(letra)
        when :todas
          suma += Mappings.letra_a_numero(letra)
        end
      end

      suma
    end

    def reducir_a_un_digito(numero)
      # Mantener números maestros
      return numero if Mappings.es_numero_maestro?(numero)

      while numero > 9
        numero = numero.to_s.chars.map(&:to_i).sum
        # Verificar números maestros en cada iteración
        return numero if Mappings.es_numero_maestro?(numero)
      end

      numero
    end
  end
end
