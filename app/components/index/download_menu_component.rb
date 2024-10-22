# frozen_string_literal: true

class Index::DownloadMenuComponent < ApplicationComponent
  def initialize(download_path:)
    @download_path = download_path
  end
end
