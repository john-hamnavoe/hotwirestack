# frozen_string_literal: true

class Tables::RowComponent < ApplicationComponent
  renders_many :cells, Tables::CellComponent
end
