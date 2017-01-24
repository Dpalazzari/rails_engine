ActiveRecord::Schema.define(version: 20170124164516) do

  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "unit_price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at", precision: 0
    t.datetime "updated_at", precision: 0
  end

end
