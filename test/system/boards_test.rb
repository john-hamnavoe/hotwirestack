require "application_system_test_case"

class BoardsTest < ApplicationSystemTestCase
  setup do
    @board = boards(:one)
  end

  test "visiting the index" do
    visit boards_path

    assert_selector "h1", text: "Boards"
  end

  test "should create board" do
    visit boards_path
    click_on "New board"

    check "Active" if @board.active
    fill_in "Name", with: "New Board for testing"
    click_on "Save"

    assert_text "Board was successfully created"
    assert_selector "td", text: "New Board for testing"
  end

  test "should update Board" do
    visit boards_path
    click_on "Edit", match: :first

    check "Active" if @board.active
    fill_in "Name", with: "Brand new name"
    click_on "Save"

    assert_text "Board was successfully updated"
    assert_selector "td", text: "Brand new name"
  end

  test "should destroy Board" do
    visit boards_path
    accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Board was successfully destroyed"
  end
end
