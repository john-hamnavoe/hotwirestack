# frozen_string_literal: true

class Button::BaseComponent < ApplicationComponent
  private attr_reader :path, :text, :options

  def initialize(path:, text:, **options)
    @path = path
    @text = text
    @options = options
  end

  def call
    link_to text, path,
      aria: {role: "button"},
      class: combined_classes,
      **options.except(:class)
  end

  private

  def default_classes
    "block rounded-md bg-indigo-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
  end

  def combined_classes
    class_names(default_classes, options[:class])
  end
end
