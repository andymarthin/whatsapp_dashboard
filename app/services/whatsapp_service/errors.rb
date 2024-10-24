module WhatsappService::Errors
  class Error < StandardError
    def initialize(message = nil)
      super(message)
    end
  end
  class SignatureError < Error;end
end
