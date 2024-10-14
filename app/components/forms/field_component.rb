# frozen_string_literal: true

class Forms::FieldComponent < ApplicationComponent
  renders_one :input, types: {
    text: ->(**args) { Forms::TextInputComponent.new(form, field, :text, **args) },
    number: ->(**args) { Forms::TextInputComponent.new(form, field, :number, **args) },
    check_box: ->(**args) { Forms::CheckboxInputComponent.new(form, field, **args) },
    select: ->(**args) { Forms::SelectInputComponent.new(form, field, **args) }
  }

  private attr_reader :form, :field, :label, :help, :label_class, :span, :inline_classes

  def initialize(form, field, **options)
    @form = form
    @field = field
    @label = options[:label]
    @help = options[:help]
    @label_class = options[:label_class]
    @span = options[:span]
    @inline_classes = options[:inline_classes]
  end

  def label_classes
    @label_class || "block text-sm font-medium leading-6 text-gray-900"
  end

  def span_class
    case @span
    when :full
      "col-span-full"
    when :two_thirds
      "xl:col-span-4"
    when :half
      "xl:col-span-3"
    when :third
      "xl:col-span-2"
    when :sixth
      "xl:col-span-1"
    else
      ""
    end
  end

  def div_class
    "#{span_class} #{inline_classes}"
  end
end
