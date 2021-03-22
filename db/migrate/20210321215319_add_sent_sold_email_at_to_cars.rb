class AddSentSoldEmailAtToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :sent_sold_email_at, :datetime
  end
end
