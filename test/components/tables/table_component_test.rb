require "test_helper"

class Tables::TableComponentTest < ViewComponent::TestCase
  def test_renders_table
    component = Tables::TableComponent.new
    render_inline(component)

    assert_selector "table.min-w-full.divide-y.divide-gray-300"
  end

  def test_renders_headers
    component = Tables::TableComponent.new
    component.with_header { "Header 1" }
    component.with_header { "Header 2" }
    render_inline(component)

    assert_selector "table" do
      assert_selector "thead" do
        assert_selector "tr" do
          assert_selector "th", count: 2
          assert_selector "th", text: "Header 1"
          assert_selector "th", text: "Header 2"
        end
      end
    end
  end
end
