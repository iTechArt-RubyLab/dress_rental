class RenameDatabaseColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :product_name, :name
    rename_column :categories, :category_name, :name

    add_column :categories, :description, :text
    add_column :users, :admin, :boolean, default: false

    drop_table :admins
  end
end
