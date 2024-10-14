# frozen_string_literal: true

class Index::ContainerComponent < ApplicationComponent
  renders_one :header, Index::HeaderComponent
  renders_one :search_form, Index::SearchFormComponent
  renders_one :table, Index::TableComponent

  def call
    content_tag :div, class: "px-4 sm:px-6 lg:px-8" do
      safe_join([header, search_form, table].compact)
    end
  end
end
