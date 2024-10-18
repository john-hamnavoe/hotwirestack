# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(name: "John Doe", email: "john.doe@example.com", logged_in: true) unless User.exists?(email: "john.doe@example.com")
User.create!(name: "Jane Doe", email: "jane.doe@example.com", logged_in: false) unless User.exists?(email: "jane.doe@example.com")

Document.create_or_update_default_table_columns!
Board.create_or_update_default_table_columns!
IndexView.create_default_views
