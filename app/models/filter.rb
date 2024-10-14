# == Schema Information
#
# Table name: filters
#
#  id            :bigint           not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  index_view_id :bigint           not null
#
# Indexes
#
#  index_filters_on_index_view_id  (index_view_id)
#
# Foreign Keys
#
#  fk_rails_...  (index_view_id => index_views.id)
#
class Filter < ApplicationRecord
  belongs_to :index_view
  has_many :filter_conditional_groups, dependent: :destroy
  accepts_nested_attributes_for :filter_conditional_groups, allow_destroy: true

  validates :name, presence: true

  # Example:
  # {
  #     g: {
  #     "1": {m: "or", c: [{a: {"0": {name: "customer"}}, p: "eq", v: {"0": {value: "1"}}}]},
  #     "0": {m: "or", c: [{a: {"0": {name: "name"}}, p: "cont", v: {"0": {value: "John"}}}, {a: {"0": {name: "name"}}, p: "cont", v: {"0": {value: "Bad"}}}]}
  # }}
  #
  def ransack_groupings
    return {} if filter_conditional_groups.empty?

    groupings = {}
    filter_conditional_groups.each_with_index do |group, index|
      conditions = []
      group.filter_conditions.each do |condition|
        conditions << {a: {"0": {name: condition.table_column.attribute_name}}, p: condition.predicate, v: {"0": {value: condition.value}}}
      end
      groupings = groupings.merge({index.to_s => {m: group.ransack_mode, c: conditions}})
    end
    {g: groupings}
  end
end

# filter_filter_conditional_groups_attributes_1728657724928_filter_conditions_attributes_1728657724928_table_column_id
# filter_filter_conditional_groups_attributes_1728657724928_filter_conditions_attributes_1728657724928_table_column_id
