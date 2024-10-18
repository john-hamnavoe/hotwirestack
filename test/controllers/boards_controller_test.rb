require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:one)
  end

  test "should get index" do
    get boards_path
    assert_response :success
  end

  test "should get new" do
    get new_board_path
    assert_response :success
  end

  test "should create board" do
    assert_difference("Board.count") do
      post boards_path, params: {search_session_token: "XXXXX", board: {active: @board.active, name: "New Name", owner_id: @board.owner_id}}
    end

    assert_redirected_to boards_path(search_session_token: "XXXXX")
  end

  test "should show board" do
    get board_path(@board)
    assert_response :success
  end

  test "should get edit" do
    get edit_board_path(@board)
    assert_response :success
  end

  test "should update board" do
    patch board_path(@board), params: {search_session_token: "XXXXX", board: {active: @board.active, name: @board.name, owner_id: @board.owner_id}}
    assert_redirected_to boards_path(search_session_token: "XXXXX")
  end

  test "should destroy board" do
    assert_difference("Board.count", -1) do
      delete board_path(@board, search_session_token: "XXXXX")
    end

    assert_redirected_to boards_path(search_session_token: "XXXXX")
  end
end
