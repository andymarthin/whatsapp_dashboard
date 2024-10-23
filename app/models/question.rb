# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  answer        :text
#  body          :text
#  button        :string
#  description   :string
#  file_data     :text
#  footer        :string
#  level         :integer          default(0)
#  name          :string
#  question_type :integer
#  status        :integer
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  media_id      :string
#  parent_id     :bigint
#  section_id    :bigint
#
# Indexes
#
#  index_questions_on_parent_id   (parent_id)
#  index_questions_on_section_id  (section_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => questions.id)
#  fk_rails_...  (section_id => sections.id)
#
class Question < ApplicationRecord
  include FileUploader::Attachment(:file)
  include Uploadable

  has_many :children, -> { order(:id) }, class_name: "Question", foreign_key: "parent_id", dependent: :destroy
  has_many :sections, -> { order(:id) }, dependent: :destroy
  has_one :header, dependent: :destroy
  belongs_to :parent, class_name: "Question", optional: true
  belongs_to :section, optional: true
  validates_presence_of :question_type, :name
  validates :title, presence: true, if: :parent_list_or_buttons?
  validate :validate_attributes_by_type

  enum :question_type, { text: 1, list: 2, list_buttons: 3, cs: 4, main_menu: 5, previous_menu: 6, image: 7 }
  enum :status, { draft: 0, publish: 1 }

  accepts_nested_attributes_for :header, reject_if: :all_blank, allow_destroy: true

  before_create :set_level

  def level_alphabet
    alphabets = ("A".."Z").to_a
    alphabets[(level - 1)]
  end

  def parent_node_id
    section_node = section&.node_id
    return section_node if section_node

    parent_id.nil? ? "questions" : "questions_#{parent_id}"
  end

  def node_id
    "questions_#{id}"
  end

  def parent_list_or_buttons?
    return false unless parent

    %w[list_buttons list].include?(parent.question_type)
  end

  def can_have_header?
    %w[list_buttons list].include?(parent.question_type)
  end

  private

  def validate_attributes_by_type
    rules = Question.required_rules[question_type&.to_sym]
    return unless rules

    rules.each do |rule|
      attribute = send(rule)
      if attribute.nil? || attribute&.blank?
        errors.add(rule.to_sym, :blank)
      end
    end
  end

  def self.required_rules
    {
      text: [ "body" ],
      list: [ "body", "button" ],
      list_buttons: [ "body" ],
      image: [ "file" ]
    }
  end

  def set_level
    self.level = (parent&.level || 0) + 1
  end
end
