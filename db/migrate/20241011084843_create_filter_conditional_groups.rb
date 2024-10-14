class CreateFilterConditionalGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :filter_conditional_groups do |t|
      t.references :filter, null: false, foreign_key: true
      t.integer :conditional_expression

      t.timestamps
    end
  end
end
