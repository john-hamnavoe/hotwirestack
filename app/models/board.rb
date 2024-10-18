# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_boards_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Board < ApplicationRecord
  include HasTableConfiguration

  belongs_to :owner, class_name: "User"

  validates :name, presence: true

  delegate :name, to: :owner, prefix: true

  def self.ransackable_attributes(auth_object = nil)
    ["active", "created_at", "id", "name", "owner_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["owner"]
  end

  set_default_table_columns(
    {header: "Name", attribute_name: "name", primary: true},
    {header: "Active", attribute_name: "active", method_proc: true},
    {header: "Owner", attribute_name: "owner_name"},
    {header: "Edit", attribute_name: "edit", column_type: :action, sr_only: true},
    {header: "Delete", attribute_name: "delete", column_type: :action, sr_only: true},
    {header: "Open", attribute_name: "open", column_type: :action, sr_only: true}
  )
end
