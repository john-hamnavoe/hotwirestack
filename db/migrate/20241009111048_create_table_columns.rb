class CreateTableColumns < ActiveRecord::Migration[8.0]
  def change
    create_table :table_columns do |t|
      t.references :table_entity, null: false, foreign_key: true
      t.string :header
      t.string :attribute_name
      t.integer :position
      t.integer :column_type, default: 0
      t.boolean :primary, default: false
      t.boolean :sr_only, default: false
      t.boolean :method_proc, default: false

      t.timestamps
    end

    add_index :table_columns, [:table_entity_id, :position], unique: true, name: "index_table_columns_on_table_entity_id_position"
  end
end
