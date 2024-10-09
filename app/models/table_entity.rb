# == Schema Information
#
# Table name: table_entities
#
#  id               :bigint           not null, primary key
#  model_class_name :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class TableEntity < ApplicationRecord
  has_many :table_columns, dependent: :destroy
  has_many :index_views, dependent: :destroy
end
