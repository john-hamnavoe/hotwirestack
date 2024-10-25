# frozen_string_literal: true

require "test_helper"
require "minitest/spec"
require "minitest/autorun"

class Forms::SelectInputComponentTest < ViewComponent::TestCase
  def test_renders_select_input_2
    form = Minitest::Mock.new
    form.expect :select, "<select></select>".html_safe, [
      :field_name,
      [["Option 1", 1], ["Option 2", 2]],
      {include_blank: false},
      {
        class: "rounded-md disabled:bg-gray-200 disabled:font-medium relative block w-full appearance-none border border-gray-300 px-2 py-1 text-gray-900 placeholder-gray-500 focus:z-10 focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
      }
    ]

    options = [["Option 1", 1], ["Option 2", 2]]
    component = Forms::SelectInputComponent.new(form, :field_name, options: options)

    render_inline(component)

    assert_selector "select"
    form.verify
  end
end
