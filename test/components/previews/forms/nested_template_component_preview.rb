# frozen_string_literal: true

class Forms::NestedTemplateComponentPreview < ViewComponent::Preview
  def default
    render(Forms::NestedTemplateComponent.new)
  end
end
