module WhatsappService::Send
  class Media < Base
    SUPPORT_TYPES = %W[image]
    def initialize(to, media_id, type, caption: nil)
      @media_id = media_id
      @type = type
      @caption = caption
      @to = to
      super
    end

    def call
      raise WhatsappService::Error, "#{type} not yet support" unless SUPPORT_TYPES.include?(type)

      super
    end

    private
    attr_reader :media_id, :type, :caption

    def payload
      {
        type => {
          id: media_id,
          caption:
        }
      }
    end
  end
end
