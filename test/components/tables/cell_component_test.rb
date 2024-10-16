require "test_helper"

class Tables::CellComponentTest < ViewComponent::TestCase
  def test_renders_basic_cell
    component = Tables::CellComponent.new
    render_inline(component) { "Cell content" }

    assert_selector "td", text: "Cell content"
    assert_selector "td.whitespace-nowrap.py-1.pl-4.pr-3.text-sm.text-gray-900.sm\\:pl-0"
  end

  def test_renders_primary_cell
    component = Tables::CellComponent.new(primary: true)
    render_inline(component) { "Primary cell" }

    assert_selector "td.font-medium", text: "Primary cell"
  end

  def test_renders_sr_only_cell
    component = Tables::CellComponent.new(sr_only: true)
    render_inline(component) { "Screen reader content" }

    assert_selector "td.sr-only", text: "Screen reader content"
  end

  def test_renders_cell_with_custom_text_alignment
    component = Tables::CellComponent.new(text_align: "right")
    render_inline(component) { "Right-aligned content" }

    assert_selector "td.text-right", text: "Right-aligned content"
  end

  def test_renders_cell_with_multiple_options
    component = Tables::CellComponent.new(primary: true, text_align: "center")
    render_inline(component) { "Centered primary content" }

    assert_selector "td.font-medium.text-center", text: "Centered primary content"
  end
end
