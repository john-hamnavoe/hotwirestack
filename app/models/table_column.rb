# == Schema Information
#
# Table name: table_columns
#
#  id              :bigint           not null, primary key
#  attribute_name  :string
#  column_type     :integer          default("standard")
#  header          :string
#  method_proc     :boolean          default(FALSE)
#  position        :integer
#  primary         :boolean          default(FALSE)
#  sr_only         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  table_entity_id :bigint           not null
#
# Indexes
#
#  index_table_columns_on_table_entity_id           (table_entity_id)
#  index_table_columns_on_table_entity_id_position  (table_entity_id,position) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (table_entity_id => table_entities.id)
#
class TableColumn < ApplicationRecord
  belongs_to :table_entity

  validates :header, presence: true
  validates :attribute_name, presence: true
  validates :position, presence: true, uniqueness: {scope: [:table_entity_id]}

  delegate :model_class_name, to: :table_entity, prefix: false

  enum :column_type, {standard: 0, action: 1}

  scope :for_model, ->(model_class_name) { joins(:table_entity).where(table_entities: {model_class_name: model_class_name}) }

  def update_attributes_defaults_if_needed(attrs)
    update!(attrs.except(:attribute_name, :position))
  end
end
