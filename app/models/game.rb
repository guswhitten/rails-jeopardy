class Game < ApplicationRecord
  has_many :game_categories
  has_many :clues
end
