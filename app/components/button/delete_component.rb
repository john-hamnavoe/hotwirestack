# frozen_string_literal: true

class Button::DeleteComponent < Button::BaseComponent
  def call
    button_to text, path,
      method: :delete,
      data: combined_data,
      class: combined_classes,
      **options.except(:class, :data)
  end

  def default_classes
    "block rounded-md bg-red-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600"
  end

  def combined_data
    {turbo_confirm: "Are you sure you want to delete this?"}.merge(options[:data] || {})
  end
end
