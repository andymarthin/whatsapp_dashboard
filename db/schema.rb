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

ActiveRecord::Schema[8.0].define(version: 2024_10_18_095658) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.text "file_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["message_id"], name: "index_attachments_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.integer "message_type"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message_id"
    t.string "sender"
    t.jsonb "options"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "description"
    t.text "body"
    t.integer "question_type"
    t.integer "status"
    t.string "footer"
    t.text "answer"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", default: 0
    t.string "button"
    t.bigint "section_id"
    t.index ["parent_id"], name: "index_questions_on_parent_id"
    t.index ["section_id"], name: "index_questions_on_section_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "open_until"
    t.string "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bot", default: true
    t.index ["from"], name: "index_rooms_on_from"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_sections_on_question_id"
  end

  add_foreign_key "attachments", "messages"
  add_foreign_key "messages", "rooms"
  add_foreign_key "questions", "questions", column: "parent_id"
  add_foreign_key "questions", "sections"
  add_foreign_key "sections", "questions"
end
