class ApplicationService
  include ActionView::Helpers::TranslationHelper
  def initialize(*)
  end

  def self.call(...)
    new(...).call
  end

  private

  def deep_compact(hash)
    hash.each_with_object({}) do |(key, value), result|
      compacted_value = compact_value(value)
      result[key] = compacted_value unless value_is_blank?(compacted_value)
    end
  end

  def compact_value(value)
    value.is_a?(Hash) ? deep_compact(value) : value
  end

  def value_is_blank?(value)
    value.nil? || value.blank? || (value.respond_to?(:empty?) && value.empty?)
  end
end
