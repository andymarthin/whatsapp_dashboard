module WhatsappService
  class StoreAttachment < Base
    require "uri"
    def initialize(params, message)
      @params = params
      @message = message
      @attempt = 0
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
        Tempfile.new("media_#{media_id}", binmode: true).tap do |file|
          file.write(get_file)
          file.rewind
        end
      end
    end

    def get_file
      @attempt += 1

      response = HTTParty.get(
        media_url,
        headers: { "Authorization" => "Bearer #{whatsapp_access_token}" }
      )
      raise if response.code  >= 500

      if response.code.eql?(200)
        response.body
      else
        raise if @attempt > 5

        get_file
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
