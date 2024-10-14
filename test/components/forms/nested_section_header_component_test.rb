# frozen_string_literal: true

require "test_helper"

class Forms::NestedSectionHeaderComponentTest < ViewComponent::TestCase
  def test_header_generates_correct_html
    render_inline(Forms::NestedSectionHeaderComponent.new(title: "Test Title", description: "Test Description"))

    assert_selector "h3", text: "Test Title"
    assert_selector "p", text: "Test Description"
  end
end
