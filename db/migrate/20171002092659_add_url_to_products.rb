class AddUrlToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :url, :text
  end
end
