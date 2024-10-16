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
module SearchSessionManageable
  extend ActiveSupport::Concern

  included do
    before_action :set_search_session, if: :manage_search_session?
  end

  private

  def manage_search_session?
    CacheConfig.cache_enabled?
  end

  def set_search_session
    token, session_key = search_session_key_with_token
    Rails.logger.info "Setting search session for #{session_key} and token #{token}"
    @search_session = Rails.cache.read(session_key) || initialize_search_session(token)
    update_search_session
    write_cache(session_key)
  end

  def search_session_key_with_token
    token = params[:search_session_token] ||= SecureRandom.urlsafe_base64(16)
    [token, search_session_key(token)]
  end

  def controller_key_name
    @controller_key_name ||= self.class.name.underscore.delete_suffix("_controller")
  end

  def search_session_key(token)
    "search_session_#{controller_key_name}_#{token}"
  end

  def write_cache(key)
    Rails.cache.write(key, @search_session, expires_in: 1.hour)
  end

  def initialize_search_session(token)
    {
      token: token,
      query: sanitized_query_params,
      sort: query_sort_params,
      page: params[:page],
      index_view_id: params[:index_view_id]
    }
  end

  def update_search_session
    @search_session[:query] = sanitized_query_params if sanitized_query_params.present?
    @search_session[:page] = page_params if page_params.present?
    @search_session[:sort] = query_sort_params if query_sort_params.present?
  end

  def sanitized_query_params
    if query_params.is_a?(ActionController::Parameters)
      query_params.except(:s).permit!.to_h  # Ensure it's a permitted hash
    else
      {}
    end
  end

  def page_params
    params[:page]
  end

  def query_sort_params
    params[:query]&.dig(:s)
  end

  def query_params
    params[:query]
  end

  def apply_search_session(base_query, index_view)
    set_search_session_index_view_id(index_view)
    query = build_query(base_query, index_view.filter_conditions || {})
    pagy, results = pagy(query.result(distinct: true), page: search_session_params(:page))
    [query, pagy, results]
  end

  def set_search_session_index_view_id(index_view)
    if @search_session[:index_view_id] != index_view.id
      @search_session[:index_view_id] = index_view.id
      write_cache(search_session_key(@search_session[:token]))
    end
  end

  def build_query(base_query, filter_conditions = {})
    ransack_query_params = search_session_params(:query)
    base_query.ransack(ransack_query_params.merge(filter_conditions)).apply_default_sorts(search_session_sort_criteria)
  end

  def search_session_params(key)
    CacheConfig.cache_enabled? ? @search_session[key] : params[key]
  end

  def search_session_sort_criteria
    CacheConfig.cache_enabled? ? @search_session&.dig(:sort) : query_sort_params
  end
end
