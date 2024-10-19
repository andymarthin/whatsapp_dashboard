module WhatsappService::Interactive
  class List < ApplicationService
    def initialize(question, body)
      @sections = question.sections.includes(:questions)
      @body = body
      @header = question.header
      @footer = question.footer
      @button = question.button
    end

    def call
      deep_compact(data)
    end

    private
    attr_reader :sections, :button, :body, :header, :footer

    def data
      {
        type: "list",
        header: build_header,
        body: {
          text: body
        },
        footer: {
          text: footer
        },
        action: {
          button:,
          sections: build_sections
        }
      }
    end

    def build_header
      return unless header || header&.text?

      {
          type: "text",
          text: header.text
      }
    end

    def build_sections
      sections.map do |section|
        {
          title: section.title,
          rows: section_rows(section.questions)
        }
      end
    end

    def section_rows(list)
      list.map do |question|
        {
          id: question.id,
          title: question.title,
          description: question.description
        }
      end
    end
  end
end
