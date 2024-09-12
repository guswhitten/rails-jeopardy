class ApplicationController < ActionController::Base
  before_action :set_navbar_data

  private

  def set_navbar_data
    @total_clues = Clue.count
    @total_categories = Clue.distinct.pluck(:category).count
  end
end
