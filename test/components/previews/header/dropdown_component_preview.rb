# frozen_string_literal: true

class Header::DropdownComponentPreview < ViewComponent::Preview
  def default
    render(Header::DropdownComponent.new(title: "title", items: "items", mobile: "mobile"))
  end
end
