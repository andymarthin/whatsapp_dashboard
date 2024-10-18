module WhatsappService
  class StoreAttachment < Base
    require "uri"
    def initialize(params, message)
      @params = params
      @message = message
      super
    end

    def call
      attachment = Attachment.new(message:)
      attachment.name = filename
      attachment.file_attacher.assign(media)
      attachment.save
    end

    private
    attr_reader :message

    def media
      @media ||= begin
        Shrine.remote_url(media_url, headers: { "Authorization" => "Bearer #{whatsapp_access_token}" })
      end
    end

    def media_url
      response = Media::RetrieveMediaUrl.call(media_id)
      response["url"]
    end

    def media_id
      params.dig("messages", 0, message_type, "id")
    end

    def filename
      return unless message_type.eql?("document")

      params.dig("messages", 0, message_type, "filename")
    end
  end
end
