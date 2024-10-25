# frozen_string_literal: true

require "test_helper"

class Index::TabsComponentTest < ViewComponent::TestCase
  def test_component_renders_button
    @index_views = [index_views(:index_view_document_one_all), index_views(:index_view_document_one_active_only)]
    @selected_index_view = index_views(:index_view_document_one_all)
    render_inline(Index::TabsComponent.new(:documents_path, @index_views, @selected_index_view, "XXXXX"))

    assert_selector "div.flex"
  end
end
