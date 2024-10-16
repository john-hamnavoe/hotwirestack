# frozen_string_literal: true

class Index::TabsComponent < ApplicationComponent
  private attr_reader :starting_path, :index_views, :selected_index_view, :search_session_token

  def initialize(starting_path, index_views, selected_index_view, search_session_token)
    @starting_path = starting_path
    @index_views = index_views
    @selected_index_view = selected_index_view
    @search_session_token = search_session_token
  end
end
