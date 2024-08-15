class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :player_1_score
      t.integer :player_2_score
      t.integer :player_3_score
      t.text :categories

      t.timestamps
    end
  end
end
