class DocumentsController < ApplicationController
  include SearchSessionManageable
  index_viewable Document
  before_action :set_document, only: %i[show edit update destroy]

  # GET /documents or /documents.json
  def index
    @query, @pagy, @documents = apply_search_session(Document, @index_view)
  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)

    handle_create(@document, document_params, documents_path)
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    handle_update(@document, document_params, documents_path)
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    handle_destroy(@document, documents_path)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.expect(document: [:title, :active])
  end
end
