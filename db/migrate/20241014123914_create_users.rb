class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :logged_in, default: false

      t.timestamps
    end
  end
end
