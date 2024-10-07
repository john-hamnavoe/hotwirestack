# frozen_string_literal: true

class Index::ContainerComponentPreview < ViewComponent::Preview
  def default
    render(Index::ContainerComponent.new)
  end
end
