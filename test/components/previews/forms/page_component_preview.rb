# frozen_string_literal: true

class Forms::PageComponentPreview < ViewComponent::Preview
  def default
    render(Forms::PageComponent.new)
  end
end
