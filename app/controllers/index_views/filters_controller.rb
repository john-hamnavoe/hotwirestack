class IndexViews::FiltersController < ApplicationController
  include Scoped::IndexView
  before_action :set_filter, only: %i[show edit update destroy]

  def index
    @filters = @index_view.filters.order(:name)
  end

  def show
  end

  def new
    @filter = @index_view.filters.new
  end

  def create
    @filter = @index_view.filters.new(filter_params)
    if @filter.save
      update_active_filter_and_redirect
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @filter.update(filter_params)
      update_active_filter_and_redirect
    else
      render :edit
    end
  end

  def destroy
    @index_view.update(active_filter: nil) if @index_view.active_filter == @filter
    @filter.destroy
    redirect_to_index
  end

  private

  def update_active_filter_and_redirect
    @index_view.update(active_filter: @filter)
    redirect_to_index
  end

  def set_filter
    @filter = @index_view.filters.find(params[:id])
  end

  def filter_params
    params.require(:filter).permit(:name,
      filter_conditional_groups_attributes: [:id, :conditional_expression, :_destroy,
        filter_conditions_attributes: [:id, :table_column_id, :predicate, :value, :_destroy]])
  end
end
