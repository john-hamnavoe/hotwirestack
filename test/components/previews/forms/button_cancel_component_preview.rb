# frozen_string_literal: true

class Forms::ButtonCancelComponentPreview < ViewComponent::Preview
  def default
    render(Forms::ButtonCancelComponent.new)
  end
end
