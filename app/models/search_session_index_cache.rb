class SearchSessionIndexCache < ApplicationCache
  attr_accessor :query, :sort, :page

  class << self
    private

    def cache_prefix
      "search_session_index"
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
      page: @page
    )
  end
end
