# frozen_string_literal: true

class Button::DeleteComponentPreview < ViewComponent::Preview
  def default
    render(Button::DeleteComponent.new)
  end
end
