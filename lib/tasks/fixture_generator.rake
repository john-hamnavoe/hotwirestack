# lib/tasks/generate_index_views.rake

# bundle exec rake fixture_generator:table_entities
# bundle exec rake fixture_generator:table_columns
# bundle exec rake fixture_generator:index_views
# bundle exec rake fixture_generator:index_view_columns
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

    File.write("#{Rails.root}/test/fixtures/table_entities.yml", tables_hash.to_yaml)
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

    File.write("#{Rails.root}/test/fixtures/table_columns.yml", columns_hash.to_yaml)
  end

  task index_views: :environment do
    require "yaml"

    tables = TableEntity.all
    index_views_hash = {}

    tables.each do |table|
      model_class_name = table.model_class_name
      table_fixture_name = "table_#{model_class_name}".gsub(/\s+/, "").downcase
      index_view_fixture_name = "index_view_#{model_class_name}".gsub(/\s+/, "").downcase

      index_views_hash[index_view_fixture_name] = {
        "table_entity" => table_fixture_name,
        "name" => index_view_fixture_name,
        "default" => true
      }
    end

    puts index_views_hash.to_yaml

    File.write("#{Rails.root}/test/fixtures/index_views.yml", index_views_hash.to_yaml)
  end

  task index_view_columns: :environment do
    require "yaml"

    columns = TableColumn.all
    index_view_columns_hash = {}

    columns.each do |column|
      index_view_fixture_name = "index_view_#{column.model_class_name}".gsub(/\s+/, "").downcase
      table_column_fixture_name = "#{column.model_class_name}_column_#{column.attribute_name}".gsub(/\s+/, "").downcase
      fixture_name = "index_view_column_#{column.attribute_name}".gsub(/\s+/, "").downcase
      index_view_columns_hash[fixture_name] = {
        "index_view" => index_view_fixture_name,
        "table_column" => table_column_fixture_name,
        "position" => column.position,
        "display" => true
      }
    end

    puts index_view_columns_hash.to_yaml

    File.write("#{Rails.root}/test/fixtures/index_view_columns.yml", index_view_columns_hash.to_yaml)
  end
end
