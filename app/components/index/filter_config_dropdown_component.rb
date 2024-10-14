# frozen_string_literal: true

class Index::FilterConfigDropdownComponent < Index::BaseConfigComponent
  def bg_colour
    if index_view.active_filter.present?
      "bg-green-300"
    else
      "bg-white"
    end
  end
end
