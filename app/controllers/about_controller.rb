class AboutController < ApplicationController
  include IndexViewable
  index_viewable Document.table_entity

  def index
  end
end
