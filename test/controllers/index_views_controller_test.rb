require "test_helper"

class IndexViewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_view = IndexView.where(user: User.where(logged_in: true).first).first
    @table_entity = table_entities(:table_document)
  end

  test "should get show" do
    get index_view_path(@index_view)

    assert_response :success
  end

  test "should get new" do
    get new_index_view_path(table_entity_id: @table_entity.id)

    assert_response :success
  end

  test "should create" do
    assert_difference("IndexView.count", +1) do
      assert_difference("IndexViewColumn.count", +4) do
        post index_views_path, params: {index_view: {name: "New Index View", table_entity_id: @table_entity.id}, search_session_token: "XXXXX"}
      end
    end
    assert_redirected_to documents_path(index_view_id: IndexView.last.id, search_session_token: "XXXXX")
  end
end
