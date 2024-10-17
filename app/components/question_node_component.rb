# frozen_string_literal: true

class QuestionNodeComponent < ViewComponent::Base
  attr_reader :question
  def initialize(question:)
    @question = question
  end
end
