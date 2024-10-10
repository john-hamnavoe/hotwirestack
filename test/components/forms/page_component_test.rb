# frozen_string_literal: true

require "test_helper"

class Forms::PageComponentTest < ViewComponent::TestCase
  def test_renders_page
    model = Document.new(title: "Test")
    component = Forms::PageComponent.new(title: "Test", description: "This is a test page", model: model)
    render_inline(component)

    assert_selector "div", class: "bg-white"
    assert_selector "h1", text: "Test"
    assert_selector "h2", text: "This is a test page"
  end
end
