# frozen_string_literal: true

require "test_helper"

class Forms::TextInputComponentTest < ViewComponent::TestCase
  def setup
    @document = Document.new(title: "Sample Title")  # Using a model to generate a real form
    @field = :title
  end

  def test_renders_text_input
    # Render a form with the actual Post model
    form_for @document, url: "#" do |form|
      # Render the TextInputComponent within the form
      render_inline(Forms::FieldComponent.new(form, @field)) do |field|
        field.with_input_text(placeholder: "Enter title", autocomplete: "on", autofocus: true)
      end

      # page.native.to_html
      assert_selector "label", text: "Title"
      assert_selector 'input[type="text"][placeholder="Enter title"][autocomplete="on"][autofocus]'
    end
  end

  def test_renders_text_input_rounded
    # Render a form with the actual Post model
    form_for @document, url: "#" do |form|
      # Render the TextInputComponent within the form
      render_inline(Forms::FieldComponent.new(form, @field)) do |field|
        field.with_input_text(rounded: true)
      end

      assert_selector 'input[type="text"]', class: /\brounded-md\b/

      render_inline(Forms::FieldComponent.new(form, @field)) do |field|
        field.with_input_text(rounded: false)
      end

      assert_selector 'input[type="text"]', class: /\brounded-none\b/
    end
  end

  def test_renders_number_input
    # Render a form with the actual Post model
    form_for @document, url: "#" do |form|
      # Render the TextInputComponent within the form
      render_inline(Forms::FieldComponent.new(form, @field)) do |field|
        field.with_input_number(placeholder: "Enter title", autocomplete: "on", autofocus: true)
      end
    end

    assert_selector 'input[type="number"][placeholder="Enter title"][autocomplete="on"][autofocus]'
  end
end
