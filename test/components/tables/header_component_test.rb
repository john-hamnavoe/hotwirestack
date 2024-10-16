require "test_helper"

class Tables::HeaderComponentTest < ViewComponent::TestCase
  def test_renders_with_title
    component = Tables::HeaderComponent.new("Test Title")
    render_inline(component)

    assert_selector "th", text: "Test Title"
    assert_selector "th[scope='col']"
    assert_selector "th.py-1\\.5.pl-4.pr-3.text-left.text-sm.font-semibold.text-gray-900.sm\\:pl-0"
  end

  def test_renders_with_content
    component = Tables::HeaderComponent.new
    render_inline(component) { "Content Title" }

    assert_selector "th", text: "Content Title"
  end

  def test_renders_with_sr_only_class
    component = Tables::HeaderComponent.new("SR Only Title", sr_only: true)
    render_inline(component)

    assert_selector "th.sr-only", text: "SR Only Title"
  end

  def test_renders_without_sr_only_class
    component = Tables::HeaderComponent.new("Regular Title", sr_only: false)
    render_inline(component)

    assert_selector "th", text: "Regular Title"
    refute_selector "th.sr-only"
  end

  def test_renders_with_default_classes
    component = Tables::HeaderComponent.new("Default Classes")
    render_inline(component)

    assert_selector "th.py-1\\.5.pl-4.pr-3.text-left.text-sm.font-semibold.text-gray-900.sm\\:pl-0"
  end
end
