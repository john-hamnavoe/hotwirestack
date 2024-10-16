# frozen_string_literal: true

module Scoped::TableEntity
  extend ActiveSupport::Concern

  included do
    before_action :set_table_entity
  end

  private

  def set_table_entity
    @table_entity = TableEntity.find(params[:table_entity_id]) if params[:table_entity_id].present?
  end
end
