# == Schema Information
#
# Table name: filter_conditions
#
#  id                          :bigint           not null, primary key
#  predicate                   :string
#  value                       :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  filter_conditional_group_id :bigint           not null
#  table_column_id             :bigint           not null
#
# Indexes
#
#  index_filter_conditions_on_filter_conditional_group_id  (filter_conditional_group_id)
#  index_filter_conditions_on_table_column_id              (table_column_id)
#
# Foreign Keys
#
#  fk_rails_...  (filter_conditional_group_id => filter_conditional_groups.id)
#  fk_rails_...  (table_column_id => table_columns.id)
#
class FilterCondition < ApplicationRecord
  belongs_to :filter_conditional_group
  belongs_to :table_column
end
