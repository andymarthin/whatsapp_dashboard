# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  answer        :text
#  body          :text
#  description   :string
#  footer        :string
#  level         :integer          default(0)
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
  has_many :children, class_name: "Question", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Question", optional: true
  validates_presence_of :question_type, :name
  validates :title, presence: true, if: :parent_list_or_buttons?

  enum :question_type, { text: 1, list: 2, list_buttons: 3, cs: 4, main_menu: 5, previous_menu: 6 }
  enum :status, { draft: 0, publish: 1 }

  before_create :set_level

  def level_alphabet
    alphabets = ("A".."Z").to_a
    alphabets[(level - 1)]
  end

  def parent_node_id
    parent_id.nil? ? "questions" : "questions_#{parent_id}"
  end

  def node_id
    "questions_#{id}"
  end

  def parent_list_or_buttons?
    return false unless parent

    [ "list_buttons", "list" ].include?(parent.question_type)
  end
  private

  def set_level
    self.level = (parent&.level || 0) + 1
  end
end
