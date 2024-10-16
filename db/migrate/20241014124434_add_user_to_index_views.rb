class AddUserToIndexViews < ActiveRecord::Migration[8.0]
  def up
    add_reference :index_views, :user, foreign_key: true

    # Find or create a user
    user = User.first || User.create!(name: "John Doe", email: "john.doe@example.com", logged_in: true)

    # Update existing records
    IndexView.update_all(user_id: user.id)

    # Make the user_id non-nullable after updating existing records
    change_column_null :index_views, :user_id, false
  end

  def down
    remove_reference :index_views, :user
  end
end
