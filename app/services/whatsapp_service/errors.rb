module WhatsappService::Errors
  class Error < StandardError
    def initialize(message = nil)
      super(message)
    end
  end
  class SignatureError < Error;end
  class RequestError <  Error
    attr_reader :payload

    def initialize(message = nil, payload: nil)
      @payload = payload

      super(message)
    end
  end
end
