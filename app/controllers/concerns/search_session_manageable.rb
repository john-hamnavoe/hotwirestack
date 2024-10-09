module SearchSessionManageable
  extend ActiveSupport::Concern

  included do
    before_action :set_search_session, if: :manage_search_session?
  end

  class_methods do
    def disable_search_session_management
      @manage_search_session = false
    end
  end

  private

  def manage_search_session?
    @manage_search_session != false && CacheConfig.cache_enabled?
  end

  def set_search_session
    token, session_key = search_session_key
    @search_session = Rails.cache.read(session_key) || initialize_search_session(token)
    update_search_session
    write_cache(session_key)
  end

  def search_session_key
    token = params[:search_session] || SecureRandom.urlsafe_base64(16)
    controller_name = self.class.name.underscore.gsub("_controller", "")
    [token, "search_session_#{controller_name}_#{token}"]
  end

  def write_cache(key)
    Rails.cache.write(key, @search_session, expires_in: 1.hour)
  end

  def initialize_search_session(token)
    {
      token: token,
      query: sanitized_query_params,
      sort: query_sort_params,
      page: params[:page]
    }
  end

  def update_search_session
    @search_session[:query] = sanitized_query_params
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

  def apply_search_session(base_query)
    page = search_session_params(:page)
    query = build_query(base_query)

    pagy, results = pagy(query.result(distinct: true), page: page)

    [query, pagy, results]
  end

  def build_query(base_query)
    ransack_query_params = search_session_params(:query)
    base_query.ransack(ransack_query_params).apply_default_sorts(search_session_sort_criteria)
  end

  def search_session_params(key)
    CacheConfig.cache_enabled? ? @search_session[key] : params[key]
  end

  def search_session_sort_criteria
    CacheConfig.cache_enabled? ? @search_session&.dig(:sort) : query_sort_params
  end
end
