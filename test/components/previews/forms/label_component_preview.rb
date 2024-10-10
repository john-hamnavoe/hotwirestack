# frozen_string_literal: true

class Forms::LabelComponentPreview < ViewComponent::Preview
  def default
    render(Forms::LabelComponent.new)
  end
end
