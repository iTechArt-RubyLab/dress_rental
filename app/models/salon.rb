class Salon < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments
  belongs_to :owner, class_name: 'User'

  def update_salon_rating
    product_ids = self.products.pluck(:id)
    average_rating = Rental.rated_by_users_rentals(product_ids).average(:user_rating)
    self.update(rating: average_rating)
  end
end