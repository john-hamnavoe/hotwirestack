# frozen_string_literal: true

class Index::PagyComponent < ApplicationComponent
  include Pagy::Frontend
  include PagyHelper
  private attr_reader :id, :pagy, :index_view, :search_session_token

  def initialize(id:, pagy:, index_view: nil, search_session_token: nil)
    @id = id
    @pagy = pagy
    @index_view = index_view
    @search_session_token = search_session_token
  end
end
