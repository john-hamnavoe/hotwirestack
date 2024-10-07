# frozen_string_literal: true

class Index::PagyComponent < ApplicationComponent
  include Pagy::Frontend
  attr_reader :id, :pagy

  def initialize(id:, pagy:)
    @id = id
    @pagy = pagy
  end
end
