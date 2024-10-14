# frozen_string_literal: true

class Forms::CheckboxInputComponent < Forms::BaseComponent
  private attr_reader :label, :oninput, :classes, :suppress_label, :read_only, :include_hidden, :data, :checked_value, :unchecked_value

  def initialize(form, field, **options)
    @label = options[:label]
    @oninput = options[:oninput]
    @classes = options[:classes]
    @suppress_label = options.fetch(:suppress_label, false)
    @read_only = options.fetch(:read_only, false)
    @include_hidden = options.fetch(:include_hidden, true)
    @data = options[:data]
    @checked_value = options[:checked_value] || "1"
    @unchecked_value = options[:unchecked_value] || "0"
    super(form, field)
  end
end
