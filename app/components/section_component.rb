# frozen_string_literal: true

class SectionComponent < ViewComponent::Base
  attr_reader :question, :section
  def initialize(section:)
    @section = section
    @question = section.question
  end
end
