class AddAdminToUsers < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    add_column :users, :admin, :boolean
    change_column_default :users, :admin, false
    User.unscoped.in_batches do |relation|
      relation.update_all admin: false
      sleep(0.01)
    end
  end

  def down
    remove_column :users, :admin
  end
end
