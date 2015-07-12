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

ActiveRecord::Schema.define(version: 20150709161519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_themes", force: :cascade do |t|
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "article_theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "top",              default: false
  end

  add_index "articles", ["article_theme_id"], name: "index_articles_on_article_theme_id", using: :btree

  create_table "assets", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.integer  "position",                default: 0
    t.string   "type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "ancestry"
    t.integer  "position"
    t.boolean  "leaf",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  add_index "categories", ["position"], name: "index_categories_on_position", using: :btree

  create_table "contents", force: :cascade do |t|
    t.text     "text"
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "user_name"
    t.string   "user_phone"
    t.integer  "user_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",                         null: false
    t.string   "url",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pageable_id"
    t.string   "pageable_type"
    t.boolean  "hidden",        default: false
    t.string   "url_old"
    t.string   "name"
  end

  add_index "pages", ["url"], name: "index_pages_on_url", unique: true, using: :btree
  add_index "pages", ["url_old"], name: "index_pages_on_url_old", unique: true, using: :btree

  create_table "price_ranges", force: :cascade do |t|
    t.integer "from"
    t.integer "to"
    t.integer "category_id"
  end

  add_index "price_ranges", ["category_id"], name: "index_price_ranges_on_category_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    default: 0
    t.boolean  "novelty",     default: false
    t.boolean  "hit",         default: false
    t.integer  "brand_id"
    t.string   "video"
    t.integer  "old_id"
    t.text     "properties"
    t.float    "age_from"
    t.float    "age_to"
    t.boolean  "drop_price",  default: false
    t.integer  "sex",         default: 0
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["position"], name: "index_products_on_position", using: :btree

  create_table "related_pages", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "related_id"
    t.integer  "type_of"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "related_pages", ["page_id"], name: "index_related_pages_on_page_id", using: :btree
  add_index "related_pages", ["related_id"], name: "index_related_pages_on_related_id", using: :btree

  create_table "suborders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "variant_id"
    t.float   "price"
    t.integer "count",      default: 1
  end

  add_index "suborders", ["order_id"], name: "index_suborders_on_order_id", using: :btree
  add_index "suborders", ["variant_id"], name: "index_suborders_on_variant_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "subscribed", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variants", force: :cascade do |t|
    t.string   "name"
    t.boolean  "master",     default: false
    t.float    "price"
    t.float    "price_old"
    t.string   "sku"
    t.boolean  "available",  default: true
    t.integer  "position",   default: 0
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variants", ["position"], name: "index_variants_on_position", using: :btree
  add_index "variants", ["price"], name: "index_variants_on_price", using: :btree
  add_index "variants", ["product_id"], name: "index_variants_on_product_id", using: :btree

  add_foreign_key "suborders", "orders"
  add_foreign_key "suborders", "variants"
end
