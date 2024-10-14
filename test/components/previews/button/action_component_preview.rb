# frozen_string_literal: true

class Button::ActionComponentPreview < ViewComponent::Preview
  def default
    render(Button::ActionComponent.new(path: documents_path, text: "Click me"))
  end
end
