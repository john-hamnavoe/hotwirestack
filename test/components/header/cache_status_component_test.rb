# frozen_string_literal: true

require "test_helper"

class Header::CacheStatusComponentTest < ViewComponent::TestCase
  def test_component_does_not_render_when_cache_is_enabled
    redefine_cache_enabled(true) do
      component = Header::CacheStatusComponent.new

      assert_not component.render?
    end
  end

  def test_component_renders_when_cache_is_disabled
    redefine_cache_enabled(false) do
      component = Header::CacheStatusComponent.new

      assert_predicate component, :render?
    end
  end

  def test_component_content
    redefine_cache_enabled(false) do
      render_inline(Header::CacheStatusComponent.new)

      assert_selector "div", class: "text-sm pl-4 text-red-500"
      assert_selector "p", text: "Cache is disabled"
    end
  end

  private

  def redefine_cache_enabled(value)
    CacheConfig.singleton_class.class_eval do
      alias_method :original_cache_enabled?, :cache_enabled?
      define_method(:cache_enabled?) { value }
    end
    yield
  ensure
    CacheConfig.singleton_class.class_eval do
      alias_method :cache_enabled?, :original_cache_enabled?
    end
  end
end
