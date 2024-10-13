module WhatsappService
  class VerifySignature < Base
    def initialize(request)
      @request = request
      super
    end

    def call
      raise Error, "Signature Not found" unless signature
      raise Error, "Signature Not Match" unless signature.eql?(expected_hash)

      true
    end

    private
    attr_reader :request

    def expected_hash
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), meta_app_secret, payload)
    end

    def payload
      request.raw_post
    end

    def signature
      request.headers["X-Hub-Signature-256"]&.gsub("sha256=", "")
    end
  end
end
