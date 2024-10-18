# SearchSessionManageable
#
# This module provides functionality for managing search sessions in Rails controllers.
# It handles caching, initialization, and updating of search parameters across requests.
#
# Key features:
# - Automatic search session management (can be disabled)
# - Caching of search parameters (query, sort, page)
# - Integration with Ransack for query building
# - Pagination support
#
# Usage:
# Include this module in controllers where search session management is needed.
# The module hooks into the controller's action cycle via a before_action.
#

# Workflow:
# Initialize search session token:
#   Check if the params contain a search session token. If not, generate a new one.
#
# Fetch or initialize search session:
#   Retrieve the search session using the token from the cache. If no session is found, create a new one.
#
# Handle index view change (if applicable):
#   If the user switches tabs i.e. changes the index view in the search UI:
#       Retrieve the cached view and update the session with its stored values.
#       If no cached view is found, clear the query, sort, and page in the session as this is new search for new index view
#
# Update or initialize search session (if index view remains the same):
#   If the session is new, initialize query, sort, and page with default values.
#   If the session already exists, update it with sanitized values for query, sort, and page, ignoring any nil parameters.
# Apply search session:
#  Call apply_search_session with the base query and index view. By this point, the session should either contain cached values or updated parameters from the user.

module SearchSessionManageable
  extend ActiveSupport::Concern
  include RansackPagyParams

  included do
    before_action :set_search_session, if: -> { CacheConfig.cache_enabled? }
  end

  private

  def set_search_session
    initialize_search_session_token
    @search_session = fetch_or_initialize_search_session

    if changed_index_view?
      handle_changed_index_view
    else
      update_or_initialize_search_session
    end
  end

  def initialize_search_session_token
    params[:search_session_token] ||= SecureRandom.urlsafe_base64(16)
  end

  def fetch_or_initialize_search_session
    SearchSessionCache.read(controller_key_name, params[:search_session_token])
  end

  def handle_changed_index_view
    cached_view = fetch_cached_index_view
    update_session_with_cached_view(cached_view)
  end

  def fetch_cached_index_view
    SearchSessionIndexCache.read(index_view_key_name(index_view_id_params), @search_session.token)
  end

  def update_session_with_cached_view(cached_view)
    if cached_view.found?
      @search_session.update(cached_view.query_attributes.merge(index_view_id: index_view_id_params))
    else
      @search_session.update(query: {}, sort: nil, page: nil, index_view_id: index_view_id_params)
    end
  end

  def update_or_initialize_search_session
    @search_session.found? ? update_existing_session : initialize_new_session
  end

  def update_existing_session
    updates = collect_session_updates
    @search_session.update(updates) if updates.any?
  end

  def collect_session_updates
    {
      query: sanitized_query_params,
      page: page_params,
      sort: query_sort_params
    }.compact_blank
  end

  def initialize_new_session
    @search_session.update(
      query: sanitized_query_params,
      sort: query_sort_params,
      page: params[:page],
      index_view_id: params[:index_view_id]
    )
  end

  def controller_key_name
    @controller_key_name ||= self.class.name.underscore.delete_suffix("_controller")
  end

  def index_view_key_name(index_view_id)
    "#{index_view_id}_#{controller_key_name}"
  end

  def changed_index_view?
    index_view_id_params.present? && index_view_id_params != @search_session.index_view_id
  end

  def apply_search_session(base_query, index_view)
    set_search_session_index_view_id(index_view)
    query = SearchQueryBuilder.new(base_query, @search_session, index_view, params).build
    pagy, results = pagy(query.result, page: search_session_page)
    [query, pagy, results]
  end

  def set_search_session_index_view_id(index_view)
    return unless index_view.present?
    new_index_view_id = index_view.id
    if @search_session.index_view_id != new_index_view_id
      @search_session.update(index_view_id: new_index_view_id.to_s)
    end
    cache_current_index_view(index_view)
  end

  def cache_current_index_view(index_view)
    SearchSessionIndexCache.write(index_view_key_name(index_view.id), @search_session.token, @search_session.query_attributes)
  end

  def search_session_page
    CacheConfig.cache_enabled? ? @search_session.page : params[:page]
  end
end
