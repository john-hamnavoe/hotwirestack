require "redcarpet"
require "rouge"
require "rouge/plugins/redcarpet"

module MarkdownRenderer
  # Our own custom renderer
  class CustomHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def rouge_formatter(lexer)
      Rouge::Formatters::HTMLLegacy.new(
        css_class: "line-numbers language-#{lexer.tag.strip}"
      )
    end
  end

  def self.md_to_html(content, assigns = {})
    # Render the result via Redcarpet, using our Custom Renderer
    rendered_content = Redcarpet::Markdown.new(
      CustomHTML.new(link_attributes: {target: "_blank", rel: "noopener"}),
      fenced_code_blocks: true,
      autolink: true,
      superscript: true,
      no_intra_emphasis: true,
      space_after_headers: false,
      highlight: true,
      with_toc_data: true
    ).render(content)

    ActionController::Base.helpers.sanitize(rendered_content, tags: allowed_tags, attributes: allowed_attributes)
  end

  def self.allowed_tags
    %w[p br img h1 h2 h3 h4 h5 h6 strong em del pre code blockquote ol ul li a span div]
  end

  def self.allowed_attributes
    %w[href src alt title class]
  end
end
