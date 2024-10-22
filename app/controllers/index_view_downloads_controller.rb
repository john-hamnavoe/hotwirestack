class IndexViewDownloadsController < ApplicationController
  def create
    GenerateCsvJob.perform_later(params[:records], params[:index_view])
    redirect_to with_search_session_token(documents_path)
  end
end
