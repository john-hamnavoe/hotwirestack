# frozen_string_literal: true

class Forms::NestedSectionComponentPreview < ViewComponent::Preview
  def default
    render(Forms::NestedSectionComponent.new)
  end
end
