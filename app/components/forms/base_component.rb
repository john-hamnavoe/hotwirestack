# frozen_string_literal: true

class Forms::BaseComponent < ApplicationComponent
  private attr_reader :form, :field

  def initialize(form, field)
    @form = form
    @field = field
  end
end
