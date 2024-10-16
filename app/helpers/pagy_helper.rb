#
# Override the pagy_helper to switch off the turbo prefetch

module PagyHelper
  include Pagy::Frontend

  PAGE_TOKEN = "__pagy_page__"

  # Generic pagination: it returns the html with the series of links to the pages
  def pagy_nav(pagy, id: nil, aria_label: nil, **vars)
    id = %( id="#{id}") if id
    a = pagy_anchor(pagy, **vars)

    html = %(<nav#{id} class="pagy nav" #{nav_aria_label(pagy, aria_label:)}>#{
                 prev_a(pagy, a)})
    pagy.series(**vars).each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << case item
      when Integer
        a.call(item)
      when String
        %(<a role="link" aria-disabled="true" aria-current="page" data-turbo-prefetch="false" class="current">#{pagy.label_for(item)}</a>)
      when :gap
        %(<a role="link" aria-disabled="true" data-turbo-prefetch="false" class="gap">#{pagy_t("pagy.gap")}</a>)
      else
        raise InternalError, "expected item types in series to be Integer, String or :gap; got #{item.inspect}"
      end
    end
    html << %(#{next_a(pagy, a)}</nav>)
  end

  def pagy_anchor(pagy, anchor_string: nil, **vars)
    anchor_string &&= %( #{anchor_string})
    left, right = %(<a#{anchor_string} href="#{pagy_url_for(pagy, PAGE_TOKEN, **vars)}").split(PAGE_TOKEN, 2)
    # lambda used by all the helpers
    lambda do |page, text = pagy.label_for(page), classes: nil, aria_label: nil|
      classes = %( class="#{classes}") if classes
      aria_label = %( aria-label="#{aria_label}") if aria_label
      data_turbo_prefetch = %( data-turbo-prefetch="false")
      %(#{left}#{page}#{right}#{classes}#{aria_label}#{data_turbo_prefetch}>#{text}</a>)
    end
  end
end
