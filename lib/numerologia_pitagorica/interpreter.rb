# frozen_string_literal: true

module NumerologiaPitagorica
  module Interpreter
    extend self

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
        desafios: "Evitar la irresponsabilidad, la impulsividad y la inquietud"
      },
      6 => {
        titulo: "El Cuidador",
        descripcion: "Responsabilidad, amor, familia y servicio.",
        fortalezas: "Compasivo, responsable, protector, armonizador",
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

    def interpretar(numero)
      INTERPRETACIONES[numero] || {
        titulo: "Número #{numero}",
        descripcion: "Interpretación no disponible",
        fortalezas: "",
        desafios: ""
      }
    end
  end
end
