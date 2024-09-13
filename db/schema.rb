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

ActiveRecord::Schema[7.1].define(version: 2024_09_13_114046) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "clue_id", null: false
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clue_id"], name: "index_answers_on_clue_id"
  end

  create_table "clues", force: :cascade do |t|
    t.string "category"
    t.date "air_date"
    t.text "question"
    t.string "value"
    t.string "round"
    t.string "show_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_clues_on_category"
    t.index ["round"], name: "index_clues_on_round"
  end

  create_table "games", force: :cascade do |t|
    t.string "player_name"
    t.string "bot_name"
    t.integer "player_score"
    t.integer "bot_score"
    t.string "bot_difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "category_1"
    t.json "category_2"
    t.json "category_3"
    t.json "category_4"
    t.json "category_5"
    t.json "category_6"
    t.integer "answered_count", default: 0
  end

  add_foreign_key "answers", "clues"
end
