module WhatsappService::Interactive
  class List < ApplicationService
    def initialize(sections, body, button, header: nil, footer: nil)
      @sections = sections
      @body = body
      @header = header
      @footer = footer
      @button = button
    end

    def call
      deep_compact(data)
    end

    private
    attr_reader :sections, :button, :body, :header, :footer

    def data
      {
        type: "list",
        header:,
        body: {
          text: body
        },
        footer: {
          text: footer
        },
        action: {
          button:,
          sections:
        }
      }
    end
  end
end
