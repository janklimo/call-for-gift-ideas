class RemoveAttachmentFromImages < ActiveRecord::Migration[5.1]
  def self.up
    remove_attachment :products, :image
  end

  def self.down
    change_table :products do |t|
      t.attachment :image
    end
  end
end
