class AddButtonToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :button, :text
  end
end
