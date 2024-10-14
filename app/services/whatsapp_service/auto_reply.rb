module WhatsappService
  class AutoReply < Base
    def initialize(params)
      @params = params
      super
    end

    def call
      if message_type.eql?("text") && room.bot?
         data = Kredis.hash(room.id)
         if data.to_h.present?
          service_handle(data)
         else
          initialize_bot
         end
      end
      interactive_bot(questions["sections"]) if message_type.eql?("interactive")
    end

    private

    def initialize_bot
      message = questions["answer"]
      button = questions["button"].presence
      footer = questions["footer"].presence
      header = questions["header"].presence
      send_list(questions["sections"], message, **{ button:, footer:, header: }.compact)
    end

    def send_list(list, message, button: "Options", footer: nil, header: nil)
      interactive = Interactive::List.call(build_sections(list), message, button, footer:, header:)
      Send::Interactive.call(phone_number, interactive)
    end

    def interactive_bot(list)
      return initialize_bot if interactive_id.eql?("init")

      question = find_from_list(list, interactive_id)
      return unless question

      case question["type"]
      when "location"
        latitude = question.dig("options", "latitude")
        longitude = question.dig("options", "longitude")
        Send::Location.call(phone_number, latitude, longitude)
      when "cs"
        message = question["answer"]
        room.update(bot: false, open_until: 24.hours.from_now)
        Send::Text.call(to: phone_number, text: message)
      when "list"
        message = question["answer"]
        list = question["sections"]
        button = question["button"].presence
        footer = question["footer"].presence
        header = question["header"].presence
        send_list(list, message, **{ button:, footer:, header: }.compact)
      else
        if question["type"].eql?("service")
          Kredis.hash(room.id).update(id: question["id"])
        end
        answer = question["answer"]
        Send::Text.call(to: phone_number, text: answer) if answer.present?
      end
    end

    def bot_file
      @bot_file ||= File.open(Rails.root.join("bot.yaml"))
    end

    def questions
      @questions ||= YAML.load(bot_file)
    end

    def build_sections(sections, title: "Options")
      sections.map do |section|
        {
          title: section["title"],
          rows: section_rows(section["list"])
        }
      end
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

    def find_from_list(sections, id, prefix = "")
      list = sections.map { |section| section["list"] }
      list.flatten!
      ids = id.split("#")
      current_id = "#{prefix}#{ids.shift}"
      result = list.find { |row| row["id"] == current_id }

      return nil unless result

      return result if ids.empty?

      if result["sections"]
        find_from_list(result["sections"], ids.join("#"), "#{current_id}#")
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

    def service_handle(data)
      current_session = data.to_h
      question = find_from_list(questions["sections"], current_session["id"])
      service_answer = question["service_answer"]&.gsub("#INPUT", raw_message)
      list = question["sections"]
      if list.present?
        send_list(list, service_answer)
      else
        Send::Text.call(to: phone_number, text: service_answer) if service_answer.present?
      end
      data.del
    end
  end
end
