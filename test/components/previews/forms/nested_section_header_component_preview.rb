# frozen_string_literal: true

class Forms::NestedSectionHeaderComponentPreview < ViewComponent::Preview
  def default
    render(Forms::NestedSectionHeaderComponent.new)
  end
end
