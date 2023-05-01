class AddRolesAndEditUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role
    add_reference :users, :role, index: true, foreign_key: true
  end
end
