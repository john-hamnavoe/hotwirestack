# frozen_string_literal: true

require "test_helper"

class Header::DropdownComponentTest < ViewComponent::TestCase
  def test_component_renders_something
    title = "Menu"
    items = [{title: "Item 1", description: "Item 1 description", path: "/"}, {title: "Item 2", description: "Item 2 description", path: "/about"}]
    mobile = false

    component = Header::DropdownComponent.new(title: title, items: items, mobile: mobile)
    render_inline(component)

    assert_text title
    assert_text "Item 1"
    assert_text "Item 2"
    assert_text "Item 1 description"
    assert_text "Item 2 description"
    assert_selector "a[href='/']"
    assert_selector "a[href='/about']"
  end
end
