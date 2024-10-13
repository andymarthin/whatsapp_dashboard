module WhatsappService
  class GenerateToken < Base
    def call
      hmac_secret = meta_app_secret
      iat ||= Time.zone.now.to_i
      payload = {
        iat: iat
      }
      JWT.encode payload, hmac_secret, "HS256"
    end
  end
end
