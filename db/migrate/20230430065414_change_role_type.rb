class ChangeRoleType < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :role_type, :integer, using: 'CASE role_type WHEN \'user\' THEN 1 WHEN \'admin\' THEN 2 WHEN \'owner\' THEN 3 END'
  end
end
