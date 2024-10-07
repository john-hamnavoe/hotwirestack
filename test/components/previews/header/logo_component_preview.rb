# frozen_string_literal: true

class Header::LogoComponentPreview < ViewComponent::Preview
  def default
    render(Header::LogoComponent.new)
  end
end
