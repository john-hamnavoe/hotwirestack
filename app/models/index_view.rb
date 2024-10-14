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
#
# Indexes
#
#  index_index_views_on_active_filter_id  (active_filter_id)
#  index_index_views_on_table_entity_id   (table_entity_id)
#
# Foreign Keys
#
#  fk_rails_...  (active_filter_id => filters.id)
#  fk_rails_...  (table_entity_id => table_entities.id)
#
class IndexView < ApplicationRecord
  belongs_to :table_entity
  belongs_to :active_filter, class_name: "Filter", optional: true
  has_many :filters, dependent: :destroy
  has_many :index_view_columns, dependent: :destroy
  has_many :displayed_index_view_columns, -> { displayed.order(:position) }, class_name: "IndexViewColumn"
  has_many :hidden_index_view_columns, -> { hidden.order(:position) }, class_name: "IndexViewColumn"
  accepts_nested_attributes_for :index_view_columns, allow_destroy: true

  delegate :model_class_name, to: :table_entity, prefix: true

  def filter_conditions
    return {} unless active_filter

    active_filter.ransack_groupings
  end

  def displayed_columns
    index_view_columns.displayed.map do |column|
      {
        model_class_name: table_entity_model_class_name,
        header: column.table_column_header,
        attribute_name: column.table_column_attribute_name.to_sym,
        type: column.table_column_column_type.to_sym,
        primary: column.table_column_primary,
        sr_only: column.table_column_sr_only,
        method: column.table_column_method_proc
      }
    end
  end

  def create_default_columns
    max_position = index_view_columns.maximum(:position) || 0
    table_entity.table_columns.order(:position).each_with_index do |table_column, index|
      index_view_columns.find_or_create_by(table_column: table_column) do |index_view_column|
        index_view_column.position = index + max_position + 1
      end
    end
  end

  class << self
    def create_default_views
      TableEntity.all.each do |table_entity|
        index_view = find_or_create_by(default: true, table_entity: table_entity) do |index_view|
          index_view.name = "Default view for #{table_entity.model_class_name.downcase.pluralize}"
        end

        index_view.create_default_columns
      end
    end
  end
end
