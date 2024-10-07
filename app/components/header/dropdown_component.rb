# frozen_string_literal: true

class Header::DropdownComponent < ApplicationComponent
  def initialize(title:, items:, mobile:)
    @title = title
    @items = items
    @mobile = mobile
  end
end
