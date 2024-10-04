class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :message_type
      t.text :message

      t.timestamps
    end
  end
end
