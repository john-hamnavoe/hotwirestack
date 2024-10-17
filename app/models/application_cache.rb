# You can create additional subclasses as needed, for example:
# class FilterSessionCache < ApplicationCache
#   attr_accessor :filter_params
#
#   class << self
#     private
#
#     def cache_prefix
#       "filter_session"
#     end
#   end
#
#   private
#
#   def to_h
#     super.merge(filter_params: @filter_params)
#   end
# end
#
class ApplicationCache
  attr_reader :token

  # Class-level methods
  class << self
    def read(controller_name, token)
      cached_data = Rails.cache.read(cache_key(controller_name, token))
      new(controller_name, token, cached_data)
    end

    def write(controller_name, token, attributes = {})
      new(controller_name, token, attributes).tap(&:save)
    end

    private

    def cache_key(controller_name, token)
      "#{cache_prefix}_#{controller_name}_#{token}"
    end

    def cache_prefix
      throw NotImplementedError, "Subclass must implement cache_prefix"
    end
  end

  # Instance-level methods
  def initialize(controller_name, token, attributes = {})
    @controller_name = controller_name
    @token = token
    @original_attributes = attributes
    self.attributes = attributes
  end

  def not_found?
    @original_attributes.nil? || @original_attributes.empty?
  end

  def found?
    !not_found?
  end

  def attributes=(attrs)
    return unless attrs

    attrs.each do |key, value|
      if respond_to?(:"#{key}=")
        instance_variable_set(:"@#{key}", value)
      end
    end
  end

  def save
    Rails.cache.write(cache_key, to_h, expires_in: 1.hour)
  end

  def update(attributes)
    self.attributes = attributes
    save
  end

  private

  def cache_key
    self.class.send(:cache_key, @controller_name, @token)
  end

  def to_h
    {token: @token}
  end
end
