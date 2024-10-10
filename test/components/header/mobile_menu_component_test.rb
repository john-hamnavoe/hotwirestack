# frozen_string_literal: true

require "test_helper"

class Header::MobileMenuComponentTest < ViewComponent::TestCase
  def test_renders_something_useful
    current_path = "/"
    render_inline(Header::MobileMenuComponent.new(current_path: current_path))

    assert_selector "a[href='/documents']"
    assert_selector "a[href='/about/index']"
  end
end
