# frozen_string_literal: true

class QuestionNodeComponent < ViewComponent::Base
  include ActionView::RecordIdentifier
  attr_reader :question, :children, :sections
  def initialize(question:)
    @question = question
    @children = question.children.order(id: :asc)
    @sections = question.sections.order(id: :asc)
  end

  def render?
    question.present?
  end

  def add_new_url
    if question.list?
      new_question_section_path(question)
    else
      new_question_path(parent_id: question.id)
    end
  end

  def can_add_child?
    [ "list", "list_buttons" ].include?(question.question_type)
  end

  def can_view?
    %w[text list list_buttons image].include?(question.question_type)
  end
end
