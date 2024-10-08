# frozen_string_literal: true

class Header::CacheStatusComponent < ApplicationComponent
  def render?
    !CacheConfig.cache_enabled?
  end
end
