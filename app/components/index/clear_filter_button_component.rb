# frozen_string_literal: true

class Index::ClearFilterButtonComponent < ApplicationComponent
  private attr_reader :index_view, :search_session_token
  def initialize(index_view:, search_session_token:)
    @index_view = index_view
    @search_session_token = search_session_token
  end
end
