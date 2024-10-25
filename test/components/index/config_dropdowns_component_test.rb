# frozen_string_literal: true

require "test_helper"

class Index::ConfigDropdownsComponentTest < ViewComponent::TestCase
  def setup
    @index_view = index_views(:index_view_document_one_all)
  end

  def test_buttons_renders
    render_inline(Index::ConfigDropdownsComponent.new(index_view: @index_view, refresh_frame: "freshing", refresh_path: "pathing", search_session_token: "XXXXXXX"))

    assert_selector "button", count: 2
  end
end
