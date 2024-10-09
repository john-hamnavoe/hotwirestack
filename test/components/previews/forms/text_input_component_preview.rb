# frozen_string_literal: true

class Forms::TextInputComponentPreview < ViewComponent::Preview
  def default
    render(Forms::TextInputComponent.new)
  end
end
