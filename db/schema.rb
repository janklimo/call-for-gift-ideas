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

ActiveRecord::Schema.define(version: 20171112133447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calls", force: :cascade do |t|
    t.string "slug"
    t.string "recipient_name"
    t.string "recipient_email"
    t.string "sender_email"
    t.integer "status", default: 0, null: false
    t.text "preferences", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender_name"
    t.integer "recipient_sex", default: 0, null: false
    t.boolean "demo", default: false, null: false
    t.index ["slug"], name: "index_calls_on_slug", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.float "price", null: false
    t.text "description"
    t.integer "target_audience", default: 0, null: false
    t.text "url"
    t.string "image_url"
    t.integer "external_id"
    t.float "clicks_score"
    t.index ["clicks_score"], name: "index_products_on_clicks_score"
    t.index ["external_id"], name: "index_products_on_external_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
