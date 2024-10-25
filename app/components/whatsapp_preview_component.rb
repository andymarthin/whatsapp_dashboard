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
    Redcarpet::Markdown.new(RedcarpetCustom, extensions = {})
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
class RedcarpetCustom < Redcarpet::Render::HTML
  def preprocess(doc)
    doc.gsub("\r\n", "\r\n&nbsp;")
  end

  def list(contents, list_type)
    "<ul class=\"max-w-md list-disc list-inside\">#{contents}<ul/>"
  end

  def paragraph(text)
    "<span>#{text}</span>"
  end
end
