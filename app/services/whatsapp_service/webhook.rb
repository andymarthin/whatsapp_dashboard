module WhatsappService
  class Webhook < Base
    def initialize(params)
      params ||= {} # to avoid nil error
      @params = params.dig("whatsapp", "entry", 0, "changes", 0, "value")
      super
    end

    def call
      return unless sender_is_user?
      return if Message.message_types.keys.exclude?(message_type)

      StoreMessage.call(params)
    end

    private

    def sender_is_user?
      !phone_number.eql?(whatsapp_phone_number)
    end
  end
end
