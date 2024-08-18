class Game < ApplicationRecord
  validates :player_name, presence: true
  validates :bot_difficulty, presence: true

  def categories
    JSON.parse(self[:categories])
  end

  def round_1_data
    categories_array = JSON.parse(self[:categories])
    clue_values = [200, 400, 600, 800, 1000]

    categories_array.each_with_object({}) do |category, category_hash|
      category_hash[category] = clue_values.each_with_object({}) do |value, value_hash|
        clue = Clue.where(category: category, value: "$#{value}", round: "Jeopardy!")&.first

        if clue
          value_hash[value] = {
            id: clue.id,
            question: clue.question,
            answer: clue.answer,
            air_date: clue.air_date,
            show_number: clue.show_number
          }
        else
          value_hash[value] = nil
        end
      end
    end
  end
end
