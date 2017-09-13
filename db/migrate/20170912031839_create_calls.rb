class CreateCalls < ActiveRecord::Migration[5.1]
  def change
    create_table :calls do |t|
      t.string :slug
      t.string :recipient_name
      t.string :recipient_email
      t.string :sender_email
      t.integer :status, null: false, default: 0
      t.text :preferences, array: true, default: []

      t.timestamps
    end

    add_index :calls, :slug, unique: true
  end
end
