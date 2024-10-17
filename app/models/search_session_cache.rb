class SearchSessionCache < ApplicationCache
  attr_accessor :query, :sort, :page, :index_view_id

  class << self
    private

    def cache_prefix
      "search_session"
    end
  end

  def query_attributes
    {
      query: @query,
      sort: @sort,
      page: @page
    }
  end

  private

  def to_h
    super.merge(
      query: @query,
      sort: @sort,
      page: @page,
      index_view_id: @index_view_id
    )
  end
end
