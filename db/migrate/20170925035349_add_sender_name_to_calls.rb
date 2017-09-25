class AddSenderNameToCalls < ActiveRecord::Migration[5.1]
  def change
    add_column :calls, :sender_name, :string
  end
end
