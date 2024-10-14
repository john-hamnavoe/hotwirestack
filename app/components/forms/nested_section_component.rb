# frozen_string_literal: true

class Forms::NestedSectionComponent < ApplicationComponent
  private attr_reader :sortable_id_prefix, :template_name
  renders_one :header, Forms::NestedSectionHeaderComponent
  renders_one :template, Forms::NestedTemplateComponent
  renders_one :grid_header, Forms::NestedGridHeaderComponent
  renders_one :add_link, Forms::NestedAddLinkComponent

  def initialize(sortable_id_prefix: nil, template_name: "NEW_RECORD")
    @sortable_id_prefix = sortable_id_prefix
    @template_name = template_name
  end

  def data
    {controller: "nested-form", nested_form_template_name_value: template_name}
  end

  def sortable?
    sortable_id_prefix.present?
  end
end
