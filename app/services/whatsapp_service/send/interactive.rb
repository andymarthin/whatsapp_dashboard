module WhatsappService::Send
  class Interactive < Base
    def initialize(to, text, interactive)
      @to = to
      @text = text
      @interactive = interactive
      super
    end

    private
    attr_reader :to, :text, :interactive

    def payload
      {
        interactive:
      }
    end

    def type
      "interactive"
    end
  end
end
