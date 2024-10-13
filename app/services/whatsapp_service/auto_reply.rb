module WhatsappService
  class AutoReply < Base
    def initialize(params)
      @params = params
      super
    end

    def call
      initialize_bot if message_type.eql?("text") && room.bot?
      interactive_bot(list) if message_type.eql?("interactive")
    end

    private

    def initialize_bot
      message = "hello what can i help you?"
      button = "Select Question"
      send_list(list, message, button)
    end

    def send_list(list, message, button)
      interactive = Interactive::List.call(build_sections(list), message, button)
      Send::Interactive.call(phone_number, interactive)
    end

    def interactive_bot(list)
      question = find_from_list(list, interactive_id)
      return unless question

      case question["type"]
      when "location"
        latitude = question.dig("options", "latitude")
        longitude = question.dig("options", "longitude")
        Send::Location.call(phone_number, latitude, longitude)
      when "cs"
        message = "Please wait..."
        room.update(bot: false)
        Send::Text.call(to: phone_number, text: message)
      when "list"
        message = question["title"]
        button = "Options"
        list = question["list"]
        send_list(list, message, button)
      else
        answer = question["answer"]
        Send::Text.call(to: phone_number, text: answer)
      end
    end

    def list
      JSON.parse bot_file
    end

    def build_sections(list, title: "Options")
      [
        {
          title: title,
          rows: section_rows(list)
        }
      ]
    end

    def section_rows(list)
      list.map do |row|
        {
          id: row["id"],
          title: row["title"],
          description: row["description"]
        }
      end
    end

    def find_from_list(list, id, prefix = "")
      ids = id.split("#")
      current_id = "#{prefix}#{ids.shift}"
      result = list.find { |row| row["id"] == current_id }

      return nil unless result

      return result if ids.empty?

      if result["list"]
        find_from_list(result["list"], ids.join("#"), "#{current_id}#")
      else
        nil
      end
    end

    def interactive_type
      params.dig("messages", 0, "interactive", "type")
    end

    def interactive_id
       params.dig("messages", 0, "interactive", interactive_type, "id")
    end
  end
end
