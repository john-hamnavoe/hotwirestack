# frozen_string_literal: true

class Forms::ButtonSubmitComponent < ApplicationComponent
  private attr_reader :text, :width, :data

  def initialize(text: nil, width: "w-auto", data: nil)
    @text = text
    @width = width
    @data = data
  end

  def before_render
    @text = text || t("buttons.submit")
  end
end
