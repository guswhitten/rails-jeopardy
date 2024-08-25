class GameDecorator < Draper::Decorator
  delegate_all

  def format_player_score
    object.player_score.negative? ? "-$#{object.player_score.abs}" : "$#{object.player_score}"
  end
end