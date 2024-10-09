class CreateIndexViewColumns < ActiveRecord::Migration[8.0]
  def change
    create_table :index_view_columns do |t|
      t.references :index_view, null: false, foreign_key: true
      t.references :table_column, null: false, foreign_key: true
      t.integer :position
      t.boolean :display, default: true

      t.timestamps
    end
  end
end
