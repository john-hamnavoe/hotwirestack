require "test_helper"

class IndexViews::ActiveFilterControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_view = index_views(:index_view_document)
    @filter = filters(:filter_document)
  end

  test "should update" do
    patch index_view_active_filter_path(@index_view), params: {filter_id: @filter.id, search_session: "XXXXX"}
    assert_redirected_to documents_path(search_session: "XXXXX")

    @index_view.reload
    assert_equal @filter, @index_view.active_filter

    patch index_view_active_filter_path(@index_view), params: {filter_id: nil, search_session: "XXXXX"}
    assert_redirected_to documents_path(search_session: "XXXXX")

    @index_view.reload
    assert_nil @index_view.active_filter
  end
end
