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

ActiveRecord::Schema.define(version: 2020_04_17_232313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commentsses", force: :cascade do |t|
    t.string "message"
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "commented_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_commentsses_on_post_id"
    t.index ["user_id"], name: "index_commentsses_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.bigint "user_id", null: false
    t.datetime "posted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating"
    t.bigint "rater_id", null: false
    t.bigint "user_id", null: false
    t.datetime "rated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rater_id"], name: "index_ratings_on_rater_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "github_username"
    t.datetime "registered_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "commentsses", "posts"
  add_foreign_key "commentsses", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "ratings", "users"
end
