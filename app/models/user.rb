# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  logged_in  :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :index_views

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "logged_in", "name", "updated_at"]
  end
end
