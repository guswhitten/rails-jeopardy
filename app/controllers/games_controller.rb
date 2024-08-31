class GamesController < ApplicationController
  QUESTION_TIMER = { 'Hard' => 5, 'Medium' => 6, 'Easy' => 7 }

  def new
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
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
    correct_answer = Answer.find(params[:clue_id])&.answer
    user_answer = params[:answer].presence
    value = params[:clue_value]&.sub('$', '')
    category_data = @game["category_#{params[:cat_num]}"]

    unless params[:time_out].present?
      is_correct = user_answer.present? && AnswerMatcher.match?(user_answer, correct_answer)
      is_correct ? @game.player_score += value&.to_i : @game.player_score -= value&.to_i
    end

    # mark question as answered for this game
    category_data[value]['answered'] = true
    @game.save

    render json: {
      correct: is_correct,
      correct_answer: correct_answer,
      new_score: @game.player_score
    }
  end

  private

  def generate_game_data
    categories = Clue.where(round: "Jeopardy!")
                     .select('DISTINCT category')
                     .order('RANDOM()')
                     .limit(6)
                     .pluck(:category)

    categories.each_with_index do |category, index|
      category_data = {}
      category_data[:name] = category

      clues = Clue.where(category: category, round: "Jeopardy!").order(:value)

      [200, 400, 600, 800, 1000].each_with_index do |value, i|
        clue = clues[i]
        clue.value = "$#{value}"
        category_data[value] = clue
      end

      @game["category_#{index + 1}"] = category_data
    end

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