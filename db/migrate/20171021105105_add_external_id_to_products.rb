class AddExternalIdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :external_id, :integer
    add_index :products, :external_id, unique: true
  end
end
