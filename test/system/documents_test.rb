require "application_system_test_case"

class DocumentsTest < ApplicationSystemTestCase
  setup do
    @document = documents(:one)
  end

  test "visiting the index" do
    visit documents_path
    assert_selector "h1", text: "Documents"
  end

  test "should create document" do
    visit documents_path
    click_on "New document"

    check "Active" if @document.active
    fill_in "Title", with: "New Shinny Document"
    click_on "Save"

    assert_selector "td", text: "New Shinny Document"
  end

  test "should update document" do
    # visit documents_path
    #  click_on "Edit", match: :first

    #  check "Active" if @document.active
    #  fill_in "Title", with: "Updated Shinny Document"
    #  click_on "Save"

    # assert_selector "td", text: "Updated Shinny Document"
  end
end
