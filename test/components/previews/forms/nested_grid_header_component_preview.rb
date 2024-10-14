# frozen_string_literal: true

class Forms::NestedGridHeaderComponentPreview < ViewComponent::Preview
  def default
    render(Forms::NestedGridHeaderComponent.new)
  end
end
