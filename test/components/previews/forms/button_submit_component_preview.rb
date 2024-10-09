# frozen_string_literal: true

class Forms::ButtonSubmitComponentPreview < ViewComponent::Preview
  def default
    render(Forms::ButtonSubmitComponent.new)
  end
end
