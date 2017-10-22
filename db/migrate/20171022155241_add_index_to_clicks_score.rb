class AddIndexToClicksScore < ActiveRecord::Migration[5.1]
  def change
    add_index :products, :clicks_score
  end
end
