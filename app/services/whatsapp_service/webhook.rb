module WhatsappService
  class Webhook < Base
    def initialize(params)
      params ||= {} # to avoid nil error
      @params = params.dig("whatsapp", "entry", 0, "changes", 0, "value")
      super
    end

    def call
      return unless sender_is_user?
      return unless message_type&.eql?("text")

      StoreMessage.call(params)
    end

    private

    def sender_is_user?
      !phone_number.eql?(ENV["WHATSAPP_PHONE_NUMBER"])
    end

    def message_type
      params.dig("messages", 0, "type")
    end
  end
end
