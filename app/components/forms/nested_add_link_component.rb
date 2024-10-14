# frozen_string_literal: true

class Forms::NestedAddLinkComponent < Button::LinkComponent
  private attr_reader :add_stimulus_actions

  def initialize(title, add_stimulus_actions: nil)
    super(path: "#", text: title, data: data)
    @add_stimulus_actions = add_stimulus_actions
  end

  def data
    {action: "click->nested-form#add_association#{add_stimulus_actions}"}
  end
end
