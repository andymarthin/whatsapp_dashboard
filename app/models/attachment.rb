# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  file_data  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#
# Indexes
#
#  index_attachments_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
class Attachment < ApplicationRecord
  belongs_to :message
  include FileUploader::Attachment(:file)
end
