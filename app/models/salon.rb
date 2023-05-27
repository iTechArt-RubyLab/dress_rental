class Salon < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments
  belongs_to :owner, class_name: 'User'

  def update_salon_rating
<<<<<<< HEAD
    product_ids = products.pluck(:id)
    average_rating = Rental.where(product_id: product_ids).where.not(user_rating: nil).average(:user_rating)
    update(rating: average_rating)
=======
    product_ids = self.products.pluck(:id)
    average_rating = Rental.rated_by_users_rentals(product_ids).average(:user_rating)
    self.update(rating: average_rating)
>>>>>>> add_rental_archiver
  end
end