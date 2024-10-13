class ApplicationService
  include ActionView::Helpers::TranslationHelper
  def initialize(*)
  end

  def self.call(...)
    new(...).call
  end

  private

  def deep_compact(h)
    h.each { |_, v| deep_compact(v) if v.is_a? Hash }.reject! { |_, v| v.nil? || v.empty? }
  end
end
