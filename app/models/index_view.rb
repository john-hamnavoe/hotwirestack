# == Schema Information
#
# Table name: index_views
#
#  id               :bigint           not null, primary key
#  default          :boolean          default(TRUE)
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  active_filter_id :bigint
#  table_entity_id  :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_index_views_on_active_filter_id  (active_filter_id)
#  index_index_views_on_table_entity_id   (table_entity_id)
#  index_index_views_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (active_filter_id => filters.id)
#  fk_rails_...  (table_entity_id => table_entities.id)
#  fk_rails_...  (user_id => users.id)
#
require "csv"
class IndexView < ApplicationRecord
  belongs_to :table_entity
  belongs_to :user
  before_destroy :clear_active_filter # must be defined before belongs_to :active_filter
  belongs_to :active_filter, class_name: "Filter", optional: true
  has_many :filters, dependent: :destroy
  has_many :index_view_columns, dependent: :destroy
  has_many :displayed_index_view_columns, -> { displayed.order(:position) }, class_name: "IndexViewColumn"
  has_many :hidden_index_view_columns, -> { hidden.order(:position) }, class_name: "IndexViewColumn"
  accepts_nested_attributes_for :index_view_columns, allow_destroy: true

  delegate :model_class_name, to: :table_entity, prefix: true

  validates :name, presence: true
  before_destroy :prevent_destroy_if_default, prepend: true

  after_create_commit :create_default_columns

  def filter_conditions
    return {} unless active_filter

    active_filter.ransack_groupings
  end

  def displayed_columns
    index_view_columns.displayed.map(&:to_column_hash)
  end

  def create_default_columns
    max_position = index_view_columns.maximum(:position) || 0
    table_entity.table_columns.order(:position).each_with_index do |table_column, index|
      index_view_columns.find_or_create_by(table_column: table_column) do |index_view_column|
        index_view_column.position = index + max_position + 1
      end
    end
  end

  def generate_csv(collection)
    export_columns = displayed_index_view_columns.where(table_column: {column_type: :standard})

    CSV.generate do |csv|
      csv << export_columns.map(&:table_column_header)
      collection.each do |item|
        csv << export_columns.map { |column| item.send(column.table_column_attribute_name) }
      end
    end
  end

  private

  def prevent_destroy_if_default
    if default?
      errors.add(:base, "Cannot delete a default record.")
      throw(:abort)
    end
  end

  def clear_active_filter
    update(active_filter: nil)
  end

  class << self
    def create_default_views
      User.all.each do |user|
        create_default_views_for_user(user)
      end
    end

    def create_default_views_for_user(user)
      TableEntity.all.each do |table_entity|
        index_view = find_or_create_by(default: true, table_entity: table_entity, user: user) do |index_view|
          index_view.name = "Default view"
        end

        index_view.create_default_columns
      end
    end
  end
end
