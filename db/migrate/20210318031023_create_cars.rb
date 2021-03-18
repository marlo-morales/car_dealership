class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.integer :condition
      t.integer :price
      t.integer :seller_id

      t.timestamps
    end
  end
end
