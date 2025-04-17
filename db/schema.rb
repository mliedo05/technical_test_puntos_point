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

ActiveRecord::Schema.define(version: 2025_04_10_230406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'admins', force: :cascade do |t|
    t.string 'name'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'admin_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['admin_id'], name: 'index_categories_on_admin_id'
  end

  create_table 'clients', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'phone'
    t.string 'address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.index ['email'], name: 'index_clients_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_clients_on_reset_password_token', unique: true
  end

  create_table 'product_categories', force: :cascade do |t|
    t.bigint 'product_id'
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_product_categories_on_category_id'
    t.index ['product_id'], name: 'index_product_categories_on_product_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'price'
    t.integer 'stock'
    t.bigint 'admin_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['admin_id'], name: 'index_products_on_admin_id'
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories", "admins"
  add_foreign_key "products", "admins"
end
