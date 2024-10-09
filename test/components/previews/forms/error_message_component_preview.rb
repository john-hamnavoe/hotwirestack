# frozen_string_literal: true

class Forms::ErrorMessageComponentPreview < ViewComponent::Preview
  def default
    render(Forms::ErrorMessageComponent.new)
  end
end
