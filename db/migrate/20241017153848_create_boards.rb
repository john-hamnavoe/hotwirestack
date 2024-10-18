class CreateBoards < ActiveRecord::Migration[8.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
