# frozen_string_literal: true

require "test_helper"

class Button::DeleteLinkComponentTest < ViewComponent::TestCase
  def test_component_renders_delete_link
    render_inline(Button::DeleteLinkComponent.new(text: "Delete", path: "#"))

    assert_text "Delete"
    assert_selector "a[href='#']"
  end
end
