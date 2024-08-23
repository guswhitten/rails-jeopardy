class Game < ApplicationRecord
  validates :player_name, presence: true
  validates :bot_difficulty, presence: true

  def categories
    [
      self[:category_1],
      self[:category_2],
      self[:category_3],
      self[:category_4],
      self[:category_5],
      self[:category_6],
    ]
  end
end
