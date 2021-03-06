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

ActiveRecord::Schema.define(version: 20171116234951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "spotlighted", default: false
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "campaigns_contacts", id: false, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "contact_id"
    t.index ["campaign_id"], name: "index_campaigns_contacts_on_campaign_id"
    t.index ["contact_id"], name: "index_campaigns_contacts_on_contact_id"
  end

  create_table "campaigns_tags", id: false, force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "tag_id"
    t.index ["campaign_id"], name: "index_campaigns_tags_on_campaign_id"
    t.index ["tag_id"], name: "index_campaigns_tags_on_tag_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "country"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "contacts_tags", id: false, force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "tag_id"
    t.index ["contact_id"], name: "index_contacts_tags_on_contact_id"
    t.index ["tag_id"], name: "index_contacts_tags_on_tag_id"
  end

  create_table "email_events", force: :cascade do |t|
    t.integer "event", default: 0, null: false
    t.bigint "email_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_id"], name: "index_email_events_on_email_id"
  end

  create_table "emails", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_emails_on_campaign_id"
    t.index ["contact_id"], name: "index_emails_on_contact_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "last_name"
    t.string "phone"
    t.string "country"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "emails", "campaigns"
  add_foreign_key "emails", "contacts"
end
