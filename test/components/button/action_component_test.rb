# frozen_string_literal: true

require "test_helper"

class Button::ActionComponentTest < ViewComponent::TestCase
  def test_renders_button_with_default_attributes
    render_inline(Button::ActionComponent.new(text: "Click me", path: "/documents"))

    assert_selector "a", text: "Click me"
    assert_selector "a[href='/documents']"
  end
end
