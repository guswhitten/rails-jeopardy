class AddAnsweredCountToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :answered_count, :integer, default: 0
  end
end
