# frozen_string_literal: true

require "test_helper"

class Button::DeleteComponentTest < ViewComponent::TestCase
  def test_component_renders_delete_button
    render_inline(Button::DeleteComponent.new(text: "Delete", path: "/documents/1"))

    assert_selector "button", text: "Delete"
    assert_selector "button[data-turbo-confirm='Are you sure you want to delete this?']"
  end
end
