# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081024071214) do

  create_table "admins", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "superadmin",                              :default => false
    t.integer  "personnel_id"
  end

  add_index "admins", ["login"], :name => "index_admins_on_login", :unique => true

  create_table "alerts", :force => true do |t|
    t.integer  "target_id"
    t.string   "target_type", :limit => 30
    t.integer  "admin_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["target_type", "target_id"], :name => "index_alerts_on_target_type_and_target_id"
  add_index "alerts", ["admin_id"], :name => "index_alerts_on_admin_id"

  create_table "personnels", :force => true do |t|
    t.integer  "personnel_id",               :null => false
    t.string   "first_name",   :limit => 30
    t.string   "middle_name",  :limit => 30
    t.string   "last_name",    :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.integer  "student_id",                                   :null => false
    t.string   "first_name",    :limit => 30
    t.string   "middle_name",   :limit => 30
    t.string   "last_name",     :limit => 30
    t.string   "record_status", :limit => 1,  :default => "E"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["student_id"], :name => "index_students_on_student_id"

end
