# frozen_string_literal: true

class Tables::HeaderComponent < ApplicationComponent
  attr_reader :title, :sr_only

  def initialize(title = nil, **options)
    @title = title
    @sr_only = options[:sr_only]
  end

  def call
    tag.th title || content, scope: "col",
      class: class_names("py-1.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-0", sr_only_class)
  end

  private

  def sr_only_class
    @sr_only ? "sr-only" : ""
  end
end
