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

ActiveRecord::Schema.define(version: 20200205060359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone_number"
    t.string "description"
  end

  create_table "pet_applications", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "application_id"
    t.index ["application_id"], name: "index_pet_applications_on_application_id"
    t.index ["pet_id"], name: "index_pet_applications_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "image", default: "https://www.galadarigroup.com/wp-content/themes/Galadari_brothers/images/thumbnail-default.jpg"
    t.string "name"
    t.integer "age"
    t.string "sex"
    t.bigint "shelter_id"
    t.boolean "adoptable", default: true
    t.string "description"
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.string "rating"
    t.string "content"
    t.string "image", default: "https://www.galadarigroup.com/wp-content/themes/Galadari_brothers/images/thumbnail-default.jpg"
    t.bigint "shelter_id"
    t.index ["shelter_id"], name: "index_reviews_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
  end

  add_foreign_key "pet_applications", "applications"
  add_foreign_key "pet_applications", "pets"
  add_foreign_key "pets", "shelters"
  add_foreign_key "reviews", "shelters"
end
