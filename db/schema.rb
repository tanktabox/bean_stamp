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

ActiveRecord::Schema.define(version: 2021_11_28_024423) do
  create_table 'bean_images',
               charset: 'utf8mb4',
               collation: 'utf8mb4_0900_ai_ci',
               force: :cascade do |t|
    t.string 'image'
    t.bigint 'bean_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['bean_id'], name: 'index_bean_images_on_bean_id'

  create_table "bean_taste_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "bean_id", null: false
    t.bigint "mst_taste_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bean_id", "mst_taste_tag_id"], name: "index_bean_taste_tags_on_bean_id_and_mst_taste_tag_id", unique: true
    t.index ["bean_id"], name: "index_bean_taste_tags_on_bean_id"
    t.index ["mst_taste_tag_id"], name: "index_bean_taste_tags_on_mst_taste_tag_id"
  end

  create_table 'beans',
               charset: 'utf8mb4',
               collation: 'utf8mb4_0900_ai_ci',
               force: :cascade do |t|
    t.string 'name'
    t.bigint 'roaster_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'country', default: '', null: false
    t.string 'subregion', default: '', null: false
    t.string 'farm', default: '', null: false
    t.string 'variety', default: '', null: false
    t.integer 'elevation'
    t.string 'process', default: '', null: false
    t.date 'cropped_at'
    t.text 'describe'
    t.integer 'acidity'
    t.integer 'flavor'
    t.integer 'body'
    t.integer 'bitterness'
    t.integer 'sweetness'

    create_table 'bean_taste_tags',
                 charset: 'utf8mb4',
                 collation: 'utf8mb4_0900_ai_ci',
                 force: :cascade do |t|
      t.bigint 'bean_id', null: false
      t.bigint 'mst_taste_tag_id', null: false
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index %w[bean_id mst_taste_tag_id],
              name: 'index_bean_taste_tags_on_bean_id_and_mst_taste_tag_id',
              unique: true
      t.index ['bean_id'], name: 'index_bean_taste_tags_on_bean_id'
      t.index ['mst_taste_tag_id'],
              name: 'index_bean_taste_tags_on_mst_taste_tag_id'
    end

    t.bigint 'roast_level_id', default: 0
    t.index ['country'], name: 'index_beans_on_country'
    t.index ['roast_level_id'], name: 'index_beans_on_roast_level_id'
    t.index %w[roaster_id created_at],
            name: 'index_beans_on_roaster_id_and_created_at'
    t.index ['roaster_id'], name: 'index_beans_on_roaster_id'
  end

  create_table 'mst_roast_levels',
               charset: 'utf8mb4',
               collation: 'utf8mb4_0900_ai_ci',
               force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table "mst_taste_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "taste_group_id", null: false
    t.index ["taste_group_id"], name: "index_mst_taste_tags_on_taste_group_id"
  end

  create_table 'roasters',
               charset: 'utf8mb4',
               collation: 'utf8mb4_0900_ai_ci',
               force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'phone_number', default: '', null: false
    t.string 'prefecture_code', default: '', null: false
    t.text 'describe'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'image'
    t.string 'address', default: '', null: false
    t.boolean 'guest', default: false
    t.index ['prefecture_code'], name: 'index_roasters_on_prefecture_code'
  end

  create_table 'users',
               charset: 'utf8mb4',
               collation: 'utf8mb4_0900_ai_ci',
               force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name', default: '', null: false
    t.string 'prefecture_code', default: ''
    t.text 'describe'
    t.string 'image'
    t.bigint 'roaster_id'
    t.boolean 'guest', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'],
            name: 'index_users_on_reset_password_token',
            unique: true
    t.index ['roaster_id'], name: 'index_users_on_roaster_id'
  end

  add_foreign_key 'bean_images', 'beans'
  add_foreign_key 'bean_taste_tags', 'beans'
  add_foreign_key 'bean_taste_tags', 'mst_taste_tags'
  add_foreign_key 'beans', 'mst_roast_levels', column: 'roast_level_id'
  add_foreign_key 'beans', 'roasters'
  add_foreign_key 'users', 'roasters'
end
