# frozen_string_literal: true

class Header::MainComponentPreview < ViewComponent::Preview
  def default
    render(Header::MainComponent.new(current_path: "current_path"))
  end
end
