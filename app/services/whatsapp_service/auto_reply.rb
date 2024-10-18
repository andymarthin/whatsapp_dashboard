module WhatsappService
  class AutoReply < Base
    def initialize(params)
      @params = params
      super
    end

    def call
      return unless valid_message_type?

      if text_message_for_bot?
        handle_text_message
      elsif interactive_message?
        handle_interactive_message
      end
    end

    private

    def valid_message_type?
      %w[text interactive].include?(message_type)
    end

    def text_message_for_bot?
      message_type == "text" && room.bot?
    end

    def interactive_message?
      message_type == "interactive"
    end

    def handle_text_message
      data = Kredis.hash(room.id)
      data.to_h.present? ? service_handle(data) : initialize_bot
    end

    def handle_interactive_message
      question = Question.find_by(id: interactive_id)
      interactive_bot(question)
    end

    def initialize_bot
      interactive_bot(Question.first)
    end

    def send_list(question, message = nil)
      footer = question.footer
      button = question.button
      message ||= question.body
      list = question.sections.includes(:questions)
      interactive = Interactive::List.call(build_sections(list), message, button, footer:)
      Send::Interactive.call(phone_number, interactive)
    end

    def interactive_bot(question)
      return initialize_bot if question&.main_menu?
      return unless question

      case question.question_type
      when "location"    then send_location(question)
      when "cs"          then handle_customer_service(question)
      when "list"        then send_list(question)
      when "list_buttons" then send_button_list(question)
      when "previous_menu" then handle_previous_menu(question)
      when "image"       then send_image(question)
      else
        handle_default_question(question)
      end
    end

    def send_location(question)
      latitude = question.dig("options", "latitude")
      longitude = question.dig("options", "longitude")
      Send::Location.call(phone_number, latitude, longitude)
    end

    def handle_customer_service(question)
      room.update(bot: false, open_until: 24.hours.from_now)
      send_text(question.body)
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

    def update_kredis(question)
      Kredis.hash(room.id).update(id: question["id"])
    end

    def send_text(text)
      Send::Text.call(to: phone_number, text: text)
    end

    def send_button_list(question)
      interactive = Interactive::Button.call(question)
      Send::Interactive.call(phone_number, interactive)
    end

    def handle_previous_menu(question)
      interactive_bot(question.parent)
    end

    def send_image(question)
      Send::Media.call(phone_number, question.media_id, "image", caption: question.body)
    end

    def handle_default_question(question)
      update_kredis(question) if question["type"] == "service"
      send_text(question.body) if question.body.present?
    end

    def service_handle(data)
      current_session = data.to_h
      question = Question.find_by(id: current_session[:id])
      return unless question

      service_answer = question["service_answer"]&.gsub("#INPUT", raw_message)

      if question["sections"].present?
        send_list(question)
      elsif service_answer.present?
        send_text(service_answer)
      end

      data.del
    end
  end
end
