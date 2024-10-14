# frozen_string_literal: true

require "test_helper"

class Index::ColumnConfigDropdownComponentTest < ViewComponent::TestCase
  def setup
    @index_view = index_views(:index_view_document)
  end

  def test_component_renders_button
    render_inline(Index::ColumnConfigDropdownComponent.new(index_view: @index_view, refresh_frame: "freshing", refresh_path: "pathing", search_session_token: "XXXXXXX"))
    assert_selector "button"
    assert_selector "div[data-reload-dropdown-frame-value='index_view_#{@index_view.id}']"
    assert_selector "div[data-reload-dropdown-refresh-path-value='pathing']"
    assert_selector "div[data-reload-dropdown-refresh-frame-value='freshing']"
  end
end
