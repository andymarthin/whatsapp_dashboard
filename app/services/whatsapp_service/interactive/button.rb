module WhatsappService::Interactive
  class Button < ApplicationService
    def initialize(question)
      @question = question
      super
    end

    def call
      deep_compact(data)
    end

    private
    attr_reader :question, :list, :body, :header, :footer

    def list
      @list ||= question.children
    end

    def data
      {
        type: "button",
        header: build_header,
        body: {
          text: question.body
        },
        footer: {
          text: question.footer
        },
        action: {
          buttons:
        }

      }
    end

    def build_header
      header = question.header
      nil unless header or %w[text image].include?(header.header_type)

      {
        type: header.header_type,
        header.header_type => header_payload(header)
      }
    end

    def header_payload(header)
      case header.header_type
      when "image"
        { id: header.media_id.presence }
      when "text"
        header.text
      else
        nil
      end
    end

    def buttons
      list.map do |button|
        {
          type: "reply",
          reply: {
            id: button.id,
            title: button.title
          }
        }
      end
    end
  end
end
