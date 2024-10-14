# frozen_string_literal: true

class Forms::NestedTemplateComponent < ApplicationComponent
  private attr_reader :template_object, :field, :partial, :form, :locals, :template_name
  def initialize(form, field, template_object, partial, locals = {}, template_name = "NEW_RECORD")
    @form = form
    @template_object = template_object
    @field = field
    @partial = partial
    @template_name = template_name
    @locals = locals
  end

  def name
    "#{field}_template"
  end
end
