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
