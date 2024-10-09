# frozen_string_literal: true

class Forms::ButtonCancelComponent < ApplicationComponent
  private attr_reader :title, :path, :data, :width

  def initialize(path, title = nil, data: nil, width: "w-auto")
    @path = path
    @title = title
    @data = data
    @width = width
  end

  def call
    link_to title, path, class: classes, data: data, type: "button"
  end

  def before_render
    @title = title || t("buttons.cancel")
  end

  private

  def classes
    "#{width} text-sm font-semibold leading-6 text-gray-900"
  end
end
