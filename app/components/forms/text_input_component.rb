# frozen_string_literal: true

class Forms::TextInputComponent < Forms::BaseComponent
  private attr_reader :form, :field, :type, :placeholder, :autocomplete, :autofocus, :classes, :data, :rounded, :read_only, :oninput, :required

  def initialize(form, field, type, **options)
    super(form, field)

    @type = type
    @placeholder = options[:placeholder]
    @autocomplete = options.fetch(:autocomplete, :off)
    @autofocus = options.fetch(:autofocus, false)
    @classes = options[:classes]
    @data = options[:data]
    @rounded = options.fetch(:rounded, true)
    @read_only = options.fetch(:read_only, false)
    @oninput = options[:oninput]
    @required = options.fetch(:required, false)
  end

  def call
    form.send(method, field, class: input_class, autocomplete: autocomplete, placeholder: placeholder, autofocus: autofocus, data: data, min: min, disabled: read_only, oninput: oninput, required: required)
  end

  private

  def method
    "#{type}_field"
  end

  def min
    (type == :number) ? 0 : nil
  end

  def input_class
    class_names(classes, rounded_class, width_class, "disabled:bg-gray-200 relative block appearance-none border border-gray-300 px-1 py-1 text-gray-900 placeholder-gray-500 focus:z-10 focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm")
  end

  def rounded_class
    rounded ? "rounded-md" : "rounded-none"
  end

  def width_class
    classes&.include?("w-") ? "" : "w-full"
  end
end
