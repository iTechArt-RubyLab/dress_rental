class AddFieldToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :salon_id, :integer
    add_foreign_key :products, :salons, column: :salon_id
  end
end
