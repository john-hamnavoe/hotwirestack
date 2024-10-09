class CreateTableEntities < ActiveRecord::Migration[8.0]
  def change
    create_table :table_entities do |t|
      t.string :model_class_name

      t.timestamps
    end
  end
end
