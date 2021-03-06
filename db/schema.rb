# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180529185703) do

  create_table "body_parts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_body_parts_on_user_id"
  end

  create_table "body_parts_exercises", id: false, force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.integer "body_part_id", null: false
    t.index ["body_part_id", "exercise_id"], name: "index_body_parts_exercises_on_body_part_id_and_exercise_id"
    t.index ["exercise_id", "body_part_id"], name: "index_body_parts_exercises_on_exercise_id_and_body_part_id"
  end

  create_table "exercise_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_exercise_categories_on_user_id"
  end

  create_table "exercise_sets", force: :cascade do |t|
    t.string "setable_type"
    t.integer "setable_id"
    t.integer "reps"
    t.decimal "weight"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "distance"
    t.index ["setable_type", "setable_id"], name: "index_exercise_sets_on_setable_type_and_setable_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "exercise_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "available_fields_definition", default: ""
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_exercises_on_deleted_at"
    t.index ["exercise_category_id"], name: "index_exercises_on_exercise_category_id"
  end

  create_table "routine_exercises", force: :cascade do |t|
    t.integer "exercise_id"
    t.integer "routine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "length_unit"
    t.string "weight_unit"
    t.index ["exercise_id"], name: "index_routine_exercises_on_exercise_id"
    t.index ["routine_id"], name: "index_routine_exercises_on_routine_id"
  end

  create_table "routines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exercise_category_id"
    t.string "weight_unit"
    t.string "length_unit"
    t.string "locale"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["exercise_category_id"], name: "index_users_on_exercise_category_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.integer "exercise_id"
    t.integer "workout_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "weight_unit"
    t.string "length_unit"
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.datetime "date"
    t.integer "duration"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

end
