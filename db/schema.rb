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

ActiveRecord::Schema.define(version: 20171002173547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acts_as_bookable_bookings", force: :cascade do |t|
    t.string   "bookable_type"
    t.integer  "bookable_id"
    t.string   "booker_type"
    t.integer  "booker_id"
    t.integer  "amount"
    t.text     "schedule"
    t.datetime "time_start"
    t.datetime "time_end"
    t.datetime "time"
    t.datetime "created_at"
    t.index ["bookable_type", "bookable_id"], name: "index_acts_as_bookable_bookings_bookable", using: :btree
    t.index ["booker_type", "booker_id"], name: "index_acts_as_bookable_bookings_booker", using: :btree
  end

  create_table "channels", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_appointments", force: :cascade do |t|
    t.datetime "date"
    t.string   "status"
    t.text     "comments"
    t.integer  "client_id"
    t.integer  "therapist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["client_id"], name: "index_client_appointments_on_client_id", using: :btree
    t.index ["therapist_id"], name: "index_client_appointments_on_therapist_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "folio"
    t.string   "street"
    t.string   "neighborhood"
    t.string   "city"
    t.integer  "zipcode"
    t.string   "house_phone"
    t.string   "mobile_phone"
    t.integer  "age"
    t.string   "tutor_name"
    t.date     "contact_date"
    t.text     "observations"
    t.integer  "channel_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["channel_id"], name: "index_clients_on_channel_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.string   "week_day"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "therapist_id"
    t.index ["therapist_id"], name: "index_schedules_on_therapist_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.float    "initial_price"
    t.float    "subsequent_price"
    t.float    "community_price"
  end

  create_table "therapists", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_therapists_on_user_id", using: :btree
  end

  create_table "treatments", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "client_id"
    t.integer  "therapist_id"
    t.integer  "service_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["client_id"], name: "index_treatments_on_client_id", using: :btree
    t.index ["service_id"], name: "index_treatments_on_service_id", using: :btree
    t.index ["therapist_id"], name: "index_treatments_on_therapist_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "client_appointments", "clients"
  add_foreign_key "client_appointments", "therapists"
  add_foreign_key "clients", "channels"
  add_foreign_key "schedules", "therapists"
  add_foreign_key "therapists", "users"
  add_foreign_key "treatments", "clients"
  add_foreign_key "treatments", "services"
  add_foreign_key "treatments", "therapists"
end
