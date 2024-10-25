# frozen_string_literal: true

require "test_helper"

class Header::LogoComponentTest < ViewComponent::TestCase
  def test_render_logo_component
    render_inline(Header::LogoComponent.new)

    assert_selector "div", class: "flex lg:flex-1"
    assert_selector "img", class: "h-8 w-auto"
    assert_selector "a[href='/']"
  end
end
