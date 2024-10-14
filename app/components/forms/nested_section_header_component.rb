# frozen_string_literal: true

class Forms::NestedSectionHeaderComponent < ApplicationComponent
  private attr_reader :title, :description
  def initialize(title:, description: nil)
    @title = title
    @description = description
  end
end
