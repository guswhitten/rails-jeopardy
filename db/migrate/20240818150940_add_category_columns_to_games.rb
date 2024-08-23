class AddCategoryColumnsToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :category_1, :json
    add_column :games, :category_2, :json
    add_column :games, :category_3, :json
    add_column :games, :category_4, :json
    add_column :games, :category_5, :json
    add_column :games, :category_6, :json
    remove_column :games, :categories, :json
  end
end
