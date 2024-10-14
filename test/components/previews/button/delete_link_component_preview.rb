# frozen_string_literal: true

class Button::DeleteLinkComponentPreview < ViewComponent::Preview
  def default
    render(Button::DeleteLinkComponent.new)
  end
end
