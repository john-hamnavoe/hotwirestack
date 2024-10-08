# frozen_string_literal: true

class Index::SearchFormComponent < ApplicationComponent
  attr_reader :query, :frame, :placeholder, :search_session_token

  def initialize(query:, frame:, placeholder: "Search", search_session_token: nil)
    @query = query
    @frame = frame
    @placeholder = placeholder
    @search_session_token = search_session_token
  end
end
