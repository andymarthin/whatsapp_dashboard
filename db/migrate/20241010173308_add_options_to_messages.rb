class AddOptionsToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :options, :jsonb
  end
end
