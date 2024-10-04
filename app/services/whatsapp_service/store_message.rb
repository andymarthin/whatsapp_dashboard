module WhatsappService
  class StoreMessage < Base
    def initialize(params)
      @params = params
      super
    end

    def call
      Message.create(
        message_type: "receive",
        message: raw_message,
        room_id: room&.id,
      )
    end

    private

    def room
      @room ||= begin
        room = Room.find_or_initialize_by(from: phone_number)
        room.name = contact_name
        room.open_until = Time.zone.now + 24.hours
        room.save
        room
      end
    end

    def message_id
      params.dig("messages", 0, "id")
    end
  end
end
