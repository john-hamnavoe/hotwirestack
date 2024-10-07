# frozen_string_literal: true

class Index::TableComponentPreview < ViewComponent::Preview
  def default
    render(Index::TableComponent.new)
  end
end
