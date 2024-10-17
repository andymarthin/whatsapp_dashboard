module WhatsappService::Registration
  class Register < WhatsappService::Base
    def initialize(pin)
      @pin = pin
      super
    end

    def call
      path = "/#{api_version}/#{phone_number_id}/register"
      response = client.post(path, payload.to_json)
      JSON.parse response.body
    end

    private
    attr_reader :pin

    def payload
      {
        messaging_product: "whatsapp",
        pin: pin
      }
    end
  end
end
