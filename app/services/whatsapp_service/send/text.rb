module WhatsappService::Send
  class Text < Base
    def initialize(to:, text:)
      @to = to
      @text = text
      super
    end

    private

    def payload
      {
        text: {
          body: text
        }
      }
    end

    def type
      "text"
    end

    attr_reader :text
  end
end
