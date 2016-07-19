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

ActiveRecord::Schema.define(version: 20160719125314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "uuid-ossp"

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
    t.index ["article_theme_id"], name: "index_articles_on_article_theme_id", using: :btree
  end

  create_table "assets", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assetable_id"
    t.string   "assetable_type",          limit: 255
    t.integer  "position",                            default: 0
    t.string   "type",                    limit: 255
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "availability_subscribers", force: :cascade do |t|
    t.integer "variant_id"
    t.string  "email"
    t.string  "phone"
    t.index ["variant_id", "email"], name: "index_availability_subscribers_on_variant_id_and_email", unique: true, using: :btree
    t.index ["variant_id", "phone"], name: "index_availability_subscribers_on_variant_id_and_phone", unique: true, using: :btree
    t.index ["variant_id"], name: "index_availability_subscribers_on_variant_id", using: :btree
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",          limit: 255
    t.string   "meta_keywords"
    t.string   "meta_description"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "ancestry",   limit: 255
    t.integer  "position"
    t.boolean  "leaf",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["position"], name: "index_categories_on_position", using: :btree
  end

  create_table "contents", force: :cascade do |t|
    t.text     "text"
    t.integer  "contentable_id"
    t.string   "contentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "product_offer_id"
    t.float    "price"
    t.integer  "position",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "index_offers_on_product_id", using: :btree
    t.index ["product_offer_id"], name: "index_offers_on_product_offer_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "user_name",        limit: 255
    t.string   "user_phone",       limit: 255
    t.integer  "user_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total"
    t.integer  "payment_method"
    t.integer  "status",                                               default: 0
    t.uuid     "uuid",                                                 default: -> { "uuid_generate_v4()" }
    t.decimal  "total_correction",             precision: 8, scale: 2, default: "0.0"
    t.float    "commission",                                           default: 0.0
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",            limit: 255,                 null: false
    t.string   "url",              limit: 255,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pageable_id"
    t.string   "pageable_type",    limit: 255
    t.boolean  "hidden",                       default: false
    t.string   "url_old",          limit: 255
    t.string   "name",             limit: 255
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "seo_title"
    t.index ["url"], name: "index_pages_on_url", unique: true, using: :btree
    t.index ["url_old"], name: "index_pages_on_url_old", unique: true, using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.float    "amount"
    t.string   "transaction_uid"
    t.string   "account"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["order_id"], name: "index_payments_on_order_id", using: :btree
  end

  create_table "price_ranges", force: :cascade do |t|
    t.integer "from"
    t.integer "to"
    t.integer "category_id"
    t.index ["category_id"], name: "index_price_ranges_on_category_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                default: 0
    t.boolean  "novelty",                 default: false
    t.boolean  "hit",                     default: false
    t.integer  "brand_id"
    t.string   "video",       limit: 255
    t.integer  "old_id"
    t.text     "properties"
    t.float    "age_from"
    t.float    "age_to"
    t.boolean  "drop_price",              default: false
    t.integer  "sex",                     default: 0
    t.boolean  "free_ship",               default: false
    t.index ["brand_id"], name: "index_products_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["position"], name: "index_products_on_position", using: :btree
  end

  create_table "related_pages", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "related_id"
    t.integer  "type_of"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id"], name: "index_related_pages_on_page_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "suborders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "variant_id"
    t.float   "price"
    t.integer "quantity",   default: 1
    t.float   "discount",   default: 0.0
    t.index ["order_id"], name: "index_suborders_on_order_id", using: :btree
    t.index ["variant_id"], name: "index_suborders_on_variant_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.boolean  "subscribed",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "master",                 default: false
    t.float    "price"
    t.float    "price_old"
    t.string   "sku",        limit: 255
    t.boolean  "available",              default: true
    t.integer  "position",               default: 0
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["position"], name: "index_variants_on_position", using: :btree
    t.index ["price"], name: "index_variants_on_price", using: :btree
    t.index ["product_id"], name: "index_variants_on_product_id", using: :btree
  end

  add_foreign_key "availability_subscribers", "variants"
  add_foreign_key "offers", "products", column: "product_offer_id"
  add_foreign_key "payments", "orders"
  add_foreign_key "suborders", "orders"
  add_foreign_key "suborders", "variants"
end
