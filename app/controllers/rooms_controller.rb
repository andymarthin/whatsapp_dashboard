class RoomsController < ApplicationController
  def index
    @rooms = Room.open.order(open_until: :desc)
  end

  def show
    @room = Room.find params[:id]
    @messages = @room.messages.order(created_at: :asc)
  end

  def create
    @room_id = params[:room_id]
    @message = WhatsappService::SendMessage.call(room_id: @room_id, text: params[:message])
  end
end
