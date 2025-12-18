require 'date'

module Numerologia
  class Calculator
    LETTER_VALUES = {
      'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6, 'G' => 7, 'H' => 8, 'I' => 9,
      'J' => 1, 'K' => 2, 'L' => 3, 'M' => 4, 'N' => 5, 'O' => 6, 'P' => 7, 'Q' => 8, 'R' => 9,
      'S' => 1, 'T' => 2, 'U' => 3, 'V' => 4, 'W' => 5, 'X' => 6, 'Y' => 7, 'Z' => 8
    }
    VOWELS = %w[A E I O U Y]

    def self.reduce_with_karma(number)
      return { number: number, karma: nil } if [11, 22, 33].include?(number)
      return { number: number, karma: nil } if number < 10

      karmic_debt = nil
      if [13, 14, 16, 19].include?(number)
        karmic_debt = number
      end

      sum = number.to_s.chars.map(&:to_i).sum
      result = reduce_with_karma(sum)
      result[:karma] = karmic_debt if karmic_debt
      result
    end

    def self.calculate_name(name, filter = :all)
      clean_name = name.upcase.gsub(/[^A-Z]/, '')
      total = 0
      
      clean_name.each_char do |char|
        value = LETTER_VALUES[char] || 0
        is_vowel = VOWELS.include?(char)
        
        if filter == :vowels && is_vowel
          total += value
        elsif filter == :consonants && !is_vowel
          total += value
        elsif filter == :all
          total += value
        end
      end
      reduce_with_karma(total)
    end

    def self.calculate_life_path(birthdate_str)
      date = Date.parse(birthdate_str)
      reduced_year = reduce_simple(date.year)
      reduced_month = reduce_simple(date.month)
      reduced_day = reduce_simple(date.day)
      
      total = reduced_year + reduced_month + reduced_day
      reduce_with_karma(total)
    rescue
      { number: 0, karma: nil }
    end

    def self.reduce_simple(n)
      return n if [11, 22, 33].include?(n)
      return n if n < 10
      reduce_simple(n.to_s.chars.map(&:to_i).sum)
    end
  end
end
