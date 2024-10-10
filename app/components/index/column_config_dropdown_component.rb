# frozen_string_literal: true

class Index::ColumnConfigDropdownComponent < ApplicationComponent
  attr_reader :index_view, :refresh_frame, :refresh_path

  def initialize(index_view:, refresh_frame:, refresh_path:)
    @index_view = index_view
    @refresh_frame = refresh_frame
    @refresh_path = refresh_path
  end
end
