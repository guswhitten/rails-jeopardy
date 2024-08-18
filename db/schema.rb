# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_13_210054) do
  create_table "clues", force: :cascade do |t|
    t.string "category"
    t.date "air_date"
    t.text "question"
    t.string "value"
    t.string "answer"
    t.string "round"
    t.string "show_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["air_date"], name: "index_clues_on_air_date"
    t.index ["category"], name: "index_clues_on_category"
    t.index ["round"], name: "index_clues_on_round"
    t.index ["show_number"], name: "index_clues_on_show_number"
  end

  create_table "games", force: :cascade do |t|
    t.string "player_name"
    t.string "bot1_name"
    t.string "bot2_name"
    t.integer "player_score"
    t.integer "bot1_score"
    t.integer "bot2_score"
    t.string "bot_difficulty"
    t.text "categories"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
