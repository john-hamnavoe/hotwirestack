# frozen_string_literal: true

require "test_helper"

class Forms::ButtonSubmitComponentTest < ViewComponent::TestCase
  def test_renders_button_with_default_text
    render_inline(Forms::ButtonSubmitComponent.new)

    assert_selector("button[type='submit']", text: I18n.t("buttons.submit"))
  end

  def test_renders_button_with_custom_text
    render_inline(Forms::ButtonSubmitComponent.new(text: "Custom Submit"))

    assert_selector("button[type='submit']", text: "Custom Submit")
  end

  def test_renders_button_with_default_width
    render_inline(Forms::ButtonSubmitComponent.new)

    assert_selector("button.w-auto")
  end

  def test_renders_button_with_custom_width
    render_inline(Forms::ButtonSubmitComponent.new(width: "w-full"))

    assert_selector("button.w-full")
  end

  def test_renders_button_with_custom_data_attributes
    render_inline(Forms::ButtonSubmitComponent.new(data: {turbo: false}))

    assert_selector("button[data-turbo='false']")
  end
end
