# frozen_string_literal: true

require "test_helper"

class Forms::FieldsContainerComponentTest < ViewComponent::TestCase
  def test_renders_fields_container
    render_inline(Forms::FieldsContainerComponent.new(model: Document.new))

    assert_selector "div", count: 2
  end
end
