class AddIndexToCarsSeller < ActiveRecord::Migration[5.2]
  def change
    add_index :cars, :seller_id
  end
end
