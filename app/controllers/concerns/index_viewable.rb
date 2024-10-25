module IndexViewable
  extend ActiveSupport::Concern

  class_methods do
    def index_viewable(model_class)
      # Disable the Rails/LexicallyScopedActionFilter cop for this block
      # rubocop:disable Rails/LexicallyScopedActionFilter
      before_action -> { set_index_views(model_class) }, only: [:index]
      before_action :set_index_view, only: [:index]
      # rubocop:enable Rails/LexicallyScopedActionFilter
    end
  end

  private

  def set_index_views(model_class)
    @user = Current.user
    table_entity = model_class.table_entity

    @index_views = Current.user.index_views.where(table_entity: table_entity)
      .order(default: :desc, name: :asc)
  end

  def set_index_view
    @index_view = load_index_view
  end

  def load_index_view
    index_view_id = params[:index_view_id] || @search_session&.index_view_id
    if index_view_id.present?
      index_view = @index_views.find_by(id: index_view_id)
      return index_view if index_view.present?
    end

    @index_views.find_by(default: true)
  end
end
