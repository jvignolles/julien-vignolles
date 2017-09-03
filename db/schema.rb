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

ActiveRecord::Schema.define(version: 20170903212240) do

  create_table "admins", force: true do |t|
    t.boolean  "active",                             default: true,  null: false
    t.string   "civility",               limit: 4,   default: "mr",  null: false
    t.string   "first_name",             limit: 64,  default: "",    null: false
    t.string   "last_name",              limit: 64,  default: "",    null: false
    t.string   "phone_home",             limit: 30,  default: "",    null: false
    t.string   "phone_mobile",           limit: 30,  default: "",    null: false
    t.string   "phone_work",             limit: 30,  default: "",    null: false
    t.string   "email",                  limit: 80,  default: "",    null: false
    t.string   "encrypted_password",     limit: 128, default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                    default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "admin",                              default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", using: :btree
  add_index "admins", ["created_at"], name: "index_admins_on_created_at", using: :btree
  add_index "admins", ["email"], name: "index_admins_on_email", using: :btree
  add_index "admins", ["first_name", "last_name"], name: "index_admins_on_first_name_and_last_name", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", using: :btree

  create_table "banners", force: true do |t|
    t.boolean  "active",                  default: true, null: false
    t.string   "name",        limit: 50,  default: "",   null: false
    t.string   "url",         limit: 128, default: "",   null: false
    t.string   "description",             default: "",   null: false
    t.string   "button",      limit: 50,  default: "",   null: false
    t.integer  "position",                default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banners", ["created_at"], name: "index_banners_on_created_at", using: :btree
  add_index "banners", ["name"], name: "index_banners_on_name", using: :btree
  add_index "banners", ["position"], name: "index_banners_on_position", using: :btree

  create_table "blog_tags", force: true do |t|
    t.boolean  "active",                     default: true, null: false
    t.string   "name",            limit: 64, default: "",   null: false
    t.text     "description"
    t.string   "seo_title",                  default: "",   null: false
    t.string   "seo_h1",                     default: "",   null: false
    t.string   "seo_description",            default: "",   null: false
    t.text     "seo_keywords"
    t.integer  "position",                   default: 0,    null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "blog_tags", ["name"], name: "index_blog_tags_on_name", using: :btree
  add_index "blog_tags", ["position"], name: "index_blog_tags_on_position", using: :btree

  create_table "blog_tags_blog_topics", id: false, force: true do |t|
    t.integer "blog_tag_id"
    t.integer "blog_topic_id"
  end

  add_index "blog_tags_blog_topics", ["blog_tag_id", "blog_topic_id"], name: "index_blog_tags_blog_topics_on_blog_tag_id_and_blog_topic_id", using: :btree

  create_table "blog_topics", force: true do |t|
    t.boolean  "active",                      default: true, null: false
    t.integer  "admin_id"
    t.string   "name",            limit: 128, default: "",   null: false
    t.text     "introduction"
    t.text     "description"
    t.string   "seo_title",                   default: "",   null: false
    t.string   "seo_h1",                      default: "",   null: false
    t.string   "seo_description",             default: "",   null: false
    t.text     "seo_keywords"
    t.datetime "published_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "blog_topics", ["admin_id"], name: "index_blog_topics_on_admin_id", using: :btree
  add_index "blog_topics", ["created_at"], name: "index_blog_topics_on_created_at", using: :btree
  add_index "blog_topics", ["name"], name: "index_blog_topics_on_name", using: :btree
  add_index "blog_topics", ["published_at"], name: "index_blog_topics_on_published_at", using: :btree

  create_table "companies", force: true do |t|
    t.boolean  "active",                  default: true, null: false
    t.string   "name",        limit: 128, default: "",   null: false
    t.string   "location",    limit: 128, default: "",   null: false
    t.string   "website_url", limit: 128, default: "",   null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["created_at"], name: "index_companies_on_created_at", using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", using: :btree

  create_table "configurations", force: true do |t|
    t.string   "app_name",                    limit: 128, default: "",    null: false
    t.string   "baseline",                                default: "",    null: false
    t.string   "email_contact",               limit: 128, default: "",    null: false
    t.string   "company_name",                limit: 128, default: "",    null: false
    t.string   "phone",                       limit: 20,  default: "",    null: false
    t.string   "phone_hours",                 limit: 128, default: "",    null: false
    t.string   "fax",                         limit: 20,  default: "",    null: false
    t.string   "address",                                 default: "",    null: false
    t.string   "siret",                       limit: 14,  default: "",    null: false
    t.string   "siren",                       limit: 9,   default: "",    null: false
    t.string   "intracom_vat_number",         limit: 32,  default: "",    null: false
    t.text     "quotation_description"
    t.text     "newsletter_description"
    t.string   "seo_title",                   limit: 128, default: "",    null: false
    t.string   "seo_description",                         default: "",    null: false
    t.text     "seo_keywords"
    t.boolean  "website_on_hold",                         default: false, null: false
    t.text     "website_on_hold_description"
    t.string   "facebook_url",                limit: 128, default: "",    null: false
    t.string   "twitter_url",                 limit: 128, default: "",    null: false
    t.string   "googleplus_url",              limit: 128, default: "",    null: false
    t.string   "instagram_url",               limit: 128, default: "",    null: false
    t.string   "pinterest_url",               limit: 128, default: "",    null: false
    t.string   "linkedin_url",                limit: 128, default: "",    null: false
    t.string   "viadeo_url",                  limit: 128, default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_url",                  limit: 128, default: "",    null: false
    t.string   "stackoverflow_url",           limit: 128, default: "",    null: false
    t.boolean  "blog_active",                             default: false, null: false
    t.boolean  "entertainments_active",                   default: false, null: false
    t.boolean  "highlighted_projects_active",             default: false, null: false
    t.boolean  "contacts_active",                         default: false, null: false
  end

  create_table "contacts", force: true do |t|
    t.integer  "parent_id"
    t.string   "name",             limit: 128, default: "", null: false
    t.string   "email",            limit: 80,  default: "", null: false
    t.string   "phone",            limit: 20,  default: "", null: false
    t.string   "subject",          limit: 50,  default: "", null: false
    t.text     "description"
    t.integer  "admin_id"
    t.datetime "answered_at"
    t.integer  "answerer_id"
    t.integer  "latest_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree
  add_index "contacts", ["name", "email"], name: "index_contacts_on_name_and_email", using: :btree

  create_table "editorials", force: true do |t|
    t.boolean  "active",                      default: true, null: false
    t.boolean  "in_lateral_menu",             default: true, null: false
    t.string   "name",            limit: 128, default: "",   null: false
    t.string   "kind",            limit: 128, default: "",   null: false
    t.text     "text1"
    t.text     "text2"
    t.text     "text3"
    t.string   "seo_title",       limit: 128, default: "",   null: false
    t.string   "seo_h1",          limit: 128, default: "",   null: false
    t.string   "seo_description",             default: "",   null: false
    t.text     "seo_keywords"
    t.integer  "position",                    default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "editorials", ["created_at"], name: "index_editorials_on_created_at", using: :btree
  add_index "editorials", ["kind"], name: "index_editorials_on_kind", using: :btree
  add_index "editorials", ["name"], name: "index_editorials_on_name", using: :btree
  add_index "editorials", ["position"], name: "index_editorials_on_position", using: :btree

  create_table "educations", force: true do |t|
    t.boolean  "active",                    default: true, null: false
    t.string   "name",          limit: 128, default: "",   null: false
    t.string   "option",        limit: 128, default: "",   null: false
    t.string   "establishment", limit: 128, default: "",   null: false
    t.string   "location",      limit: 128, default: "",   null: false
    t.string   "website_url",   limit: 128, default: "",   null: false
    t.date     "started_on"
    t.date     "ended_on"
    t.text     "description"
    t.integer  "position",                  default: 0,    null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "educations", ["created_at"], name: "index_educations_on_created_at", using: :btree
  add_index "educations", ["name"], name: "index_educations_on_name", using: :btree
  add_index "educations", ["position"], name: "index_educations_on_position", using: :btree
  add_index "educations", ["started_on", "ended_on"], name: "index_educations_on_started_on_and_ended_on", using: :btree

  create_table "entertainments", force: true do |t|
    t.boolean  "active",     default: true, null: false
    t.string   "name",       default: "",   null: false
    t.integer  "position",   default: 0,    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "entertainments", ["created_at"], name: "index_entertainments_on_created_at", using: :btree
  add_index "entertainments", ["name"], name: "index_entertainments_on_name", using: :btree
  add_index "entertainments", ["position"], name: "index_entertainments_on_position", using: :btree

  create_table "highlights", force: true do |t|
    t.boolean  "active",                  default: true, null: false
    t.string   "name",        limit: 50,  default: "",   null: false
    t.string   "url",         limit: 128, default: "",   null: false
    t.string   "description",             default: "",   null: false
    t.integer  "position",                default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "highlights", ["created_at"], name: "index_highlights_on_created_at", using: :btree
  add_index "highlights", ["name"], name: "index_highlights_on_name", using: :btree
  add_index "highlights", ["position"], name: "index_highlights_on_position", using: :btree

  create_table "images", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type", limit: 32
    t.string   "content_type",   limit: 32,                 null: false
    t.integer  "position",                  default: 0,     null: false
    t.boolean  "assisted",                  default: false, null: false
    t.string   "kind",           limit: 32
    t.boolean  "zoomable",                  default: false, null: false
    t.string   "img",                       default: "",    null: false
    t.text     "dimensions"
    t.string   "legend",                    default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["created_at"], name: "index_images_on_created_at", using: :btree
  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree
  add_index "images", ["kind"], name: "index_images_on_kind", using: :btree
  add_index "images", ["position"], name: "index_images_on_position", using: :btree

  create_table "jobs", force: true do |t|
    t.boolean  "active",                      default: true, null: false
    t.string   "name",            limit: 128, default: "",   null: false
    t.date     "started_on"
    t.date     "ended_on"
    t.text     "description"
    t.integer  "company_id"
    t.string   "seo_title",       limit: 128, default: "",   null: false
    t.string   "seo_h1",          limit: 128, default: "",   null: false
    t.string   "seo_description",             default: "",   null: false
    t.text     "seo_keywords"
    t.integer  "position",                    default: 0,    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "jobs", ["created_at"], name: "index_jobs_on_created_at", using: :btree
  add_index "jobs", ["name"], name: "index_jobs_on_name", using: :btree
  add_index "jobs", ["position"], name: "index_jobs_on_position", using: :btree
  add_index "jobs", ["started_on", "ended_on"], name: "index_jobs_on_started_on_and_ended_on", using: :btree

  create_table "jobs_skills", id: false, force: true do |t|
    t.integer "job_id",   null: false
    t.integer "skill_id", null: false
  end

  add_index "jobs_skills", ["job_id", "skill_id"], name: "index_jobs_skills_on_job_id_and_skill_id", using: :btree

  create_table "parents", force: true do |t|
    t.boolean  "active",                  default: true, null: false
    t.string   "first_name",  limit: 128, default: "",   null: false
    t.string   "last_name",   limit: 128, default: "",   null: false
    t.text     "description"
    t.integer  "position",                default: 0,    null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "parents", ["created_at"], name: "index_parents_on_created_at", using: :btree
  add_index "parents", ["first_name", "last_name"], name: "index_parents_on_first_name_and_last_name", using: :btree

  create_table "projects", force: true do |t|
    t.boolean  "active",                          default: true,  null: false
    t.boolean  "highlight",                       default: false, null: false
    t.string   "name",                limit: 128, default: "",    null: false
    t.string   "year",                limit: 128, default: "",    null: false
    t.string   "website_url",         limit: 128, default: "",    null: false
    t.text     "description"
    t.integer  "job_id"
    t.string   "seo_title",           limit: 128, default: "",    null: false
    t.string   "seo_h1",              limit: 128, default: "",    null: false
    t.string   "seo_description",                 default: "",    null: false
    t.text     "seo_keywords"
    t.integer  "position",                        default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_description",             default: "",    null: false
  end

  add_index "projects", ["created_at"], name: "index_projects_on_created_at", using: :btree
  add_index "projects", ["job_id"], name: "index_projects_on_job_id", using: :btree
  add_index "projects", ["name"], name: "index_projects_on_name", using: :btree
  add_index "projects", ["position"], name: "index_projects_on_position", using: :btree

  create_table "projects_skills", id: false, force: true do |t|
    t.integer "project_id", null: false
    t.integer "skill_id",   null: false
  end

  add_index "projects_skills", ["project_id", "skill_id"], name: "index_projects_skills_on_project_id_and_skill_id", using: :btree

  create_table "quotations", force: true do |t|
    t.string   "first_name",       limit: 128, default: "", null: false
    t.string   "last_name",        limit: 80,  default: "", null: false
    t.string   "email",            limit: 128, default: "", null: false
    t.string   "phone",            limit: 20,  default: "", null: false
    t.string   "from_path"
    t.text     "description"
    t.integer  "product_id"
    t.integer  "admin_id"
    t.datetime "answered_at"
    t.integer  "answerer_id"
    t.integer  "latest_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotations", ["created_at"], name: "index_quotations_on_created_at", using: :btree
  add_index "quotations", ["first_name", "last_name", "email"], name: "index_quotations_on_first_name_and_last_name_and_email", using: :btree

  create_table "skills", force: true do |t|
    t.boolean  "active",                      default: true, null: false
    t.string   "name",            limit: 128, default: "",   null: false
    t.string   "title",           limit: 128, default: "",   null: false
    t.text     "description"
    t.string   "seo_title",       limit: 128, default: "",   null: false
    t.string   "seo_h1",          limit: 128, default: "",   null: false
    t.string   "seo_description",             default: "",   null: false
    t.text     "seo_keywords"
    t.integer  "position",                    default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["created_at"], name: "index_skills_on_created_at", using: :btree
  add_index "skills", ["name"], name: "index_skills_on_name", using: :btree
  add_index "skills", ["position"], name: "index_skills_on_position", using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "email",        limit: 128, null: false
    t.string   "kind",                     null: false
    t.string   "token",        limit: 10
    t.datetime "confirmation"
    t.datetime "revocation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["created_at"], name: "index_subscriptions_on_created_at", using: :btree
  add_index "subscriptions", ["email"], name: "index_subscriptions_on_email", using: :btree
  add_index "subscriptions", ["token"], name: "index_subscriptions_on_token", using: :btree

  create_table "team_members", force: true do |t|
    t.boolean  "active",                  default: true, null: false
    t.string   "civility",    limit: 4,   default: "mr", null: false
    t.string   "first_name",  limit: 128, default: "",   null: false
    t.string   "last_name",   limit: 128, default: "",   null: false
    t.text     "description"
    t.integer  "position",                default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_members", ["created_at"], name: "index_team_members_on_created_at", using: :btree
  add_index "team_members", ["first_name", "last_name"], name: "index_team_members_on_first_name_and_last_name", using: :btree
  add_index "team_members", ["position"], name: "index_team_members_on_position", using: :btree

end
