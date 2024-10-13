module WhatsappService::Send
  class Base < WhatsappService::Base
    def initialize(...)
      super
    end

    def call
      raise WhatsappService::Error, "To is required" if to.nil?

      path = "#{api_version}/#{phone_number_id}/messages"
      response = client.post(path, build_payload.to_json)
      JSON.parse response.body
    end

    private

    attr_reader :to

    def build_payload
      {
        messaging_product: "whatsapp",
        recipient_type: "individual",
        to: to,
        type:,
        **payload
      }
    end

    def payload
      raise WhatsappService::Error, "Need Implementation"
    end

    def type
      raise WhatsappService::Error, "Need Implementation"
    end
  end
end
