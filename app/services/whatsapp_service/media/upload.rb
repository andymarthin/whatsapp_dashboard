module WhatsappService::Media
  class Upload < WhatsappService::Base
    def initialize(file_path)
       @file_path = file_path
       super
    end

    def call
      client.request :multipart
      client.headers["Content-Type"] = "multipart/form-data"
      path = "/#{api_version}/#{phone_number_id}/media"
      response = client.post(path, payload)
      WhatsappService::ResponseHandler.call(response)
    end

    private
    attr_reader :file_path

    def payload
      {
        messaging_product: "whatsapp",
        file: Faraday::Multipart::FilePart.new(
          File.open(file_path),
          mime_type
        )
      }
    end

    def mime_type
      Marcel::MimeType.for Pathname.new(file_path)
    end
  end
end
