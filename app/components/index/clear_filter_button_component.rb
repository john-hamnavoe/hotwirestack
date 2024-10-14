# frozen_string_literal: true

class Index::ClearFilterButtonComponent < ApplicationComponent
  private attr_reader :index_view, :search_session
  def initialize(index_view:, search_session:)
    @index_view = index_view
    @search_session = search_session
  end
end
