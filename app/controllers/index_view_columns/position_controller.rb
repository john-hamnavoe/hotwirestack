class IndexViewColumns::PositionController < ApplicationController
  def update
    @index_view_column = IndexViewColumn.find(params[:index_view_column_id])
    display = params[:column_id] == "1"
    @index_view_column.update(position: params[:row_position], display: display)
    head :no_content
  end
end
