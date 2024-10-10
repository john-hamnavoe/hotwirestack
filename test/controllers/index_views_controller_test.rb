require "test_helper"

class IndexViewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    IndexView.create_default_views
    @index_view = IndexView.first
  end

  test "should get show" do
    get index_view_path(@index_view)
    assert_response :success
  end
end
