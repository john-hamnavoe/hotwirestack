require "ransack/helpers/form_helper"
# frozen_string_literal: true

class Index::SearchFormComponent < ApplicationComponent
  include Ransack::Helpers::FormHelper
  attr_reader :query, :frame, :placeholder

  def initialize(query:, frame:, placeholder: "Search")
    @query = query
    @frame = frame
    @placeholder = placeholder
  end
end
