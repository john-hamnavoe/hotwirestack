# frozen_string_literal: true

module Scoped::IndexView
  extend ActiveSupport::Concern
  include Scoped::IndexViewRedirection

  included do
    before_action :set_index_view
  end

  private

  def set_index_view
    @index_view = Current.user.index_views.find(params[:index_view_id]) if params[:index_view_id].present?
  end
end
