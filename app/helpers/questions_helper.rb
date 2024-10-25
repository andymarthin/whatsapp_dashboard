module QuestionsHelper
  def show_header?(header)
    return false unless header

    header.persisted? || header.errors.present? || header.header_type.present?
  end
end
