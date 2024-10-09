# frozen_string_literal: true

class Forms::FooterComponentPreview < ViewComponent::Preview
  def default
    render(Forms::FooterComponent.new)
  end
end
