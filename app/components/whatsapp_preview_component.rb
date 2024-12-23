# frozen_string_literal: true

class WhatsappPreviewComponent < ViewComponent::Base
  attr_reader :question
  def initialize(question:)
    @question = question
  end

  private

  def show_options?
    %w[list_buttons list].include?(question.question_type)
  end

  def markdown
    Redcarpet::Markdown.new(WhatsAppRenderer,
    hard_wrap: true,
    underline: true,
    lax_spacing: true
)
  end

  def children
    question.children
  end

  def show_header_text?
    question.header.present? && question.header.text?
  end

  def header_text
    question.header&.text
  end

  def show_image?
    question.image? || question.header&.image?
  end

  def image_url
    if question.image?
      return question.file_url
    end

    if question.header&.image?
      question.header.file_url
    end
  end
end
class WhatsAppRenderer < Redcarpet::Render::HTML
  def preprocess(doc)
    doc.gsub!(/\*(\w+)\*/m, '**\1**')
    doc.gsub!(/\_(\w+)\_/, '*\1*')
    doc.gsub!("\n", " <br> ")
    doc.gsub("- ", " - ")
  end

  def paragraph(text)
    "#{text}\n\n"
  end

  def list_item(text, _list_type)
    "•⁠  ⁠#{text}\n"
  end

  def header(text, _header_level)
    "#{text}\n\n"
  end

  def linebreak
    "\n "
  end
end
