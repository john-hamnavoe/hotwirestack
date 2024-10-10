# frozen_string_literal: true

require "test_helper"

class Forms::FooterComponentTest < ViewComponent::TestCase
  def setup
    @document = Document.new(title: "Sample Title")  # Using a model to generate a real form
    @field = :title
  end

  def test_generates_footer
    form_for @document, url: "#" do |form|
      # Render the TextInputComponent within the form
      render_inline(Forms::FooterComponent.new(form, "example.com"))

      # page.native.to_html
      assert_selector "button", text: "Save"
      assert_selector "a[href='example.com']", text: "Cancel"
      assert_selector "label", text: "Active"
      assert_selector 'input[type="checkbox"]'
    end
  end
end
