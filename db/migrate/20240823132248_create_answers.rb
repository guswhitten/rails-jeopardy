class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :clue, null: false, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
