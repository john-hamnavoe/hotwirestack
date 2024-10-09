class CreateIndexViews < ActiveRecord::Migration[8.0]
  def change
    create_table :index_views do |t|
      t.references :table_entity, null: false, foreign_key: true
      t.string :name
      t.boolean :default, default: true

      t.timestamps
    end
  end
end
