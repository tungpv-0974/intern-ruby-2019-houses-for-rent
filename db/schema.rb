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

ActiveRecord::Schema.define(version: 2020_02_26_134808) do

  create_table "districts", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false, collation: "utf8_general_ci"
    t.string "district_type", null: false, collation: "utf8_general_ci"
    t.integer "province_id", null: false
  end

  create_table "identify_cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "identify_number"
    t.string "provide_by"
    t.date "date_of_license"
    t.string "image_url"
  end

  create_table "post_favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["user_id", "post_id"], name: "index_post_favorites_on_user_id_and_post_id", unique: true
  end

  create_table "post_pictures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "active"
    t.integer "total_bathroom"
    t.integer "total_bedroom"
    t.integer "area"
    t.integer "price"
    t.integer "house_type"
    t.integer "user_id"
    t.string "address"
    t.integer "ward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "provinces", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.string "name", null: false, collation: "utf8_general_ci"
    t.string "province_type", null: false, collation: "utf8_general_ci"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.date "birthdate"
    t.string "avatar_url"
    t.string "address"
    t.integer "identify_card_id"
    t.integer "ward_id"
    t.integer "role"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.integer "activated"
    t.datetime "activated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wards", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false, collation: "utf8_general_ci"
    t.string "ward_type", null: false, collation: "utf8_general_ci"
    t.integer "district_id", null: false
  end

end
