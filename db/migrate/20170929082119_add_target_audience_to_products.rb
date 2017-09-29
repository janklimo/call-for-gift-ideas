class AddTargetAudienceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :target_audience, :integer, null: false, default: 0
  end
end
