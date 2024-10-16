# frozen_string_literal: true

require "test_helper"

class Header::DesktopMenuComponentTest < ViewComponent::TestCase
  def test_component_renders_with_current_path
    current_path = "/"
    render_inline(Header::DesktopMenuComponent.new(current_path: current_path))

    assert_selector "a[href='/documents']"
  end
end
