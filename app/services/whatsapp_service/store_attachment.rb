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
      attachment.file_attacher.assign(media)
      attachment.save
    end

    private
    attr_reader :message

    def media
      @media ||= begin
        response = get_file
        @attempt += 1
        raise if response.code  >= 500

        if response.code.eql?(200)
          Tempfile.new("media_#{media_id}", binmode: true).tap do |file|
            file.write(response.body)
            file.rewind
          end
        else
          raise if @attempt > 5

          media
        end
      end
    end

    def get_file
      HTTParty.get(
        media_url,
        headers: { "Authorization" => "Bearer #{whatsapp_access_token}" }
      )
    end

    def media_url
      path = "#{api_version}/#{media_id}"
      response = client.get(path)
      body = JSON.parse response.body
      body["url"]
    end

    def media_id
      params.dig("messages", 0, message_type, "id")
    end
  end
end
