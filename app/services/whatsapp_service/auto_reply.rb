module WhatsappService
  class AutoReply < Base
    def initialize(params)
      @params = params
      super
    end

    def call
      if message_type.eql?("text") && room.bot?
        initialize_bot
      end

      if message_type.eql?("interactive")
        interactive_bot
      end
    end

    private

    def initialize_bot
      message = "hello what can i help you?"
      button = "Select Question"
      interactive = Interactive::List.call(build_sections, message, button)
      Send::Interactive.call(phone_number, interactive)
    end

    def interactive_bot
      question = find_from_list(interactive_id)
      return unless question

      case question["type"]
      when "location"
        latitude = question.dig("options", "latitude")
        longitude = question.dig("options", "longitude")
        Send::Location.call(phone_number, latitude, longitude)
      when "cs"
        message = "Will connect to customer service"
        room.update(bot: false)
        Send::Text.call(to: phone_number, text: message)
      else
        answer = question["answer"]
        Send::Text.call(to: phone_number, text: answer)
      end
    end

    def list
      @list ||= JSON.parse bot_file
    end

    def build_sections
      [
        {
          title: "Options",
          rows: section_rows
        }
      ]
    end

    def section_rows
      list.map do |row|
        {
          id: row["id"],
          title: row["title"],
          description: row["description"]
        }
      end
    end

    def find_from_list(id)
      list.find { |row| row["id"] == id }
    end

    def interactive_type
      params.dig("messages", 0, "interactive", "type")
    end

    def interactive_id
       params.dig("messages", 0, "interactive", interactive_type, "id")
    end
  end
end
