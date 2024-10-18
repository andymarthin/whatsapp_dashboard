class ChangeButtonTypeFromQuestions < ActiveRecord::Migration[8.0]
  def change
    change_column(:questions, :button, :string)
  end
end
