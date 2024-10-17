# SearchQueryBuilder
#
# This class is responsible for building a Ransack query based on the provided base query, search session, index view, and parameters.
# It uses the search session for caching and the index view for filtering conditions.
#
class SearchQueryBuilder
  def initialize(base_query, search_session, index_view, params)
    @base_query = base_query
    @search_session = search_session
    @index_view = index_view
    @params = params
  end

  def build
    conditions = @index_view&.filter_conditions || {}
    @base_query.ransack(query_criteria.merge(conditions)).apply_default_sorts(sort_criteria)
  end

  private

  def query_criteria
    CacheConfig.cache_enabled? ? @search_session.query : @params[:query]
  end

  def sort_criteria
    CacheConfig.cache_enabled? ? @search_session.sort : @params[:query]&.dig(:s)
  end
end
