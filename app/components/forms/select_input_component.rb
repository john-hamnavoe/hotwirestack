# frozen_string_literal: true

class Forms::SelectInputComponent < Forms::BaseComponent
  private attr_reader :options, :include_blank, :html_options

  def initialize(form, field, options:, include_blank: false, html_options: {})
    super(form, field)
    @options = options
    @include_blank = include_blank
    @html_options = html_options
  end

  def call
    form.select field, options, {include_blank: include_blank}, html_options.merge(class: input_class)
  end

  private

  def input_class
    class_names(html_options[:class], rounded_class, "disabled:bg-gray-200 disabled:font-medium relative block w-full appearance-none border border-gray-300 px-2 py-1 text-gray-900 placeholder-gray-500 focus:z-10 focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm")
  end

  def rounded_class
    (html_options[:rounded] == false) ? "rounded-none" : "rounded-md"
  end
end
