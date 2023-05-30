class Salon < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  def update_salon_rating
    product_ids = products.pluck(:id)
    average_rating = Rental.rated_by_users_rentals(product_ids).average(:user_rating)
    update(rating: average_rating)
  end
end
