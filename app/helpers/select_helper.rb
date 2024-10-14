module SelectHelper
  def predicates_for_select
    [["eq", "eq"], ["cont", "cont"], ["gt", "gt"], ["gteq", "gteq"], ["lt", "lt"], ["lteq", "lteq"]]
  end

  def conditional_expressions_for_select
    [["all", "all_and"], ["any", "any_or"]]
  end

  def columns_for_select(table_entity_id)
    TableColumn.where(table_entity_id: table_entity_id, column_type: "standard").order(:position).map { |t| [t.attribute_name, t.id] }
  end
end
