# frozen_string_literal: true

class Header::MobileMenuComponentPreview < ViewComponent::Preview
  def default
    render(Header::MobileMenuComponent.new(current_path: "current_path"))
  end
end
