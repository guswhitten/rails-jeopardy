class FixBotColumnsOnGames < ActiveRecord::Migration[7.1]
  def change
    rename_column :games, :bot1_name, :bot_name
    rename_column :games, :bot1_score, :bot_score

    remove_column :games, :bot2_name
    remove_column :games, :bot2_score
  end
end
