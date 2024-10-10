# frozen_string_literal: true

require "test_helper"

class Forms::CheckboxInputComponentTest < ViewComponent::TestCase
  def setup
    @document = Document.new(title: "Sample Title", active: true)  # Using a model to generate a real form
    @field = :active
  end

  def test_renders_checkbox_input
    # Render a form with the actual Post model
    form_for @document, url: "#" do |form|
      # Render the TextInputComponent within the form
      render_inline(Forms::FieldComponent.new(form, @field)) do |field|
        field.with_input_check_box
      end

      # page.native.to_html
      assert_selector "label", text: "Active"
      assert_selector 'input[type="checkbox"]'
    end
  end
end
