module WhatsappService::Send
  class Media < Base
    def initialize(to)
      @to = to
      super
    end

    private

    def payload
      {}
    end
  end
end
