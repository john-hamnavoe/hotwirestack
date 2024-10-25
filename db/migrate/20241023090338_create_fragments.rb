class CreateFragments < ActiveRecord::Migration[8.0]
  def change
    create_table :fragments do |t|
      t.references :document, null: false, foreign_key: true
      t.string :element
      t.string :data
      t.integer :position
      t.string :meta

      t.timestamps
    end
  end
end
