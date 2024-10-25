# frozen_string_literal: true

require "test_helper"

class Forms::ErrorMessageComponentTest < ViewComponent::TestCase
  def test_component_renders_nothing_when_model_has_no_errors
    model = Document.new(title: "Test")
    component = Forms::ErrorMessageComponent.new(model)

    render_inline(component)

    assert_no_selector "div", id: "error_explanation"
  end

  def test_component_renders_error_messages_when_model_has_errors
    model = Document.new(title: nil)
    model.save
    component = Forms::ErrorMessageComponent.new(model)

    render_inline(component)

    assert_selector "div", id: "error_explanation"
    assert_selector "ul", count: 1
    assert_selector "li", text: "Title can't be blank"
  end
end
