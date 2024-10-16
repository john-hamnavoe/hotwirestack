require "test_helper"

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get about_index_url
    assert_response :success
    assert_equal User.where(logged_in: true).first, assigns(:user)
    index_views = assigns(:index_views)
    assert_equal 2, index_views.count
  end
end
