# frozen_string_literal: true

require "test_helper"

class Index::ClearFilterButtonComponentTest < ViewComponent::TestCase
  def setup
    @index_view = index_views(:index_view_document)
    @search_session = "XXXXXXX"
    @request = ActionDispatch::TestRequest.create
  end

  test "renders component" do
    render_inline(Index::ClearFilterButtonComponent.new(index_view: @index_view, search_session: @search_session))
    assert_selector "form[action='/index_views/#{@index_view.id}/active_filter?search_session=XXXXXXX']"
    assert_selector "span", text: "Clear filter"
  end

  private

  def default_url_options
    {host: "localhost:3000"}
  end
end
