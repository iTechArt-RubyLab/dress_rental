class Product < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  belongs_to :salon
  has_many :rentals
  has_many :users, through: :rentals
end
