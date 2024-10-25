require "test_helper"

class DocumentsTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:one)
    @document_two = documents(:two)
    @default_index_view = index_views(:index_view_document_one_all)
    @active_only_index_view = index_views(:index_view_document_one_active_only)
    @filter = filters(:filter_document_one_active_only)
    @table_entity = table_entities(:table_document)
  end

  test "index page displays documents - with correct links - caching applied" do
    assert CacheConfig.cache_enabled?, "Cache is not enabled"

    get documents_path
    index_views = assigns(:index_views)
    assert_equal 2, index_views.count
    assert_equal User.where(logged_in: true).first, assigns(:user)

    assert_response :success

    documents = assigns(:documents)
    search_session_token = assigns(:search_session).token
    assert_equal 4, documents.count
    assert_not_nil search_session_token

    assert_select "a[href='#{documents_path(index_view_id: @default_index_view.id, search_session_token: search_session_token)}']", text: "All"
    assert_select "a[href='#{documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)}']", text: "Active Only"
    assert_select "a[href='#{new_document_path(search_session_token: search_session_token)}']", text: "New document"
    assert_select "a[href='#{edit_document_path(documents(:one), search_session_token: search_session_token)}']", text: "Edit"
    assert_select "form[action='#{document_path(documents(:one), search_session_token: search_session_token)}'][method='post']"

    get documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    assert_response :success
    documents = assigns(:documents)
    assert_equal 4, documents.count

    patch index_view_active_filter_path(@active_only_index_view, filter_id: @filter.id, search_session_token: search_session_token)
    assert_redirected_to documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    get documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    assert_response :success
    documents = assigns(:documents)
    assert_equal 3, documents.count
    assert_select "a[href='#{edit_document_path(documents(:one), search_session_token: search_session_token)}']", text: "Edit", count: 0
    assert_select "form[action='#{document_path(documents(:one), search_session_token: search_session_token)}'][method='post']", count: 0

    patch index_view_active_filter_path(@active_only_index_view, filter_id: nil, search_session_token: search_session_token)
    assert_redirected_to documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    get documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    assert_response :success
    documents = assigns(:documents)
    assert_equal 4, documents.count
    get documents_path(search_session_token: search_session_token, query: {title_cont: "One"})
    assert_response :success
    documents = assigns(:documents)
    assert_equal 1, documents.count

    patch index_view_active_filter_path(@active_only_index_view, filter_id: @filter.id, search_session_token: search_session_token)
    assert_redirected_to documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    follow_redirect!
    assert_response :success
    documents = assigns(:documents)
    assert_equal 0, documents.count

    patch index_view_active_filter_path(@active_only_index_view, filter_id: nil, search_session_token: search_session_token)
    assert_redirected_to documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    follow_redirect!
    assert_response :success
    documents = assigns(:documents)
    assert_equal 1, documents.count

    get edit_document_path(documents(:one), search_session_token: search_session_token)
    assert_response :success
    # assert_select "input[type='hidden'][name='search_session_token'][value='#{search_session_token}']"

    # patch document_path(@document, search_session_token: search_session_token), params: {document: {active: @document.active, title: "New Title"}}
    # assert_redirected_to documents_path(search_session_token: search_session_token)
    # follow_redirect!
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 0, documents.count, "Document title changed to not container 'one'"

    # patch index_view_active_filter_path(@active_only_index_view, filter_id: @filter.id, search_session_token: search_session_token)
    # assert_redirected_to documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    # follow_redirect!
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 0, documents.count, "Title 'one' search still applies"

    # get documents_path(search_session_token: search_session_token, query: {title_cont: ""})
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 3, documents.count, "Active only documents returned"

    # get edit_document_path(@document_two, search_session_token: search_session_token)
    # assert_response :success
    # assert_select "input[type='hidden'][name='search_session_token'][value='#{search_session_token}']"

    # patch document_path(@document_two, search_session_token: search_session_token), params: {document: {active: false, title: @document_two.title}}
    # assert_redirected_to documents_path(search_session_token: search_session_token)
    # follow_redirect!
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 2, documents.count, "Document two is not active and filter is on"

    # get new_document_path(search_session_token: search_session_token)
    # assert_response :success
    # assert_select "input[type='hidden'][name='search_session_token'][value='#{search_session_token}']"

    # assert_difference("Document.count", 1) do
    #   post documents_path(search_session_token: search_session_token), params: {document: {active: true, title: "New Document"}}
    # end
    # assert_redirected_to documents_path(search_session_token: search_session_token)
    # follow_redirect!
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 3, documents.count, "new active document added"

    # get new_document_path(search_session_token: search_session_token)
    # assert_response :success
    # assert_select "input[type='hidden'][name='search_session_token'][value='#{search_session_token}']"

    # assert_difference("Document.count", 1) do
    #   post documents_path(search_session_token: search_session_token), params: {document: {active: false, title: "New Document"}}
    # end
    # assert_redirected_to documents_path(search_session_token: search_session_token)
    # follow_redirect!
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 3, documents.count, "new inactive document added"

    # get documents_path(index_view_id: @default_index_view.id, search_session_token: search_session_token)
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 6, documents.count, "no filter applied"

    # delete document_path(@document_two, search_session_token: search_session_token)
    # assert_redirected_to documents_path(search_session_token: search_session_token)
    # follow_redirect!
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 5, documents.count, "document two deleted"

    # get documents_path(search_session_token: search_session_token, query: {s: "title asc"})
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 5, documents.count
    # assert_equal "Document Four", documents.first.title
    # assert_equal "New Title", documents.last.title

    # get documents_path(search_session_token: search_session_token, query: {s: "title desc"})
    # assert_response :success
    # documents = assigns(:documents)
    # assert_equal 5, documents.count
    # assert_equal "New Title", documents.first.title
    # assert_equal "Document Four", documents.last.title
  end

  test "index page displays documents - add new index view and filters, edit it and then delete it" do
    get documents_path
    assert_response :success
    documents = assigns(:documents)
    search_session_token = assigns(:search_session).token
    assert_equal 4, documents.count

    get new_index_view_path(table_entity_id: @table_entity.id, search_session_token: search_session_token)
    assert_response :success
    assert_select "input[type='hidden'][name='search_session_token'][value='#{search_session_token}']"

    assert_difference("IndexView.count", +1) do
      assert_difference("IndexViewColumn.count", +4) do
        post index_views_path, params: {index_view: {name: "Testing an new index view", table_entity_id: @table_entity.id}, search_session_token: search_session_token}
      end
    end
    index_view = IndexView.find_by(name: "Testing an new index view")
    assert_redirected_to documents_path(index_view_id: index_view.id, search_session_token: search_session_token)
    follow_redirect!
    assert_response :success
    documents = assigns(:documents)
    assert_equal 4, documents.count

    table_column = table_columns(:document_column_active)

    assert_difference("Filter.count", +1) do
      assert_difference("FilterConditionalGroup.count", +1) do
        assert_difference("FilterCondition.count", +1) do
          post index_view_filters_path(index_view), params: {filter: {name: "New Filter", filter_conditional_groups_attributes: [{conditional_expression: "all_and",
                                                                                                                                  filter_conditions_attributes: [{table_column_id: table_column.id, predicate: "eq", value: "false"}]}]},
                                                             search_session_token: search_session_token}
        end
      end
    end
    assert_redirected_to documents_path(index_view_id: index_view.id, search_session_token: search_session_token)
    follow_redirect!
    assert_response :success
    documents = assigns(:documents)
    assert_equal 1, documents.count, "filter applied"

    get index_views_path(table_entity_id: @table_entity.id, search_session_token: search_session_token)
    assert_response :success
    index_views = assigns(:index_views)
    assert_equal 3, index_views.count
    assert_select "a[href='#{edit_index_view_path(index_view, search_session_token: search_session_token)}']", text: "Edit"

    get edit_index_view_path(index_view, search_session_token: search_session_token)
    assert_response :success
    assert_select "input[type='hidden'][name='search_session_token'][value='#{search_session_token}']"

    patch index_view_path(index_view, search_session_token: search_session_token), params: {index_view: {name: "Updated Index View"}}
    assert_redirected_to documents_path(index_view_id: index_view.id, search_session_token: search_session_token)
    follow_redirect!
    assert_response :success
    documents = assigns(:documents)
    assert_equal 1, documents.count, "filter applied"

    get index_views_path(table_entity_id: @table_entity.id, search_session_token: search_session_token)
    assert_response :success
    index_views = assigns(:index_views)
    assert_equal 3, index_views.count
    assert_select "form[action='#{index_view_path(index_view, search_session_token: search_session_token)}'][method='post']", count: 1

    delete index_view_path(index_view, search_session_token: search_session_token)
    assert_redirected_to documents_path(index_view_id: index_view.id, search_session_token: search_session_token)
    follow_redirect!
    assert_response :success
    documents = assigns(:documents)
    assert_equal 4, documents.count, "back to default index view"
    search_session = assigns(:search_session)
    assert_equal @default_index_view.id.to_s, search_session.index_view_id
  end

  test "changing index_views and searcha and sort persisetance via search session" do
    @active_only_index_view.update(active_filter_id: @filter.id)
    get documents_path
    assert_response :success
    documents = assigns(:documents)
    search_session_token = assigns(:search_session).token
    assert_equal 4, documents.count

    get documents_path(search_session_token: search_session_token, query: {title_cont: "One", s: "title asc"})
    assert_response :success
    documents = assigns(:documents)
    assert_equal 1, documents.count

    get documents_path(index_view_id: @active_only_index_view.id, search_session_token: search_session_token)
    assert_response :success
    documents = assigns(:documents)
    assert_equal 3, documents.count
    search_session = assigns(:search_session)
    assert_nil search_session.sort
    assert_equal({}, search_session.query.to_h)

    get documents_path(search_session_token: search_session_token, query: {title_cont: "Three"})
    assert_response :success
    documents = assigns(:documents)
    assert_equal 1, documents.count
    search_session = assigns(:search_session)
    assert_nil search_session.sort
    assert_equal({"title_cont" => "Three"}, search_session.query.to_h)

    get documents_path(index_view_id: @default_index_view.id, search_session_token: search_session_token)
    assert_response :success
    documents = assigns(:documents)
    assert_equal 1, documents.count
    search_session = assigns(:search_session)
    assert_equal({"title_cont" => "One"}, search_session.query.to_h)
    assert_equal("title asc", search_session.sort)
  end
end
