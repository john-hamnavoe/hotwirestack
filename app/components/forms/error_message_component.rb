# frozen_string_literal: true

class Forms::ErrorMessageComponent < ApplicationComponent
  attr_reader :model

  def initialize(model)
    @model = model
  end
end
