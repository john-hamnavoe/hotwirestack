# frozen_string_literal: true

module Scoped::IndexView
  extend ActiveSupport::Concern

  included do
    before_action :set_index_view
  end

  private

  def set_index_view
    @index_view = IndexView.find(params[:index_view_id])
  end

  def redirect_to_index
    Rails.logger.info("Redirecting to index view with search session: #{params[:search_session]}")
    collection_name = @index_view.table_entity_model_class_name.constantize.model_name.collection
    path = Rails.application.routes.url_helpers.send(:"#{collection_name}_path", search_session: params[:search_session])
    redirect_to path, status: :see_other
  end
end
