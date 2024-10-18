# frozen_string_literal: true

class SectionComponent < ViewComponent::Base
  attr_reader :question, :section, :questions
  def initialize(section:)
    @section = section
    @question = section.question
    @questions = section.questions.order(id: :asc)
  end
end
