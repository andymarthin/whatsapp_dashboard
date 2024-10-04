module WhatsappService
  class SendFreeTextMessage < Base
    def initialize(to:, text:)
      @to = to
      @text = text
      super
    end

    def call
      path = "#{api_version}/#{phone_number_id}/messages"
      client.post(path, payload.to_json)
    end

    private

    def payload
      {
        messaging_product: "whatsapp",
        recipient_type: "individual",
        to: to,
        type: "text",
        text: {
          body: text
        }
      }
    end

    attr_reader :to, :text
  end
end
