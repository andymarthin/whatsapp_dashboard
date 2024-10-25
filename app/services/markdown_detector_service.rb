class MarkdownDetectorService < ApplicationService
  PATTERNS = {
    header: /^\#{1,6}\s+.+$/,
    bold: /\*\*[^*]+\*\*|\_{2}[^_]+\_{2}/,
    italic: /\*[^*]+\*|\_[^_]+\_/,
    unordered_list: /^[\s]*[\-\*\+]\s+.+$/,
    ordered_list: /^[\s]*\d+\.\s+.+$/,
    link: /\[([^\]]+)\]\(([^)]+)\)/,
    code: /`[^`]+`|^```[\s\S]*?```$/m,
    blockquote: /^>\s+.+$/
  }

  def initialize(text)
    @text = text
    super
  end

  def call
    PATTERNS.values.any? { |pattern| text.match?(pattern) }
  end

  private

  attr_reader :text, :element_type
end
