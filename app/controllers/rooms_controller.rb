class RoomsController < ApplicationController
  before_action :set_room, only: %w[show init_session end_session create]
  def index
    @rooms = Room.open.order(open_until: :desc)
  end

  def show
    @pagy, messages = pagy_countless(@room.messages.includes(:attachment).order(id: :desc), items: 20)
    @messages = messages.reverse
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @message = WhatsappService::SendMessage.call(room_id: @room.id, text: params[:message])
  end

  def init_session
    WhatsappService::Send::Text.call(to:, text: ENV["AGENT_INIT_SESSION"])
    flash[:success] = "Message has been sent!"
    redirect_to room_path(@room, format: :html), status: :see_other
  end

  def end_session
    @room.update(bot: true)
    WhatsappService::Send::Text.call(to:, text: ENV["AGENT_END_SESSION"])
    redirect_to rooms_path, status: :see_other
  end

  private

  def set_room
    @room ||= Room.find params[:room_id].presence || params[:id]
  end

  def to
    @room.from
  end

  def pagy_countless_get_items(collection, pagy) # rubocop:disable Metrics/AbcSize
    fetched = collection.limit(pagy.vars[:items] + 1) # eager load items + 1
    fetched = if params[:last_message_id].present?
                fetched.where("id < ?", params[:last_message_id])
    else
                fetched.offset(pagy.offset)
    end.to_a

    pagy.finalize(fetched.size) # finalize the pagy object
    fetched[0, pagy.vars[:items]]                                              # ignore eventual extra item
  end
end
