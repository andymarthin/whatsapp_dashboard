# frozen_string_literal: true

class Message::LocationComponent < MessageComponent
  def location
    "#{message.options["latitude"]}, #{message.options["longitude"]}"
  end
end
