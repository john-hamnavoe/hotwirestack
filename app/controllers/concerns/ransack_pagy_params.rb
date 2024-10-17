# RansackPagyParams
#
# This module provides methods for extracting and sanitizing parameters related to Ransack and Pagy.
# It includes methods for querying parameters, sorting parameters, and page parameters.
#
module RansackPagyParams
  extend ActiveSupport::Concern

  private

  def sanitized_query_params
    if query_params.is_a?(ActionController::Parameters)
      query_params.except(:s).permit!.to_h  # Ensure it's a permitted hash
    else
      {}
    end
  end

  def page_params
    params[:page]
  end

  def query_sort_params
    params[:query]&.dig(:s)
  end

  def query_params
    params[:query]
  end

  def index_view_id_params
    params[:index_view_id]
  end
end
