module CacheConfig
  def self.cache_enabled?
    !Rails.env.development? || File.exist?(Rails.root.join("tmp", "caching-dev.txt"))
  end
end
