module WhatsappService::Interactive
  class Button < ApplicationService
    def initialize(list, body, header: nil, footer: nil)
      @list = list
      @body = body
      @header = header
      @footer = footer
    end

    def call
      deep_compact(data)
    end

    private
    attr_reader :list, :body, :header, :footer

    def data
      {
        type: "button",
        header: header,
        body: {
          text: body
        },
        footer: {
          text: footer
        },
        action: {
          buttons:
        }

      }
    end

    def buttons
      list.map do |button|
        {
          type: "reply",
          reply: {
            id: button[:id],
            title: button[:title]
          }
        }
      end
    end
  end
end
