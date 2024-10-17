class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :title
      t.string :description
      t.text :body
      t.integer :question_type
      t.integer :status
      t.string :footer
      t.text :answer
      t.references :parent, null: true, foreign_key: { to_table: :questions }

      t.timestamps
    end
  end
end
