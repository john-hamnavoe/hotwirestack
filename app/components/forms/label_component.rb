# frozen_string_literal: true

class Forms::LabelComponent < ApplicationComponent
  def initialize(title:, classes: nil, large: false)
    @title = title
    @classes = classes
    @large = large
  end

  def call
    content_tag :label, @title, class: label_class
  end

  private

  def label_class
    class_names(@classes, "block font-medium leading-6 text-gray-700", text_size_class)
  end

  def text_size_class
    @large ? "text-lg" : "text-sm"
  end
end
