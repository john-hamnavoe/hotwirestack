# frozen_string_literal: true

class Tables::TableComponent < ApplicationComponent
  renders_many :headers, Tables::HeaderComponent
  renders_many :rows, Tables::RowComponent
end
