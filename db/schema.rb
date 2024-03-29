# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_11_043247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_feedbacks_on_status"
    t.index ["title"], name: "index_feedbacks_on_title", unique: true
  end

  create_table "feedbacks_questions", force: :cascade do |t|
    t.bigint "feedback_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feedback_id", "question_id"], name: "index_feedbacks_questions_on_feedback_id_and_question_id"
    t.index ["feedback_id"], name: "index_feedbacks_questions_on_feedback_id"
    t.index ["question_id"], name: "index_feedbacks_questions_on_question_id"
  end

  create_table "feedbacks_questions_answers", force: :cascade do |t|
    t.bigint "feedbacks_question_id", null: false
    t.string "text", null: false
    t.integer "user_id", null: false
    t.integer "reviewer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feedbacks_question_id"], name: "index_feedbacks_questions_answers_on_feedbacks_question_id"
    t.index ["reviewer_id"], name: "index_feedbacks_questions_answers_on_reviewer_id"
    t.index ["user_id"], name: "index_feedbacks_questions_answers_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_feedbacks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "feedback_id"
    t.integer "reviewer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.index ["feedback_id"], name: "index_users_feedbacks_on_feedback_id"
    t.index ["user_id", "feedback_id", "reviewer_id"], name: "index_users_feedbacks_on_user_feedback", unique: true
    t.index ["user_id"], name: "index_users_feedbacks_on_user_id"
  end

  add_foreign_key "feedbacks_questions", "feedbacks"
  add_foreign_key "feedbacks_questions", "questions"
  add_foreign_key "feedbacks_questions_answers", "feedbacks_questions"
end
