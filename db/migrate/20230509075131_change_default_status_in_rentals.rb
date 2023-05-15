class ChangeDefaultStatusInRentals < ActiveRecord::Migration[7.0]
  def change
    change_column_default :rentals, :status, from: nil, to: 1
  end
end
