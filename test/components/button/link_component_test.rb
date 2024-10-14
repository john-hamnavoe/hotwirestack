# frozen_string_literal: true

require "test_helper"

class Button::LinkComponentTest < ViewComponent::TestCase
  def test_component_renders_link
    render_inline(Button::LinkComponent.new(text: "Link", path: "#"))

    assert_text "Link"
    assert_selector "a[href='#']"
  end
end
