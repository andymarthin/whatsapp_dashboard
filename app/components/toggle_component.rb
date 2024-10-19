# frozen_string_literal: true

class ToggleComponent < ViewComponent::Base
  attr_reader :text, :input_html, :options, :value
  def initialize(text:, value:, input_html: {}, **options)
    @text = text
    @input_html = input_html
    @options = options
    @value = value
  end
end
