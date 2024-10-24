module WhatsappService::Registration
  class Deregister < WhatsappService::Base
    def initialize
      super
    end

    def call
      path = "#{api_version}/#{phone_number_id}/deregister"
      response = client.post(path, {})
      WhatsappService::ResponseHandler.call(response)
    end
  end
end
