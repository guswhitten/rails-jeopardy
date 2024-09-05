class GameDecorator < Draper::Decorator
  delegate_all

  def format_player_score
    object.player_score.negative? ? "-$#{object.player_score.abs}" : "$#{object.player_score}"
  end

  def format_bot_score
    object.bot_score.negative? ? "-$#{object.bot_score.abs}" : "$#{object.bot_score}"
  end
end