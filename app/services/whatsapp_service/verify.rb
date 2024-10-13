module WhatsappService
  class Verify < Base
    def initialize(token)
      @token = token
      super
    end

    def call
      hmac_secret = meta_app_secret
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
