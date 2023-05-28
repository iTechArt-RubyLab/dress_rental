class AddRatingToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :user_rating, :integer, null: true, default: nil
    add_column :rentals, :salon_rating, :integer, null: true, default: nil
  end
end
