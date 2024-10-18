# frozen_string_literal: true

class Index::TableComponent < ApplicationComponent
  include Pagy::Frontend
  private attr_reader :frame, :items, :columns, :pagy, :query, :search_session_token, :index_view

  def initialize(frame:, items:, index_view:, pagy: nil, query: nil, search_session_token: nil)
    @frame = frame
    @items = items
    @pagy = pagy
    @query = query
    @search_session_token = search_session_token
    @index_view = index_view
    @columns = index_view.displayed_columns
  end

  def action_proc(model_name, attribute_name)
    case attribute_name
    when :edit
      ->(record) { link_to t("buttons.edit"), send(:"edit_#{model_name.downcase}_path", record, search_session_token: search_session_token), class: "text-indigo-600 hover:text-indigo-900", data: {turbo_frame: :_top} }
    when :delete
      ->(record) { button_to t("buttons.delete"), send(:"#{model_name.downcase}_path", record, search_session_token: search_session_token), method: :delete, class: "text-red-600 hover:text-red-900", form: {data: {turbo_confirm: t("messages.are_you_sure")}} }
    when :open
      ->(record) { link_to t("buttons.open"), send(:"#{model_name.downcase}_path", record, search_session_token: search_session_token), class: "text-indigo-600 hover:text-indigo-900", data: {turbo_frame: :_top} }
    end
  end

  def method_proc(attribute_name)
    case attribute_name
    when :active
      ->(record) { record.active? ? "Yes" : "No" }
    end
  end
end
