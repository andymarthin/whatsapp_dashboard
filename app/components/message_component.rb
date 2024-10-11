# frozen_string_literal: true

class MessageComponent < ViewComponent::Base
  attr_reader :message
  def initialize(message:)
    @message = message
  end

  def container_class
    unless message.receive_message?
      "justify-end"
    end
  end

  def message_class
    if message.receive_message?
      "px-3.5 py-2 bg-gray-100 rounded-xl justify-start  items-center gap-3 inline-flex"
    else
      "px-3 py-2 bg-indigo-600 rounded-xl"
    end
  end

  def message_time
    if message.created_at.to_date == Date.today
      message.created_at.strftime("%I:%M %p")
    else
      message.created_at.strftime("%d/%m/%Y %I:%M %p")
    end
  end

  def content_component
    case message.message_type
    when "location"
      Message::LocationComponent.new(message:)
    else
      Message::TextComponent.new(message:)
    end
  end
end
