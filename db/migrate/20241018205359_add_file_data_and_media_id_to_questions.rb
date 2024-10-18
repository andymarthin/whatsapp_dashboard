class AddFileDataAndMediaIdToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :file_data, :text
    add_column :questions, :media_id, :string
  end
end
