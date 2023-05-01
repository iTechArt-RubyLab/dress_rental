class DeleteRoleReferenceFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :users, :roles
    remove_index :users, :role_id
    remove_column :users, :role_id
    drop_table :roles
    add_column :users, :role_type, :string
  end
end
