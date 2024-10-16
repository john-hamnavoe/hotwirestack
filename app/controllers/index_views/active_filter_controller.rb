class IndexViews::ActiveFilterController < ApplicationController
  include Scoped::IndexView

  def update
    @index_view.update(active_filter_id: params[:filter_id])
    redirect_to_index
  end
end
