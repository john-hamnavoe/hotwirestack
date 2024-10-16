ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    setup :reset_rails_cache
    teardown :reset_rails_cache

    def reset_rails_cache
      Rails.cache.clear
    end
  end
end

class ViewComponent::TestCase
  include ActionView::Helpers::FormHelper  # Include FormHelper to use `form_for`
  include ActionView::Helpers::Tags
end
