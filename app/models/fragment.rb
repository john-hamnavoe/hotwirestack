# == Schema Information
#
# Table name: fragments
#
#  id          :bigint           not null, primary key
#  data        :string
#  element     :string
#  meta        :string
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :bigint           not null
#
# Indexes
#
#  index_fragments_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#
class Fragment < ApplicationRecord
  belongs_to :document

  acts_as_list scope: :document

  attr_accessor :saved

  MD_MAPPING = {
    "h1" => "# %{data}",
    "h2" => "## %{data}",
    "h3" => "### %{data}",
    "p" => "%{data}",
    "ol" => "%{data}",
    "ul" => "%{data}",
    "pre" => "```%{meta}\n%{data}\n```",
    "img" => "![%{meta}](%{data})"
  }.freeze

  def to_md
    MD_MAPPING[element] % {data: data, meta: meta}
  end

  def render
    MarkdownRenderer.md_to_html(to_md)
  end

  before_save :strip_newlines_from_headers

  private

  def strip_newlines_from_headers
    if %w[h1 h2 h3].include?(element)
      self.data = data.to_s.gsub(/\s+/, " ").strip
    end
  end
end
