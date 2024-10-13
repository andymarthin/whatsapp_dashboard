module WhatsappService
  class Verify < ApplicationService
    def initialize(token)
      @token = token
    end

    def call
      hmac_secret = Rails.application.credentials.jwt_secret_key
      JWT.decode(
        token,
        hmac_secret,
        true
      )

    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => e
      raise Authentication::Error.new e.message
    end

    private

    attr_reader :token
  end
end
