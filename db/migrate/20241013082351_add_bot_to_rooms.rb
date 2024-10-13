class AddBotToRooms < ActiveRecord::Migration[8.0]
  def change
    add_column :rooms, :bot, :boolean, default: true
  end
end
