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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121024043248) do

  create_table "activities", :force => true do |t|
    t.string   "organization"
    t.string   "position"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "activities_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "activity_id"
  end

  create_table "analyses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resume_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "analyses_job_descriptions", :force => true do |t|
    t.integer  "analysis_id"
    t.integer  "job_description_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "awards", :force => true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.datetime "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "awards_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "award_id"
  end

  create_table "beta_codes", :force => true do |t|
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "beta_requests", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "beta_code_id", :limit => 255
    t.datetime "approved_at"
  end

  create_table "education", :force => true do |t|
    t.integer  "user_id"
    t.string   "school"
    t.string   "city"
    t.string   "state"
    t.string   "degree"
    t.string   "major"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "education_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "education_id"
  end

  create_table "experiences", :force => true do |t|
    t.integer  "position_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "experiences_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "experience_id"
  end

  create_table "job_descriptions", :force => true do |t|
    t.string   "job_title"
    t.string   "company"
    t.text     "description_string", :limit => 255
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "master_resumes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "positions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "company"
    t.string   "city"
    t.string   "state"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "current",    :default => false
  end

  create_table "positions_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "position_id"
  end

  create_table "resumes", :force => true do |t|
    t.string   "description"
    t.binary   "middle_name"
    t.binary   "address"
    t.binary   "city"
    t.binary   "email"
    t.binary   "website"
    t.binary   "phone"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "style_id"
    t.integer  "tag_id"
  end

  create_table "skills", :force => true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "skills_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "skill_id"
  end

  create_table "styles", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "screen_filename_file_name"
    t.string   "screen_filename_content_type"
    t.integer  "screen_filename_file_size"
    t.datetime "screen_filename_updated_at"
    t.string   "print_filename_file_name"
    t.string   "print_filename_content_type"
    t.integer  "print_filename_file_size"
    t.datetime "print_filename_updated_at"
    t.binary   "base_style"
  end

  create_table "tags", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "user_strings", :force => true do |t|
    t.integer  "analysis_id"
    t.text     "user_string"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.binary   "verified"
    t.string   "verification_code"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                :default => false
    t.string   "password_reset_token"
    t.datetime "password_reset_at"
    t.integer  "beta_code_id"
    t.string   "linkedin_atoken"
    t.string   "linkedin_id"
    t.string   "linkedin_secret"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
