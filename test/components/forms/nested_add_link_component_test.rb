# frozen_string_literal: true

require "test_helper"

class Forms::NestedAddLinkComponentTest < ViewComponent::TestCase
  def test_link_component_renders
    render_inline(Forms::NestedAddLinkComponent.new("Add"))
    assert_selector "a", text: "Add"
    assert_selector "a[href='#']"
    assert_selector "a[data-action='click->nested-form#add_association']"
  end
end
