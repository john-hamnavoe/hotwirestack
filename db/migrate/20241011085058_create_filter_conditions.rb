class CreateFilterConditions < ActiveRecord::Migration[8.0]
  def change
    create_table :filter_conditions do |t|
      t.references :filter_conditional_group, null: false, foreign_key: true
      t.references :table_column, null: false, foreign_key: true
      t.string :predicate
      t.string :value

      t.timestamps
    end
  end
end
