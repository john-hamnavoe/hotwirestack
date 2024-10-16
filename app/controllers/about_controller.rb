class AboutController < ApplicationController
  include IndexViewable
  # doing this to test index_viewable without the need to set up large amounts of data
  index_viewable Document

  def index
  end
end
