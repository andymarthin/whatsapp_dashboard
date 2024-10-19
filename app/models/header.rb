# == Schema Information
#
# Table name: headers
#
#  id          :bigint           not null, primary key
#  file_data   :text
#  header_type :integer
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  media_id    :string
#  question_id :bigint           not null
#
# Indexes
#
#  index_headers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class Header < ApplicationRecord
  include FileUploader::Attachment(:file)
  include Uploadable

  belongs_to :question
  validates_presence_of :header_type
  enum :header_type, { text: 1, image: 2 }
end
