module WhatsappService
  class StoreMessage < Base
    MEDIA_TYPES = Message.message_types.keys.excluding("text", "location")
    def initialize(params, bot: true)
      @bot = bot
      @params = params
      super
    end

    def call
      ActiveRecord::Base.transaction do
        room = update_room
        message = Message.create(
          message: raw_message,
          room_id: room&.id,
          sender: phone_number,
          options:,
          message_id:,
          message_type:
        )
        if MEDIA_TYPES.include?(message_type)
          StoreAttachment.call(params, message)
        end
      end
    end

    private
    attr_reader :bot

    def update_room
      room.name = contact_name
      room.open_until = 24.hours.from_now
      room.bot = bot
      room.save
      room
    end

    def options
      return {} unless message_type.eql?("location")

      {
        latitude: location["latitude"],
        longitude: location["longitude"]
      }
    end

    def message_id
      params.dig("messages", 0, "id")
    end

    def location
      params.dig("messages", 0, "location")
    end
  end
end
