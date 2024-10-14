# == Schema Information
#
# Table name: filter_conditional_groups
#
#  id                     :bigint           not null, primary key
#  conditional_expression :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  filter_id              :bigint           not null
#
# Indexes
#
#  index_filter_conditional_groups_on_filter_id  (filter_id)
#
# Foreign Keys
#
#  fk_rails_...  (filter_id => filters.id)
#
class FilterConditionalGroup < ApplicationRecord
  belongs_to :filter

  has_many :filter_conditions, dependent: :destroy
  accepts_nested_attributes_for :filter_conditions, allow_destroy: true

  enum :conditional_expression, {all_and: 0, any_or: 1} # can't just use any because of rails keyword restrictions

  def conditional_expression_title
    I18n.t("enums.filter_conditional_group.conditional_expression.#{conditional_expression}")
  end

  def ransack_mode
    (conditional_expression == "any_or") ? "or" : "and"
  end
end
