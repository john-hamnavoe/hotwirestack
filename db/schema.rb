# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_10_11_085744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filter_conditional_groups", force: :cascade do |t|
    t.bigint "filter_id", null: false
    t.integer "conditional_expression"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filter_id"], name: "index_filter_conditional_groups_on_filter_id"
  end

  create_table "filter_conditions", force: :cascade do |t|
    t.bigint "filter_conditional_group_id", null: false
    t.bigint "table_column_id", null: false
    t.string "predicate"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filter_conditional_group_id"], name: "index_filter_conditions_on_filter_conditional_group_id"
    t.index ["table_column_id"], name: "index_filter_conditions_on_table_column_id"
  end

  create_table "filters", force: :cascade do |t|
    t.string "name"
    t.bigint "index_view_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index_view_id"], name: "index_filters_on_index_view_id"
  end

  create_table "index_view_columns", force: :cascade do |t|
    t.bigint "index_view_id", null: false
    t.bigint "table_column_id", null: false
    t.integer "position"
    t.boolean "display", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index_view_id"], name: "index_index_view_columns_on_index_view_id"
    t.index ["table_column_id"], name: "index_index_view_columns_on_table_column_id"
  end

  create_table "index_views", force: :cascade do |t|
    t.bigint "table_entity_id", null: false
    t.string "name"
    t.boolean "default", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "active_filter_id"
    t.index ["active_filter_id"], name: "index_index_views_on_active_filter_id"
    t.index ["table_entity_id"], name: "index_index_views_on_table_entity_id"
  end

  create_table "table_columns", force: :cascade do |t|
    t.bigint "table_entity_id", null: false
    t.string "header"
    t.string "attribute_name"
    t.integer "position"
    t.integer "column_type", default: 0
    t.boolean "primary", default: false
    t.boolean "sr_only", default: false
    t.boolean "method_proc", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_entity_id", "position"], name: "index_table_columns_on_table_entity_id_position", unique: true
    t.index ["table_entity_id"], name: "index_table_columns_on_table_entity_id"
  end

  create_table "table_entities", force: :cascade do |t|
    t.string "model_class_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "filter_conditional_groups", "filters"
  add_foreign_key "filter_conditions", "filter_conditional_groups"
  add_foreign_key "filter_conditions", "table_columns"
  add_foreign_key "filters", "index_views"
  add_foreign_key "index_view_columns", "index_views"
  add_foreign_key "index_view_columns", "table_columns"
  add_foreign_key "index_views", "filters", column: "active_filter_id"
  add_foreign_key "index_views", "table_entities"
  add_foreign_key "table_columns", "table_entities"
  add_foreign_key "taggings", "tags"
end
