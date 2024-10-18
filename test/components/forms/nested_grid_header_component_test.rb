# frozen_string_literal: true

require "test_helper"

class Forms::NestedGridHeaderComponentTest < ViewComponent::TestCase
  test "renders component with partial" do
    partial = "index_views/filters/filter_condition_header"
    component = Forms::NestedGridHeaderComponent.new(partial)

    render_inline(component)

    assert_selector "div.grid.grid-cols-6"
  end
end
