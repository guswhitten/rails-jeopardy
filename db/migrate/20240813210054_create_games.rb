class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :player_name
      t.string :bot1_name
      t.string :bot2_name

      t.integer :player_score
      t.integer :bot1_score
      t.integer :bot2_score

      t.string :bot_difficulty
      t.text :categories

      t.timestamps
    end
  end
end
