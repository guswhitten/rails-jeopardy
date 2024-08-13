class GamesController < ApplicationController
  def new
    # six unique categories
    categories = Clue.select(:category).distinct.order("RANDOM()").limit(6).pluck(:category)
    @game = Game.create(player_1_score: 0, player_2_score: 0, player_3_score: 0, game_categories: categories)

    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @categories = @game.categories
    @clues = Clue.where(category: @categories)
                 .group_by(&:category)
                 .transform_values { |clues| clues.index_by(&:value) }
  end

  def answer
    @game = Game.find(params[:id])
    @clue = Clue.find(params[:clue_id])
    if params[:answer].downcase.strip == @clue.answer.downcase.strip
      @game.update(score: @game.score + @clue.value.to_i)
      flash[:notice] = "Correct! You earned $#{@clue.value}."
    else
      flash[:alert] = "Sorry, the correct answer was: #{@clue.answer}"
    end
    redirect_to game_path(@game)
  end
end