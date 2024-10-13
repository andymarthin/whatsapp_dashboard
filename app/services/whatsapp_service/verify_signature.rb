module WhatsappService
  class VerifySignature < Base
    def initialize(request)
      @request = request
    end

    def call
      raise Error, "Signature Not found" unless signature
      raise Error, "Signature Not Match" unless signature.eql?(expectedHash)

      true
    end

    private
    attr_reader :request

    def expectedHash
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), ENV["META_APP_SECRET"], payload)
    end

    def payload
      request.raw_post
    end

    def signature
      request.headers["X-Hub-Signature-256"]&.gsub("sha256=", "")
    end
  end
end
