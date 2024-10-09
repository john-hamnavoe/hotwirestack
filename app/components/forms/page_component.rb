# frozen_string_literal: true

class Forms::PageComponent < ApplicationComponent
  attr_reader :title, :description, :model, :width

  def initialize(title:, description: nil, model: nil, width: "w-full")
    @title = title
    @description = description
    @model = model
    @width = width
  end
end
