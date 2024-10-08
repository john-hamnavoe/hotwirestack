# frozen_string_literal: true

class Index::TableComponent < ApplicationComponent
  include Pagy::Frontend
  attr_reader :frame, :items, :columns, :pagy, :query

  def initialize(frame:, items:, columns:, pagy: nil, query: nil)
    @frame = frame
    @items = items
    @columns = columns
    @pagy = pagy
    @query = query
  end
end
