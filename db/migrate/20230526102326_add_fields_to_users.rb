class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string

    remove_column :users, :username, :string
  end

  def down
    add_column :users, :username, :string

    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :address
  end
end
