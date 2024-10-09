class Document < ApplicationRecord
  acts_as_taggable_on :tags

  def self.ransackable_attributes(auth_object = nil)
    ["active", "created_at", "id", "title", "updated_at"]
  end

  validates :title, presence: true
end
