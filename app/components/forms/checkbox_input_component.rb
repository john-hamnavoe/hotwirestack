# frozen_string_literal: true

class Forms::CheckboxInputComponent < Forms::BaseComponent
  attr_reader :label, :oninput, :classes, :suppress_label, :read_only, :include_hidden, :data, :checked_value, :unchecked_value

  def initialize(form, field, options = {})
    @label = options[:label]
    @oninput = options[:oninput]
    @classes = options[:classes]
    @suppress_label = options[:suppress_label] || false
    @read_only = options[:read_only] || false
    @include_hidden = options[:include_hidden] || true
    @data = options[:data]
    @checked_value = options[:checked_value] || "1"
    @unchecked_value = options[:unchecked_value] || "0"
    super(form, field)
  end
end
