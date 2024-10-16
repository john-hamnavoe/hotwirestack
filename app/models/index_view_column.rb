# == Schema Information
#
# Table name: index_view_columns
#
#  id              :bigint           not null, primary key
#  display         :boolean          default(TRUE)
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  index_view_id   :bigint           not null
#  table_column_id :bigint           not null
#
# Indexes
#
#  index_index_view_columns_on_index_view_id    (index_view_id)
#  index_index_view_columns_on_table_column_id  (table_column_id)
#
# Foreign Keys
#
#  fk_rails_...  (index_view_id => index_views.id)
#  fk_rails_...  (table_column_id => table_columns.id)
#
class IndexViewColumn < ApplicationRecord
  belongs_to :index_view
  belongs_to :table_column

  acts_as_list scope: [:index_view_id, :display]

  delegate :header, :attribute_name, :column_type, :method_proc, :primary, :sr_only, to: :table_column, prefix: true
  delegate :model_class_name, to: :table_column, prefix: false

  scope :displayed, -> { includes(:table_column).where(display: true).order(:position) }
  scope :hidden, -> { includes(:table_column).where(display: false).order(:position) }

  def to_column_hash
    {
      model_class_name: model_class_name,
      header: table_column_header,
      attribute_name: table_column_attribute_name.to_sym,
      type: table_column_column_type.to_sym,
      primary: table_column_primary,
      sr_only: table_column_sr_only,
      method: table_column_method_proc
    }
  end
end
