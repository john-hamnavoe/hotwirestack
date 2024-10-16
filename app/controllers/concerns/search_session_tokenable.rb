# SearchSessionTokenable
#
# This concern provides functionality for handling search session tokens in Rails controllers.
# It allows for maintaining search context across requests, which can be useful for
# features like pagination or returning to search results.
#
# Key features:
# - Adds helper methods for accessing and manipulating search session tokens
# - Provides a method to append the search session token to URLs
# - Includes a helper for generating a hidden form field with the search session token
#
# Usage:
# This concern is automatically included in ApplicationController.
# Example: `include SearchSessionTokenable`
#
# To include a search session token in a link, use the `with_search_session_token` helper.
# For example:
#   <%= link_to "Edit", with_search_session_token(edit_document_path(document), method: :get) %>
#
# To add a hidden field for the search session token in a form, use the `search_session_token_hidden_field` helper.
# For example:
#   <%= search_session_token_hidden_field %>
#

module SearchSessionTokenable
  extend ActiveSupport::Concern

  included do
    helper_method :search_session_token, :with_search_session_token, :search_session_token_hidden_field
  end

  private

  def search_session_token
    params[:search_session_token]
  end

  def with_search_session_token(path, options = {})
    return path if search_session_token.blank?

    uri = URI(path)
    query_params = Rack::Utils.parse_query(uri.query)
    query_params["search_session_token"] = search_session_token
    uri.query = query_params.to_query
    uri.to_s
  end

  def search_session_token_hidden_field
    if search_session_token
      ActionController::Base.helpers.hidden_field_tag :search_session_token, search_session_token
    end
  end
end
