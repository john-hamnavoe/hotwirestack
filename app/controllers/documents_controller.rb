class DocumentsController < ApplicationController
  include SearchSessionManageable
  index_viewable Document.table_entity
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

    if @document.save
      redirect_to with_search_session_token(documents_path), notice: "Document was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    if @document.update(document_params)
      redirect_to with_search_session_token(documents_path), notice: "Document was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy!

    redirect_to with_search_session_token(documents_path), status: :see_other, notice: "Document was successfully destroyed."
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
