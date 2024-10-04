module RoomsHelper
  def message_time(message)
    if message.created_at.to_date == Date.today
      message.created_at.strftime("%I:%M %p")
    else
      message.created_at.strftime("%d/%m/%Y %I:%M %p")
    end
  end
end
