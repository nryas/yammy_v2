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

ActiveRecord::Schema.define(version: 20151113153817) do

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.integer  "energy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.date     "date"
    t.string   "period"
    t.integer  "energy"
    t.integer  "protein"
    t.integer  "fat"
    t.integer  "carbohydrate"
    t.float    "salt"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "menus", force: :cascade do |t|
    t.integer  "meal_id"
    t.integer  "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
