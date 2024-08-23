class Answer < ApplicationRecord
  belongs_to :clue
  validates :answer, presence: true
end
