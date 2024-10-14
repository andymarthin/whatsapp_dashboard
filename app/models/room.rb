# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  bot        :boolean          default(TRUE)
#  from       :string
#  name       :string
#  open_until :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rooms_on_from  (from)
#
class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  scope :open, -> { where(open_until: Time.zone.now..., bot: false) }
  def open?
    return false if open_until.nil? || bot?

    Time.zone.now < open_until
  end
end
