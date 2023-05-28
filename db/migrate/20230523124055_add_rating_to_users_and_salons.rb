class AddRatingToUsersAndSalons < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rating, :float, null: true, default: nil
    add_column :salons, :rating, :float, null: true, default: nil
  end
end
