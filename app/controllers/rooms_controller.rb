class RoomsController < ApplicationController
  def index
    @rooms = Room.open.order(open_until: :desc)
  end

  def show
    @room = room
    @messages = @room.messages.includes(:attachment).order(created_at: :asc)
  end

  def create
    @room = room
    @message = WhatsappService::SendMessage.call(room_id: @room.id, text: params[:message])
  end

  private

  def room
    @room ||= Room.find params[:room_id].presence || params[:id]
  end
end
