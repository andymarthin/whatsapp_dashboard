module WhatsappService
  class SendMessage < Base
    def initialize(room_id:, text:)
      @room_id = room_id
      @text = text
      super
    end

    def call
      return unless room

      SendFreeTextMessage.call(to:, text:)
      Message.create(room:, message: text, message_type: "sent")
    end

    private

    attr_reader :room_id, :text

    def room
      @room ||= Room.find room_id
    end

    def to
      @to ||= room.from
    end
  end
end
