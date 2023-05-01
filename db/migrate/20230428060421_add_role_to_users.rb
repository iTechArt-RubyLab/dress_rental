class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 1
    remove_column :users, :admin
    remove_column :users, :owner
    drop_table :admin_users
    drop_table :salon_owners
  end
end
