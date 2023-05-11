class AddOwnerToSalons < ActiveRecord::Migration[7.0]
  def change
    add_reference :salons, :owner, foreign_key: { to_table: :users }
  end
end
