class ApplicationService
  include ActionView::Helpers::TranslationHelper
  def initialize(*)
  end

  def self.call(...)
    new(...).call
  end

  private

  def locale(kind)
    t locale_key(kind)
  end

  def locale_key(kind)
    class_name = self.class.name.underscore.split("/").join(".")
    "services.#{class_name}.#{kind}"
  end
end
