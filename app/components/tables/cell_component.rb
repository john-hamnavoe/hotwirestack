# frozen_string_literal: true

class Tables::CellComponent < ApplicationComponent
  def initialize(**options)
    @primary = options[:primary]
    @sr_only = options[:sr_only]
    @text_align = options[:text_align]
  end

  def call
    tag.td content, class: class_names("whitespace-nowrap py-1 pl-4 pr-3 text-sm text-gray-900 sm:pl-0", text_align_class, primary_class, sr_only_class)
  end

  private

  def text_align_class
    @text_align ? "text-#{@text_align}" : ""
  end

  def primary_class
    @primary ? "font-medium" : ""
  end

  def sr_only_class
    @sr_only ? "sr-only" : ""
  end
end
