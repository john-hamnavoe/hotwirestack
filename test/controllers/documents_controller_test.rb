require "test_helper"

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    IndexView.create_default_views
    @document = documents(:one)
  end

  test "should get index" do
    get documents_path
    assert_response :success
  end

  test "should get new" do
    get new_document_path
    assert_response :success
  end

  test "should create document" do
    assert_difference("Document.count") do
      post documents_path, params: {search_session: "XXXXX", document: {active: @document.active, title: @document.title}}
    end

    assert_redirected_to documents_path(search_session: "XXXXX")
  end

  test "should show document" do
    get document_path(@document)
    assert_response :success
  end

  test "should get edit" do
    get edit_document_path(@document)
    assert_response :success
  end

  test "should update document" do
    patch document_path(@document), params: {search_session: "XXXXX", document: {active: @document.active, title: @document.title}}
    assert_redirected_to documents_path(search_session: "XXXXX")
  end

  test "should destroy document" do
    assert_difference("Document.count", -1) do
      delete document_path(@document, params: {search_session: "XXXXX"})
    end

    assert_redirected_to documents_path(search_session: "XXXXX")
  end
end
