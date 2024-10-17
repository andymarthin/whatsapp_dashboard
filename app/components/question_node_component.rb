# frozen_string_literal: true

class QuestionNodeComponent < ViewComponent::Base
  include ActionView::RecordIdentifier
  attr_reader :question
  def initialize(question:)
    @question = question
  end

  def render?
    question.present?
  end
end
