# frozen_string_literal: true

class Index::BaseConfigComponent < ApplicationComponent
  private attr_reader :index_view, :refresh_frame, :refresh_path, :search_session_token

  def initialize(index_view:, refresh_frame:, refresh_path:, search_session_token: nil)
    @index_view = index_view
    @refresh_frame = refresh_frame
    @refresh_path = refresh_path
    @search_session_token = search_session_token
  end
end
