# frozen_string_literal: true

class Header::MainComponent < ApplicationComponent
  def initialize(current_path:)
    @current_path = current_path
  end
end
