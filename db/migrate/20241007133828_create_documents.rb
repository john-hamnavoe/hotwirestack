class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
