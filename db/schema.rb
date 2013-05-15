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

ActiveRecord::Schema.define(:version => 20120928073520) do

  create_table "locations", :force => true do |t|
    t.string   "Name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations_projects", :id => false, :force => true do |t|
    t.integer  "location_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", :force => true do |t|
    t.string   "Title"
    t.string   "Author"
    t.string   "Link"
    t.date     "pubdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_links", :force => true do |t|
    t.string   "Title"
    t.string   "link"
    t.date     "pubdate"
    t.integer  "news_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_lists", :force => true do |t|
    t.string   "Name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_sources", :force => true do |t|
    t.string   "Name"
    t.string   "abbreviation"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsitems", :force => true do |t|
    t.string   "Title"
    t.text     "Teaser"
    t.string   "Link"
    t.string   "guid"
    t.string   "Author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "news_source_id"
    t.date     "pubdate",        :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "Firstname"
    t.string   "Surname"
    t.string   "Position"
    t.string   "Role"
    t.string   "Status"
    t.string   "Phone"
    t.string   "Email"
    t.string   "Mobile"
    t.string   "Profile"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_uid"
    t.text     "photo_name"
  end

  create_table "people_projects", :id => false, :force => true do |t|
    t.integer  "person_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people_publications", :id => false, :force => true do |t|
    t.integer  "person_id"
    t.integer  "publication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "Title"
    t.text     "Description"
    t.string   "link"
    t.string   "Status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_publications", :id => false, :force => true do |t|
    t.integer  "project_id"
    t.integer  "publication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", :force => true do |t|
    t.string   "type"
    t.string   "Title"
    t.string   "Authors"
    t.string   "link"
    t.string   "With"
    t.string   "Details"
    t.string   "Year"
    t.string   "Status"
    t.boolean  "Refereed"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pubtypes", :force => true do |t|
    t.string   "kind"
    t.string   "abbreviation"
    t.string   "icon"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.text     "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "Name"
    t.string   "css_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "theme_id",           :limit => 1
    t.integer  "publications_count",              :default => 0
    t.integer  "news_items_count",                :default => 0
    t.integer  "news_links_count",                :default => 0
    t.integer  "projects_count",                  :default => 0
    t.integer  "people_count",                    :default => 0
  end

  create_table "tags_themes", :id => false, :force => true do |t|
    t.integer  "tag_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tagtests", :force => true do |t|
    t.string   "Name"
    t.string   "css_class"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "themes", :force => true do |t|
    t.string   "Name"
    t.string   "css_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
