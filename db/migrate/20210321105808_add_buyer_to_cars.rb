class AddBuyerToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :buyer_id, :integer
    add_index :cars, :buyer_id
  end
end
