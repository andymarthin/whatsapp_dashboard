# frozen_string_literal: true

class Message::TextComponent < MessageComponent
  def text_class
    if message.receive_message?
      "text-gray-900"
    else
      "text-white"
    end
  end
end
