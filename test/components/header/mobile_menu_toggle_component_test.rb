# frozen_string_literal: true

require "test_helper"

class Header::MobileMenuToggleComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    render_inline(Header::MobileMenuToggleComponent.new)

    assert_selector "button[data-action='dropdown#toggle:stop']"
    assert_selector "svg[class='h-6 w-6']"
    assert_selector "div", class: "lg:hidden"
  end
end
