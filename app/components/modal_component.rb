# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  renders_one :header
  renders_one :body
  renders_one :footer
  attr_reader :size, :options
  def initialize(size: :default, **options)
    @size = size
    @options = options
  end

  def size_class
    case size
    when :small
      "max-w-md"
    when :large
      " max-w-4xl"
    when :full
      "max-w-7xl"
    else
      "max-w-lg"
    end
  end
end
