# frozen_string_literal: true

require "test_helper"

class Forms::ButtonCancelComponentTest < ViewComponent::TestCase
  def test_renders_cancel_button_with_default_title
    component = Forms::ButtonCancelComponent.new("/path")
    render_inline(component)

    assert_selector "a[href='/path']", text: I18n.t("buttons.cancel")
    assert_selector "a.w-auto.text-sm.font-semibold.leading-6.text-gray-900"
  end

  def test_renders_cancel_button_with_custom_title
    component = Forms::ButtonCancelComponent.new("/custom", "Custom Cancel")
    render_inline(component)

    assert_selector "a[href='/custom']", text: "Custom Cancel"
  end

  def test_renders_cancel_button_with_custom_width
    component = Forms::ButtonCancelComponent.new("/path", width: "w-full")
    render_inline(component)

    assert_selector "a.w-full"
  end

  def test_renders_cancel_button_with_custom_data_attributes
    component = Forms::ButtonCancelComponent.new("/path", data: {turbo: false})
    render_inline(component)

    assert_selector "a[data-turbo='false']"
  end

  def test_renders_cancel_button_with_correct_type
    component = Forms::ButtonCancelComponent.new("/path")
    render_inline(component)

    assert_selector "a[type='button']"
  end
end
