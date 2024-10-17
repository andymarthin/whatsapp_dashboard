# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  answer        :text
#  body          :text
#  description   :string
#  footer        :string
#  name          :string
#  question_type :integer
#  status        :integer
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  parent_id     :bigint
#
# Indexes
#
#  index_questions_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => questions.id)
#
class Question < ApplicationRecord
  has_many :children, class_name: "Question", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Question", optional: true
end
