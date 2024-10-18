# == Schema Information
#
# Table name: sections
#
#  id          :bigint           not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#
# Indexes
#
#  index_sections_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class Section < ApplicationRecord
  belongs_to :question
  has_many :questions, dependent: :destroy

  def node_id
    "section_#{id}_rows"
  end
end
