class IndexViewsController < ApplicationController
  def show
    @index_view = IndexView.find(params[:id])
  end
end
