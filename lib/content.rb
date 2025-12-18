module Numerologia
  class Content
    DEFINITIONS = {
      1 => { title: "El Pionero", keywords: "Liderazgo, Inicio", description: "Vienes a abrir caminos. Tu fuerza es la iniciativa." },
      2 => { title: "El Mediador", keywords: "Diplomacia, Unión", description: "Ves las dos caras de la moneda y traes armonía." },
      3 => { title: "El Creador", keywords: "Expresión, Arte", description: "Tu voz es tu herramienta para inspirar." },
      4 => { title: "El Constructor", keywords: "Orden, Raíces", description: "Pones los cimientos sobre los que otros construyen." },
      5 => { title: "El Aventurero", keywords: "Libertad, Cambio", description: "El cambio es tu combustible. Enseñas a fluir." },
      6 => { title: "El Cuidador", keywords: "Amor, Familia", description: "El pegamento que mantiene unidos a los grupos." },
      7 => { title: "El Místico", keywords: "Sabiduría, Verdad", description: "Buscas respuestas profundas entre lo terrenal y divino." },
      8 => { title: "El Soberano", keywords: "Poder, Abundancia", description: "Vienes a dominar el mundo material con ética." },
      9 => { title: "El Humanitario", keywords: "Compasión, Cierre", description: "Tu alma vieja viene a dar amor incondicional." },
      11 => { title: "El Iluminador", keywords: "Intuición, Luz", description: "Tu intuición guía a otros en la oscuridad." },
      22 => { title: "El Arquitecto", keywords: "Manifestación", description: "Tienes la visión del 11 y la acción del 4." },
      33 => { title: "El Sanador", keywords: "Amor Crístico", description: "Elevas la frecuencia del planeta con tu servicio." }
    }
    KARMIC_DEFINITIONS = {
      13 => "Deuda de Trabajo: Necesidad de disciplina.",
      14 => "Deuda de Libertad: Necesidad de moderación.",
      16 => "Deuda de Amor: Destruir el ego para amar de verdad.",
      19 => "Deuda de Poder: Aprender a pedir ayuda."
    }

    def self.get_meaning(number)
      DEFINITIONS[number] || { title: "Energía", keywords: "Vibración", description: "Energía en movimiento." }
    end

    def self.get_karma(number)
      KARMIC_DEFINITIONS[number]
    end
  end
end
