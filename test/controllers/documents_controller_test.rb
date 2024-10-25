require "test_helper"

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:one)
  end

  test "index page displays documents" do
    get documents_path

    assert_response :success
  end

  test "index page displays documents 2" do
    get documents_path

    assert_response :success
  end

  test "should get new" do
    get new_document_path

    assert_response :success
  end

  test "should create document" do
    assert_difference("Document.count") do
      post documents_path, params: {search_session_token: "XXXXX", document: {active: @document.active, title: @document.title}}
    end

    assert_redirected_to documents_path(search_session_token: "XXXXX")
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
    patch document_path(@document), params: {search_session_token: "XXXXX", document: {active: @document.active, title: @document.title}}

    assert_redirected_to documents_path(search_session_token: "XXXXX")
  end

  test "should destroy document" do
    assert_difference("Document.count", -1) do
      delete document_path(@document, params: {search_session_token: "XXXXX"})
    end

    assert_redirected_to documents_path(search_session_token: "XXXXX")
  end
end
