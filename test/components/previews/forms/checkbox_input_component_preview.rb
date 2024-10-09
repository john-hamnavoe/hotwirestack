# frozen_string_literal: true

class Forms::CheckboxInputComponentPreview < ViewComponent::Preview
  def default
    render(Forms::CheckboxInputComponent.new)
  end
end
