# frozen_string_literal: true

class WhatsappPreviewComponent < ViewComponent::Base
  def initialize(question:)
    @question = question
  end
end
