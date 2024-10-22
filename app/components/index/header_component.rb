# frozen_string_literal: true

class Index::HeaderComponent < ApplicationComponent
  def initialize(title:, action_text:, action_path:, download_path: nil)
    @title = title
    @action_text = action_text
    @action_path = action_path
    @download_path = download_path
  end
end
