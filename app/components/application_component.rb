require "ransack/helpers/form_helper"
class ApplicationComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper
  include Ransack::Helpers::FormHelper
  include CacheConfig
  include SessionHelper
end
