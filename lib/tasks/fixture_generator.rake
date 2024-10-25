# lib/tasks/generate_index_views.rake

# bundle exec rake fixture_generator:table_entities
# bundle exec rake fixture_generator:table_columns
# bundle exec rake fixture_generator:index_views
# bundle exec rake fixture_generator:index_view_columns
# bundle exec rake fixture_generator:filters
# bundle exec rake fixture_generator:active_filters
namespace :fixture_generator do
  task table_entities: :environment do
    require "yaml"

    tables = TableEntity.all
    tables_hash = {}

    tables.each do |table|
      model_class_name = table.model_class_name
      fixture_name = "table_#{model_class_name}".gsub(/\s+/, "").downcase

      tables_hash[fixture_name] = {
        "model_class_name" => model_class_name
      }
    end

    puts tables_hash.to_yaml

    File.write(Rails.root.join("test/fixtures/table_entities.yml").to_s, tables_hash.to_yaml)
  end

  task table_columns: :environment do
    require "yaml"

    columns = TableColumn.includes(:table_entity).all
    columns_hash = {}

    columns.each do |column|
      table_reference = "table_#{column.model_class_name}".gsub(/\s+/, "").downcase
      attribute_name = column.attribute_name
      fixture_name = "#{column.model_class_name}_column_#{attribute_name}".gsub(/\s+/, "").downcase

      columns_hash[fixture_name] = {
        "table_entity" => table_reference,
        "attribute_name" => attribute_name,
        "header" => column.header,
        "position" => column.position,
        "column_type" => column.column_type,
        "primary" => column.primary,
        "sr_only" => column.sr_only,
        "method_proc" => column.method_proc
      }
    end

    puts columns_hash.to_yaml

    File.write(Rails.root.join("test/fixtures/table_columns.yml").to_s, columns_hash.to_yaml)
  end

  task index_views: :environment do
    require "yaml"

    tables = TableEntity.all
    index_views_hash = {}

    tables.each do |table|
      ["one", "two"].each do |user|
        ["all", "active_only"].each do |scope|
          model_class_name = table.model_class_name
          table_fixture_name = "table_#{model_class_name}".gsub(/\s+/, "").downcase
          index_view_fixture_name = "index_view_#{model_class_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase

          index_views_hash[index_view_fixture_name] = {
            "table_entity" => table_fixture_name,
            "name" => scope.titleize,
            "default" => scope == "all",
            "user" => user
          }
        end
      end
    end

    puts index_views_hash.to_yaml

    File.write(Rails.root.join("test/fixtures/index_views.yml").to_s, index_views_hash.to_yaml)
  end

  task index_view_columns: :environment do
    require "yaml"

    columns = TableColumn.all
    index_view_columns_hash = {}

    columns.each do |column|
      ["one", "two"].each do |user|
        ["all", "active_only"].each do |scope|
          index_view_fixture_name = "index_view_#{column.model_class_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase
          table_column_fixture_name = "#{column.model_class_name}_column_#{column.attribute_name}".gsub(/\s+/, "").downcase
          fixture_name = "index_view_column_#{column.model_class_name}_#{column.attribute_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase
          index_view_columns_hash[fixture_name] = {
            "index_view" => index_view_fixture_name,
            "table_column" => table_column_fixture_name,
            "position" => column.position,
            "display" => true
          }
        end
      end
    end

    puts index_view_columns_hash.to_yaml

    File.write(Rails.root.join("test/fixtures/index_view_columns.yml").to_s, index_view_columns_hash.to_yaml)
  end

  task filters: :environment do
    require "yaml"

    tables = TableEntity.all
    filters_hash = {}

    tables.each do |table|
      ["one", "two"].each do |user|
        ["all", "active_only"].each do |scope|
          model_class_name = table.model_class_name
          index_view_fixture_name = "index_view_#{model_class_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase
          filter_fixture_name = "filter_#{model_class_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase

          filters_hash[filter_fixture_name] = {
            "index_view" => index_view_fixture_name,
            "name" => filter_fixture_name
          }
        end
      end
    end

    puts filters_hash.to_yaml

    File.write(Rails.root.join("test/fixtures/filters.yml").to_s, filters_hash.to_yaml)
  end

  task active_filters: :environment do
    require "yaml"

    tables = TableEntity.where(id: TableColumn.where(attribute_name: "active").select(:table_entity_id))
    filter_conditional_group_hash = {}
    filter_condition_hash = {}
    tables.each do |table|
      ["one", "two"].each do |user|
        ["active_only"].each do |scope|
          model_class_name = table.model_class_name
          filter_fixture_name = "filter_#{model_class_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase
          filter_conditional_group_fixture_name = "filter_group_#{model_class_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase
          filter_condition_fixture_name = "filter_condition_#{model_class_name}_#{user}_#{scope}".gsub(/\s+/, "").downcase

          filter_conditional_group_hash[filter_conditional_group_fixture_name] = {
            "filter" => filter_fixture_name,
            "conditional_expression" => 0
          }

          filter_condition_hash[filter_condition_fixture_name] = {
            "filter_conditional_group" => filter_conditional_group_fixture_name,
            "table_column" => "#{model_class_name}_column_active".downcase,
            "predicate" => "eq",
            "value" => "true"
          }
        end
      end
    end

    puts filter_conditional_group_hash.to_yaml
    puts filter_condition_hash.to_yaml
    File.write(Rails.root.join("test/fixtures/filter_conditional_groups.yml").to_s, filter_conditional_group_hash.to_yaml)
    File.write(Rails.root.join("test/fixtures/filter_conditions.yml").to_s, filter_condition_hash.to_yaml)
  end
end
