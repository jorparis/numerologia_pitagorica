module NumerologiaPitagorica
  module Calculator
    # Método recursivo para reducir números (Reducción Teosófica)
    # Respeta los Números Maestros 11, 22 y 33
    def self.reduce_number(number)
      return number if [11, 22, 33].include?(number)
      sum = number.to_s.chars.map(&:to_i).sum
      return sum if sum < 10
      reduce_number(sum)
    end

    def self.calculate_name_value(name)
      processed_name = name.to_s.upcase.gsub(/[^A-Z]/, '')
      
      total_value = processed_name.chars.sum do |char|
        Mappings::LETTER_VALUES[char] || 0
      end
      
      reduce_number(total_value)
    end

    def self.calculate_life_path_number(day, month, year)
       reduced_day = reduce_number(day.to_i)
       reduced_month = reduce_number(month.to_i)
       reduced_year = reduce_number(year.to_i) 
       
       total = reduced_day + reduced_month + reduced_year
       reduce_number(total)
    end

    def self.calculate_expression_number(full_name)
      calculate_name_value(full_name)
    end

    def self.calculate_soul_urge_number(name)
       vowels_only = name.to_s.upcase.chars.select { |char| Mappings::VOWELS.include?(char) }.join
       
       total_value = vowels_only.chars.sum do |char|
           Mappings::LETTER_VALUES[char] || 0
       end
       reduce_number(total_value)
    end

    def self.calculate_personality_number(name)
       consonants_only = name.to_s.upcase.chars.select { |char| Mappings::CONSONANTS.include?(char) }.join
       
       total_value = consonants_only.chars.sum do |char|
           Mappings::LETTER_VALUES[char] || 0
       end
       reduce_number(total_value)
    end
  end
end
