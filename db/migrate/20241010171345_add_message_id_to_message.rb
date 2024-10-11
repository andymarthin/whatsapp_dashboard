class AddMessageIdToMessage < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :message_id, :string
    add_column :messages, :sender, :string
  end
end
