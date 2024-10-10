# frozen_string_literal: true

require "test_helper"

class Forms::LabelComponentTest < ViewComponent::TestCase
  def test_renders_label_with_default_options
    component = Forms::LabelComponent.new(title: "Username")
    render_inline(component)

    assert_selector "label", text: "Username"
    assert_selector "label.block.font-medium.leading-6.text-gray-700.text-sm"
  end

  def test_renders_label_with_custom_classes
    component = Forms::LabelComponent.new(title: "Email", classes: "custom-class")
    render_inline(component)

    assert_selector "label", text: "Email"
    assert_selector "label.custom-class.block.font-medium.leading-6.text-gray-700.text-sm"
  end

  def test_renders_large_label
    component = Forms::LabelComponent.new(title: "Password", large: true)
    render_inline(component)

    assert_selector "label", text: "Password"
    assert_selector "label.block.font-medium.leading-6.text-gray-700.text-lg"
  end
end
