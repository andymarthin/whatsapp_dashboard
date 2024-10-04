module WhatsappService
  class GenerateToken < ApplicationService
    def call
      hmac_secret = Rails.application.credentials.jwt_secret_key
      expired = 5.years.from_now
      iat ||= Time.zone.now.to_i
      payload = {
        host: ENV["HOST"],
        exp: expired.to_i,
        iat: iat
      }
      JWT.encode payload, hmac_secret, "HS256"
    end
  end
end
