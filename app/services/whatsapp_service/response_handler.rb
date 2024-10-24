module WhatsappService
  class ResponseHandler < ApplicationService
    def initialize(response)
      @response = response
      super
    end

    def call
      case response&.status
      when 400..499, 500..599
        message = body.dig("error", "message")
        raise Errors::RequestError.new(message, payload:)
      when 200..299
        body
      else
        nil
      end
    end

    private

    attr_reader :response

    def body
      JSON.parse response.body
    rescue JSON::ParserError
      nil
    end

    def payload
      if response.env.method.eql?(:get)
        response.env[:params]
      else
        response.env[:request_body]
      end
    end
  end
end
