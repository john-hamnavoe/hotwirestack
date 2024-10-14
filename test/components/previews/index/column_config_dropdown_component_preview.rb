# frozen_string_literal: true

class Index::ConfigDropdownsComponentPreview < ViewComponent::Preview
  def default
    render(Index::ConfigDropdownsComponent.new(index_view: "index_view", refresh_frame: "refresh_frame", refresh_path: "refresh_path"))
  end
end
