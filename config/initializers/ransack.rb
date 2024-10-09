Ransack.configure do |c|
  # Change default search parameter key name.
  # Default key name is :q
  c.search_key = :query
end

# lib/ransack_extensions.rb
module RansackExtensions
  extend ActiveSupport::Concern

  included do
    def apply_default_sorts(sort_params)
      self.sorts = sort_params if sort_params.present?
      self.sorts = "created_at desc" if sorts.empty?
      self
    end
  end
end

# Include the module into Ransack::Search
Ransack::Search.include(RansackExtensions)
