# frozen_string_literal: true

class Forms::FieldsContainerComponent < ApplicationComponent
  attr_reader :model, :modal

  def initialize(model: nil, modal: false)
    raise ArgumentError.new("Model is required if modal is true") if modal && model.nil?

    @model = model
    @modal = modal
  end

  def padding
    modal ? "p-4" : ""
  end
end
