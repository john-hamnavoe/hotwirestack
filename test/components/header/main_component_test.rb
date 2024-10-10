# frozen_string_literal: true

require "test_helper"

class Header::MainComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    current_path = "/"
    render_inline(Header::MainComponent.new(current_path: current_path))
    assert_selector "a[href='/documents']"
    assert_selector "a[href='/about/index']"
  end
end
