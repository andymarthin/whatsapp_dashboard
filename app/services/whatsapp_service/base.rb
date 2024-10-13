module WhatsappService
  class Base < ApplicationService
    def initialize(*)
      @whatsapp_access_token = ENV["WHATSAPP_ACCESS_TOKEN"]
      @phone_number_id = ENV["WHATSAPP_PHONE_NUMBER_ID"]
      @api_version = ENV.fetch("WHATSAPP_API_VERSION") { "v20.0" }
      @whatsapp_phone_number = ENV["WHATSAPP_PHONE_NUMBER"]
      @meta_app_secret = ENV["META_APP_SECRET"]
    end

    private

    attr_reader :whatsapp_access_token, :phone_number_id, :params, :api_version, :whatsapp_phone_number, :meta_app_secret

    def client
      @client ||= Faraday.new(url: "https://graph.facebook.com") do |faraday|
        faraday.response :logger, ::Logger.new($stdout), bodies: true
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
        faraday.headers = {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{whatsapp_access_token}"
        }
      end
    end

    def phone_number
      params.dig("messages", 0, "from")
    end

    def raw_message
      params.dig("messages", 0, "text", "body")
    end

    def contact_name
      params.dig("contacts", 0, "profile", "name")
    end

    def message_type
      params.dig("messages", 0, "type")
    end

    def bot_file
      @bot_file ||= File.open(Rails.root("bot.json"))
    end

    def room
      @room ||= Room.find_or_create_by(from: phone_number)
    end
  end
end
