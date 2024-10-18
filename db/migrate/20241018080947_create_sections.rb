class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.references :question, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
