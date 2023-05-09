class AddDefaultValueToStatusInRentals < ActiveRecord::Migration[7.0]
  def change
    change_column :rentals, :status, :integer, default: 1
  end
end
