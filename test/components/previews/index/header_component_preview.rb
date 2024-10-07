# frozen_string_literal: true

class Index::HeaderComponentPreview < ViewComponent::Preview
  def default
    render(Index::HeaderComponent.new)
  end
end
