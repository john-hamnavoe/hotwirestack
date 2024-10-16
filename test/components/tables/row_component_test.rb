# frozen_string_literal: true

require "test_helper"

class Tables::RowComponentTest < ViewComponent::TestCase
  def test_component_renders_empty_row
    component = Tables::RowComponent.new
    render_inline(component)

    assert_selector "tr", count: 1
  end

  def test_component_renders_with_single_cell
    component = Tables::RowComponent.new
    render_inline(component) do |c|
      c.with_cell { "Cell 1" }
    end

    assert_selector "tr", count: 1
    assert_selector "tr td", count: 1
    assert_selector "tr td", text: "Cell 1"
  end

  def test_component_renders_with_multiple_cells
    component = Tables::RowComponent.new
    render_inline(component) do |c|
      c.with_cell { "Cell 1" }
      c.with_cell { "Cell 2" }
      c.with_cell { "Cell 3" }
    end

    assert_selector "tr", count: 1
    assert_selector "tr td", count: 3
    assert_selector "tr td", text: "Cell 1"
    assert_selector "tr td", text: "Cell 2"
    assert_selector "tr td", text: "Cell 3"
  end

  def test_component_renders_cells_with_content
    component = Tables::RowComponent.new
    render_inline(component) do |c|
      c.with_cell { "<span>Custom Content</span>".html_safe }
    end

    assert_selector "tr td span", text: "Custom Content"
  end
end
