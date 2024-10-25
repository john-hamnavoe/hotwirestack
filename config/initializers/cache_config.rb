module CacheConfig
  def self.cache_enabled?
    !Rails.env.development? || Rails.root.join("tmp/caching-dev.txt").exist?
  end
end
