# frozen_string_literal: true

class Forms::FieldComponentPreview < ViewComponent::Preview
  def default
    render(Forms::FieldComponent.new)
  end
end
