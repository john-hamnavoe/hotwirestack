class IndexViewsController < ApplicationController
  include Scoped::IndexViewRedirection
  include Scoped::TableEntity

  def index
    @index_views = Current.user.index_views.where(table_entity: @table_entity).order(:name)
  end

  def new
    @index_view = IndexView.new(table_entity: @table_entity)
  end

  def edit
    @index_view = Current.user.index_views.find(params[:id])
  end

  def show
    @index_view = Current.user.index_views.find(params[:id])
  end

  def create
    @index_view = IndexView.new(index_view_params)
    @index_view.user = Current.user
    @index_view.default = false
    if @index_view.save
      redirect_to_index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @index_view = Current.user.index_views.find(params[:id])
    if @index_view.update(index_view_params)
      redirect_to_index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @index_view = Current.user.index_views.find(params[:id])
    @index_view.destroy
    redirect_to_index
  end

  private

  def index_view_params
    params.require(:index_view).permit(:name, :default, :table_entity_id)
  end
end
