# frozen_string_literal: true

class Index::TableComponent < ApplicationComponent
  include Pagy::Frontend
  attr_reader :frame, :items, :columns, :actions, :pagy

  def initialize(frame:, items:, columns:, actions: {}, pagy: nil)
    @frame = frame
    @items = items
    @columns = columns
    @actions = actions
    @pagy = pagy
  end

  def render_action(item, action_name)
    action_block = actions[action_name.to_sym]
    action_block&.call(item)
  end
end
