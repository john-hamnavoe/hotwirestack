# frozen_string_literal: true

class Forms::FooterComponent < ApplicationComponent
  private attr_reader :form, :cancel_path, :include_active

  def initialize(form, cancel_path, include_active = true)
    @form = form
    @cancel_path = cancel_path
    @include_active = include_active
  end

  def button_width
    length_submit = t("buttons.submit").length
    length_cancel = t("buttons.cancel").length

    max_length = [length_submit, length_cancel].max

    if max_length < 9
      "w-20"
    elsif max_length < 13
      "w-28"
    elsif max_length < 17
      "w-36"
    elsif max_length < 25
      "w-52"
    elsif max_length < 33
      "w-60"
    else
      "w-auto"
    end
  end
end
