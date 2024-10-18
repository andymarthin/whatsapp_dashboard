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
      interactive_bot if message_type.eql?("interactive")
    end

    private

    def initialize_bot
      question = Question.first
      interactive_bot(question)
    end

    def send_list(question, message = nil)
      footer = question.footer
      button = question.button
      message ||= question.body
      list = question.sections.includes(:questions)
      interactive = Interactive::List.call(build_sections(list), message, button, footer:)
      Send::Interactive.call(phone_number, interactive)
    end

    def interactive_bot(question = nil)
      question ||= Question.find_by(id: interactive_id)
      return initialize_bot if question&.main_menu?

      return unless question

      case question.question_type
      when "location"
        latitude = question.dig("options", "latitude")
        longitude = question.dig("options", "longitude")
        Send::Location.call(phone_number, latitude, longitude)
      when "cs"
        message = question.body
        room.update(bot: false, open_until: 24.hours.from_now)
        Send::Text.call(to: phone_number, text: message)
      when "list"
        send_list(question)
      when "list_buttons"
        interactive = Interactive::Button.call(question)
        Send::Interactive.call(phone_number, interactive)

      when previous_menu
        parent = question.parent
        interactive_bot(parent)
      else
        if question["type"].eql?("service")
          Kredis.hash(room.id).update(id: question["id"])
        end
        answer = question.body
        Send::Text.call(to: phone_number, text: answer) if answer.present?
      end
    end

    def build_sections(sections, title: "Options")
      sections.map do |section|
        {
          title: section.title,
          rows: section_rows(section.questions)
        }
      end
    end

    def section_rows(list)
      list.map do |question|
        {
          id: question.id,
          title: question.title,
          description: question.description
        }
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
      question = Question.find_by(id: current_session[:id])
      return unless question

      service_answer = question["service_answer"]&.gsub("#INPUT", raw_message)
      list = question["sections"]
      if list.present?
        send_list(question)
      else
        Send::Text.call(to: phone_number, text: service_answer) if service_answer.present?
      end
      data.del
    end
  end
end
