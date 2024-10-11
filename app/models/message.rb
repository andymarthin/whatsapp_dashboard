# == Schema Information
#
# Table name: messages
#
#  id           :bigint           not null, primary key
#  message      :text
#  message_type :integer
#  options      :jsonb
#  sender       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  message_id   :string
#  room_id      :bigint           not null
#
# Indexes
#
#  index_messages_on_room_id  (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#
class Message < ApplicationRecord
  belongs_to :room
  enum :message_type, { text: 1, location: 2 }

  has_one :attachment, dependent: :destroy

  def receive_message?
    sender.eql?(room.from)
  end

  after_create_commit {
    broadcast_append_to(
      "room_#{room_id}",
      partial: "rooms/message",
      target: "messages",
      locals: {
        message: self
      },
    )
  }
end
