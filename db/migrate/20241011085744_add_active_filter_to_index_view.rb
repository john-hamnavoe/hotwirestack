class AddActiveFilterToIndexView < ActiveRecord::Migration[8.0]
  def change
    add_reference :index_views, :active_filter, null: true, foreign_key: {to_table: :filters}
  end
end
