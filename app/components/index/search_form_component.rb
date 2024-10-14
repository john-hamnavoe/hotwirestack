# frozen_string_literal: true

class Index::SearchFormComponent < ApplicationComponent
  private attr_reader :query, :frame, :search_field_predicate, :placeholder, :search_session_token

  renders_one :config_dropdowns, Index::ConfigDropdownsComponent

  def initialize(query:, frame:, search_field_predicate:, placeholder: "Search", search_session_token: nil)
    @query = query
    @frame = frame
    @search_field_predicate = search_field_predicate
    @placeholder = placeholder
    @search_session_token = search_session_token
  end
end
