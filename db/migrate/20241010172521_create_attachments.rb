class CreateAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :attachments do |t|
      t.references :message, null: false, foreign_key: true
      t.text :file_data

      t.timestamps
    end
  end
end
