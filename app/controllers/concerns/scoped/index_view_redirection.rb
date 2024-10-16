# frozen_string_literal: true

module Scoped::IndexViewRedirection
  extend ActiveSupport::Concern

  included do
    helper_method :index_view_redirect_path
  end

  private

  def redirect_to_index
    Rails.logger.info("Redirecting to index view with search session: #{search_session_token}")
    redirect_to index_view_redirect_path(@index_view), status: :see_other
  end

  def index_view_redirect_path(index_view)
    collection_name = index_view.table_entity_model_class_name.constantize.model_name.collection
    Rails.application.routes.url_helpers.send(:"#{collection_name}_path", index_view_id: index_view.id, search_session_token: search_session_token)
  end
end
