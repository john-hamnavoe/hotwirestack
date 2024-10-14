# frozen_string_literal: true

class Forms::NestedGridHeaderComponent < ApplicationComponent
  private attr_reader :partial
  def initialize(partial)
    @partial = partial
  end
end
