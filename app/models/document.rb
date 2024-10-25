# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Document < ApplicationRecord
  include HasTableConfiguration

  has_many :fragments, dependent: :destroy
  acts_as_taggable_on :tags

  def self.ransackable_attributes(auth_object = nil)
    ["active", "created_at", "id", "title", "updated_at"]
  end

  validates :title, presence: true

  set_default_table_columns(
    {header: "Title", attribute_name: "title", primary: true},
    {header: "Active", attribute_name: "active", method_proc: true},
    {header: "Edit", attribute_name: "edit", column_type: :action, sr_only: true},
    {header: "Delete", attribute_name: "delete", column_type: :action, sr_only: true},
    {header: "Open", attribute_name: "open", column_type: :action, sr_only: true}
  )
end
