module NumerologiaPitagorica
  module Interpreter
    NUMBER_MEANINGS = {
      1 => "Liderazgo, independencia, iniciativa, originalidad. El pionero.",
      2 => "Cooperación, equilibrio, diplomacia, dualidad. El pacificador.",
      3 => "Creatividad, expresión, comunicación, optimismo. El artista.",
      4 => "Estabilidad, trabajo duro, disciplina, orden. El constructor.",
      5 => "Libertad, aventura, cambio, versatilidad. El buscador.",
      6 => "Responsabilidad, servicio, armonía, familia. El cuidador.",
      7 => "Introspección, análisis, espiritualidad, sabiduría. El sabio.",
      8 => "Poder, ambición, éxito material, autoridad. El ejecutivo.",
      9 => "Humanitarismo, compasión, finalización, servicio. El humanitario.",
      11 => "Intuición, inspiración, iluminación. El visionario (Maestro).",
      22 => "Maestría, construcción a gran escala, manifestación. El constructor maestro.",
      33 => "Compasión universal, sanación, guía espiritual. El maestro sanador."
    }.freeze

    def self.get_meaning(number)
      NUMBER_MEANINGS[number] || "Significado no definido para el número #{number}."
    end
  end
end
