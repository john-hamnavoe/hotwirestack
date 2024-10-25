module HasTableConfiguration
  extend ActiveSupport::Concern

  included do
    class_attribute :default_table_columns
  end

  class_methods do
    def table_entity
      @table_entity ||= TableEntity.find_or_create_by(model_class_name: name)
    end

    def table_columns
      TableColumn.for_model(name).order(:position)
    end

    def set_default_table_columns(*columns)
      self.default_table_columns = columns
    end

    def create_or_update_default_table_columns!
      existing_columns = table_columns.index_by(&:attribute_name)
      max_position = table_columns.maximum(:position) || 0

      handle_columns(existing_columns, max_position)
    end

    private

    def handle_columns(existing_columns, max_position)
      update_existing_columns(existing_columns)
      create_new_columns(existing_columns, max_position)
      remove_unused_columns
    end

    def update_existing_columns(existing_columns)
      default_table_columns.each do |column_attrs|
        attribute_name = column_attrs[:attribute_name]
        existing_column = existing_columns[attribute_name]
        existing_column&.update_attributes_defaults_if_needed(column_attrs)
      end
    end

    def create_new_columns(existing_columns, max_position)
      default_table_columns.each_with_index do |column_attrs, index|
        next if existing_columns[column_attrs[:attribute_name]]

        table_columns.create!(
          table_entity: table_entity,
          **column_attrs.merge(position: max_position + index + 1)
        )
      end
    end

    def remove_unused_columns
      default_attributes = default_table_columns.pluck(:attribute_name)
      table_columns.where.not(attribute_name: default_attributes).destroy_all
    end
  end
end
