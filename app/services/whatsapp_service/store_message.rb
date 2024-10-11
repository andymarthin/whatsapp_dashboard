module WhatsappService
  class StoreMessage < Base
    MEDIA_TYPES = %w[image video]
    def initialize(params)
      @params = params
      super
    end

    def call
      ActiveRecord::Base.transaction do
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

    def room
      @room ||= begin
        room = Room.find_or_initialize_by(from: phone_number)
        room.name = contact_name
        room.open_until = 24.hours.from_now
        room.save
        room
      end
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
