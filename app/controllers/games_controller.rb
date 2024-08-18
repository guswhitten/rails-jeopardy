class GamesController < ApplicationController
  QUESTION_TIMER = { 'Hard' => 5, 'Medium' => 6, 'Easy' => 7 }

  def new
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @round_1_data = @game.round_1_data
  end

  def question
    @game = Game.find(params[:id])
    round_1_data = @game.round_1_data.with_indifferent_access
    category = params[:category]
    value = params[:value].to_i
    @clue = round_1_data[category][value]

    respond_to do |format|
      format.js
    end
  end

  def create
    @game = Game.new(game_params)
    generate_game_data

    if @game.save
      redirect_to game_path(@game), notice: 'Game was successfully created.'
    else
      redirect_to root_path, notice: 'Could not create new game'
    end
  end

  def edit
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      # Handle successful update
      respond_to do |format|
        format.js { render js: "alert('Answer submitted successfully!');" }
      end
    else
      # Handle failed update
      respond_to do |format|
        format.js { render js: "alert('Failed to submit answer.');" }
      end
    end
  end

  private

  def generate_game_data
    @game.categories = Clue.where(round: "Jeopardy!")
                           .select(:category)
                           .distinct.order("RANDOM()")
                           .limit(6)
                           .pluck(:category)
    @game.bot1_name = RandomName.generate
    @game.bot2_name = RandomName.generate
    @game.player_score = 0
    @game.bot1_score = 0
    @game.bot2_score = 0
    @timer = QUESTION_TIMER[@game.bot_difficulty]
  end
  def game_params
    params.permit(:player_name, :bot_difficulty)
  end
end