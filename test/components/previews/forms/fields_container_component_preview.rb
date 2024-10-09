# frozen_string_literal: true

class Forms::FieldsContainerComponentPreview < ViewComponent::Preview
  def default
    render(Forms::FieldsContainerComponent.new)
  end
end
