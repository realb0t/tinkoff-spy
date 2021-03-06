# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150915123702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.string   "currency",                 null: false
    t.string   "deal_type",                null: false
    t.string   "sign",                     null: false
    t.float    "value",      default: 0.0, null: false
    t.string   "email",                    null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "alerts", ["currency", "deal_type", "sign", "value"], name: "index_alerts_on_currency_and_deal_type_and_sign_and_value", using: :btree

  create_table "rates", force: :cascade do |t|
    t.string   "from",                     null: false
    t.string   "to",                       null: false
    t.float    "ask",        default: 0.0, null: false
    t.float    "bid",        default: 0.0, null: false
    t.datetime "parsed_at",                null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "rates", ["from", "to"], name: "rates_from_to", using: :btree
  add_index "rates", ["from"], name: "rates_from", using: :btree
  add_index "rates", ["parsed_at"], name: "rates_parsed_at", using: :btree
  add_index "rates", ["to"], name: "rates_to", using: :btree

end
