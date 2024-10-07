# frozen_string_literal: true

class Header::MobileMenuComponent < ApplicationComponent
  def initialize(current_path:)
    @current_path = current_path
  end
end
