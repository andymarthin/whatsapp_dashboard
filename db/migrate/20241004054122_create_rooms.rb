class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.datetime :open_until
      t.string :from

      t.timestamps
    end
    add_index :rooms, :from
  end
end
