# frozen_string_literal: true

class Forms::NestedAddLinkComponentPreview < ViewComponent::Preview
  def default
    render(Forms::NestedAddLinkComponent.new)
  end
end
