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

ActiveRecord::Schema.define(version: 20140523154414) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reports", force: true do |t|
    t.float    "lat"
    t.string   "email"
    t.string   "description"
    t.string   "species"
    t.string   "race"
    t.string   "size"
    t.string   "color"
    t.string   "age"
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "status"
    t.float    "lon"
    t.string   "name"
  end

  create_table "sightings", force: true do |t|
    t.float    "lat"
    t.string   "email"
    t.string   "description"
    t.string   "species"
    t.string   "race"
    t.string   "size"
    t.string   "color"
    t.string   "age"
    t.string   "sex"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "status"
    t.float    "lon"
    t.string   "name"
  end

end
