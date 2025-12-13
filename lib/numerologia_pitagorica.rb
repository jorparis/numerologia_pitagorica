require_relative "numerologia_pitagorica/mappings"
require_relative "numerologia_pitagorica/calculator"
require_relative "numerologia_pitagorica/interpreter"

module NumerologiaPitagorica
  class << self
    def calculate_life_path_number(day, month, year)
        Calculator.calculate_life_path_number(day, month, year)
    end

    def calculate_expression_number(full_name)
        Calculator.calculate_expression_number(full_name)
    end

    def calculate_soul_urge_number(name)
        Calculator.calculate_soul_urge_number(name)
    end

    def calculate_personality_number(name)
        Calculator.calculate_personality_number(name)
    end

    def get_meaning(number)
      Interpreter.get_meaning(number)
    end
  end
end
```

4. Click **"Commit changes"**

---

## ✅ ESTRUCTURA FINAL

Después de esto, tu repo debe verse así:
```
numerologia_pitagorica/
├── api.rb
├── Gemfile
├── config.ru
└── lib/
    ├── numerologia_pitagorica.rb
    └── numerologia_pitagorica/
        ├── mappings.rb
        ├── calculator.rb
        └── interpreter.rb
