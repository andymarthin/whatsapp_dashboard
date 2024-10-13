module WhatsappService
  class GenerateToken < ApplicationService
    def call
      hmac_secret = ENV["META_APP_SECRET"]
      iat ||= Time.zone.now.to_i
      payload = {
        iat: iat
      }
      JWT.encode payload, hmac_secret, "HS256"
    end
  end
end
