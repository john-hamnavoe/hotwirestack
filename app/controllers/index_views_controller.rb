class IndexViewsController < ApplicationController
  include Scoped::IndexViewRedirection
  include Scoped::TableEntity
  before_action :set_index_view, only: [:show, :edit, :update, :destroy]

  def index
    @index_views = Current.user.index_views.where(table_entity: @table_entity).order(:name)
  end

  def show
  end

  def new
    @index_view = IndexView.new(table_entity: @table_entity)
  end

  def edit
  end

  def create
    @index_view = IndexView.new(index_view_params)
    @index_view.user ||= Current.user
    @index_view.default = false
    if @index_view.save
      redirect_to_index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @index_view.update(index_view_params)
      redirect_to_index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @index_view.destroy
    redirect_to_index
  end

  private

  def set_index_view
    @index_view = Current.user.index_views.find(params[:id])
  end

  def index_view_params
    params.require(:index_view).permit(:name, :default, :table_entity_id)
  end
end
