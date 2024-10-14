require "test_helper"

class IndexViews::FiltersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_view = index_views(:index_view_document)
    @filter = filters(:filter_document)
  end

  test "should get index" do
    get index_view_filters_path(@index_view)
    assert_response :success
  end

  test "should get new" do
    get new_index_view_filter_path(@index_view)
    assert_response :success
  end

  test "should create" do
    assert_difference("Filter.count") do
      post index_view_filters_path(@index_view), params: {filter: {name: "New Filter"}, search_session: "XXXXX"}
    end
    assert_redirected_to documents_path(search_session: "XXXXX")
  end

  test "should get edit" do
    get edit_index_view_filter_path(@index_view, @filter)
    assert_response :success
  end

  test "should update" do
    patch index_view_filter_path(@index_view, @filter), params: {filter: {name: "Updated Filter"}, search_session: "XXXXX"}
    assert_redirected_to documents_path(search_session: "XXXXX")
  end

  test "should destroy" do
    assert_difference("Filter.count", -1) do
      delete index_view_filter_path(@index_view, @filter), params: {search_session: "XXXXX"}
    end
    assert_redirected_to documents_path(search_session: "XXXXX")
  end
end
