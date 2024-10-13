module WhatsappService
  class Webhook < Base
    MESSAGE_TYPES = [ *Message.message_types.keys, "interactive" ]
    def initialize(params)
      params ||= {} # to avoid nil error
      @params = params.dig("whatsapp", "entry", 0, "changes", 0, "value")
      super
    end

    def call
      return unless sender_is_user?
      return if MESSAGE_TYPES.exclude?(message_type)

      if room.bot?
        AutoReply.call(params)
      else
        StoreMessage.call(params)
      end
    end

    private

    def sender_is_user?
      !phone_number.eql?(whatsapp_phone_number)
    end
  end
end
