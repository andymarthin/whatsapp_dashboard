module WhatsappService::Media
  class RetrieveMediaUrl < WhatsappService::Base
    def initialize(media_id)
      @media_id = media_id
      super
    end

    def call
      path = "#{api_version}/#{media_id}"
      response = client.get(path)
      WhatsappService::ResponseHandler.call(response)
    end

    attr_reader :media_id
  end
end
