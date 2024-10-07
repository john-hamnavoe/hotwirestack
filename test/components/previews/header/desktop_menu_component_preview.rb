# frozen_string_literal: true

class Header::DesktopMenuComponentPreview < ViewComponent::Preview
  def default
    render(Header::DesktopMenuComponent.new(current_path: "current_path"))
  end
end
