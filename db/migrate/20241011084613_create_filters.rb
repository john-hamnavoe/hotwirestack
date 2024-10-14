class CreateFilters < ActiveRecord::Migration[8.0]
  def change
    create_table :filters do |t|
      t.string :name
      t.references :index_view, null: false, foreign_key: true

      t.timestamps
    end
  end
end
