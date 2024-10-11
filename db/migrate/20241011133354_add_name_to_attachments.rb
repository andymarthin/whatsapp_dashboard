class AddNameToAttachments < ActiveRecord::Migration[8.0]
  def change
    add_column :attachments, :name, :string
  end
end
