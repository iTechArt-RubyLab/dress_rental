class ChangeRentalStatus < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :status
    add_column :rentals, :status, :integer
  end
end
