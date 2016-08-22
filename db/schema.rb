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

ActiveRecord::Schema.define(version: 20160822130042) do

  create_table "bugs", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "state"
    t.integer  "project_id"
    t.integer  "creator_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bugs", ["project_id"], name: "index_bugs_on_project_id"

  create_table "bugs_tasks", force: :cascade do |t|
    t.integer "bug_id"
    t.integer "task_id"
  end

  add_index "bugs_tasks", ["bug_id"], name: "index_bugs_tasks_on_bug_id"
  add_index "bugs_tasks", ["task_id"], name: "index_bugs_tasks_on_task_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "manager_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "state",        default: 0
    t.integer  "progress",     default: 0
    t.integer  "developer_id"
    t.integer  "project_id"
    t.date     "deadline"
    t.datetime "finished_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"

  create_table "team_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.boolean  "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_members", ["team_id"], name: "index_team_members_on_team_id"
  add_index "team_members", ["user_id"], name: "index_team_members_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["project_id"], name: "index_teams_on_project_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_superuser"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
