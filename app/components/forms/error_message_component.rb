# frozen_string_literal: true

class Forms::ErrorMessageComponent < ApplicationComponent
  private attr_reader :model

  def initialize(model)
    @model = model
  end
end
