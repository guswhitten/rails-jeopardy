class HomeController < ApplicationController
  def index
    @total_clues = Clue.count
    @categories = Clue.distinct.pluck(:category).count
  end
end