class CreateClues < ActiveRecord::Migration[7.1]
  def change
    create_table :clues do |t|
      t.string :category
      t.date :air_date
      t.text :question
      t.string :value
      t.string :round
      t.string :show_number

      t.timestamps
    end

    add_index :clues, :category
    add_index :clues, :round
  end
end
