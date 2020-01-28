# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_24_160334) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.integer "third_id", null: false
    t.integer "invoice_id", null: false
    t.integer "enterprise_id", null: false
    t.integer "collection_advisor_id", null: false
    t.integer "collector_id"
    t.string "type"
    t.text "description"
    t.integer "status"
    t.date "date_activity"
    t.integer "type_activity"
    t.integer "call_outcome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "contact_id"
    t.datetime "remember"
    t.datetime "due_date"
    t.string "title"
    t.boolean "remind", default: false
    t.integer "created_by_id"
    t.boolean "send_now"
    t.index ["contact_id"], name: "index_activities_on_contact_id"
    t.index ["enterprise_id"], name: "index_activities_on_enterprise_id"
    t.index ["invoice_id"], name: "index_activities_on_invoice_id"
    t.index ["third_id"], name: "index_activities_on_third_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "description"
    t.string "addressable_type"
    t.integer "addressable_id"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "admin_invoices", force: :cascade do |t|
    t.float "total"
    t.text "description"
    t.integer "enterprise_id", null: false
    t.integer "status", default: 0
    t.date "payment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_admin_invoices_on_enterprise_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "auto_tasks", force: :cascade do |t|
    t.integer "time"
    t.integer "number_days"
    t.integer "type_task"
    t.string "name"
    t.string "title"
    t.text "description"
    t.integer "type_activity"
    t.integer "enterprise_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_auto_tasks_on_enterprise_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "full_name"
    t.string "phone"
    t.string "cellphone"
    t.string "email"
    t.integer "third_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["third_id"], name: "index_contacts_on_third_id"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "name"
    t.string "nit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "excel"
    t.text "payment_conditions"
    t.integer "current_status", default: 0
  end

  create_table "invoices", force: :cascade do |t|
    t.string "code", null: false
    t.string "type", null: false
    t.integer "enterprise_id", null: false
    t.integer "third_id", null: false
    t.date "creation_date"
    t.date "expiration_date"
    t.float "subtotal"
    t.float "total"
    t.float "balance"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "payment_date"
    t.integer "collector_advisor_id"
    t.integer "collection_status", default: 0
    t.index ["enterprise_id"], name: "index_invoices_on_enterprise_id"
    t.index ["third_id"], name: "index_invoices_on_third_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "description"
    t.string "notable_type", null: false
    t.integer "notable_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "option_types", force: :cascade do |t|
    t.string "name"
    t.integer "enterprise_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_option_types_on_enterprise_id"
  end

  create_table "option_value_variants", force: :cascade do |t|
    t.integer "option_value_id", null: false
    t.integer "variant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_value_id"], name: "index_option_value_variants_on_option_value_id"
    t.index ["variant_id"], name: "index_option_value_variants_on_variant_id"
  end

  create_table "option_values", force: :cascade do |t|
    t.integer "option_type_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_type_id"], name: "index_option_values_on_option_type_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.datetime "payment_date"
    t.date "next_payment"
    t.float "amount"
    t.integer "reported_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "product_option_types", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "option_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_type_id"], name: "index_product_option_types_on_option_type_id"
    t.index ["product_id"], name: "index_product_option_types_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "enterprise_id"
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_products_on_enterprise_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "name_es"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "thirds", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "email"
    t.string "cellphone"
    t.string "phone"
    t.integer "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "identification"
    t.index ["enterprise_id"], name: "index_thirds_on_enterprise_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "enterprise_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "google_refresh_token"
    t.text "google_token"
    t.string "unique_session_id", limit: 20
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "sku"
    t.boolean "is_master", default: false
    t.integer "product_id", null: false
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "contacts"
  add_foreign_key "activities", "enterprises"
  add_foreign_key "activities", "invoices"
  add_foreign_key "activities", "thirds"
  add_foreign_key "admin_invoices", "enterprises"
  add_foreign_key "auto_tasks", "enterprises"
  add_foreign_key "contacts", "thirds"
  add_foreign_key "invoices", "enterprises"
  add_foreign_key "invoices", "thirds"
  add_foreign_key "option_value_variants", "option_values"
  add_foreign_key "option_value_variants", "variants"
  add_foreign_key "payments", "invoices"
  add_foreign_key "product_option_types", "option_types"
  add_foreign_key "product_option_types", "products"
  add_foreign_key "thirds", "enterprises"
  add_foreign_key "variants", "products"
end
