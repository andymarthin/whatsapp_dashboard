class CreateHeaders < ActiveRecord::Migration[8.0]
  def change
    create_table :headers do |t|
      t.references :question, null: false, foreign_key: true
      t.integer :header_type
      t.text :file_data
      t.string :text
      t.string :media_id

      t.timestamps
    end
  end
end
