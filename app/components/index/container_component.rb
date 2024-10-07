# frozen_string_literal: true

class Index::ContainerComponent < ApplicationComponent
  renders_one :header
  renders_one :search_form
  renders_one :table

  def call
    content_tag :div, class: "px-4 sm:px-6 lg:px-8" do
      safe_join([header, search_form, table].compact)
    end
  end
end
