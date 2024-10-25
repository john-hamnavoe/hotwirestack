class Documents::FragmentsController < ApplicationController
  before_action :set_fragment, only: [:update, :show, :destroy]

  def show
  end

  def create
    @fragment = Fragment.new(fragment_params)
    @fragment.document_id = params[:document_id]
    if @fragment.valid?
      @fragment.save
    end
    redirect_to(with_search_session_token(edit_document_path(@fragment.document_id, select_fragment: @fragment.reload.id)))
  end

  def update
    @fragment.update(fragment_params)
    @fragment.saved = true

    redirect_to document_fragment_path(@fragment.document_id, @fragment.id)
  end

  def destroy
    @fragment.destroy
    redirect_to with_search_session_token(edit_document_path(@fragment.document_id))
  end

  private

  def set_fragment
    @fragment = Fragment.find(params[:id])
  end

  def fragment_params
    params.require(:fragment).permit(:element, :data, :meta, :position)
  end
end
