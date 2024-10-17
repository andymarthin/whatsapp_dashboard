class AddLevelToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :level, :integer, default: 0
  end
end
