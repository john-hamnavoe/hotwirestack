require "test_helper"

class IndexViews::ActiveFilterControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_view = index_views(:index_view_document_one_all)
    @filter = filters(:filter_document_one_all)
  end

  test "should update" do
    patch index_view_active_filter_path(@index_view), params: {filter_id: @filter.id, search_session_token: "XXXXX"}

    assert_redirected_to documents_path(index_view_id: @index_view.id, search_session_token: "XXXXX")

    @index_view.reload

    assert_equal @filter, @index_view.active_filter

    patch index_view_active_filter_path(@index_view), params: {filter_id: nil, search_session_token: "XXXXX"}

    assert_redirected_to documents_path(index_view_id: @index_view.id, search_session_token: "XXXXX")

    @index_view.reload

    assert_nil @index_view.active_filter
  end
end
