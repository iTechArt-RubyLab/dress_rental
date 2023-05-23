class RatingCalculator < Patterns::Service
  def self.update_user_rating(user)
    average_rating = user.rentals.where.not(salon_rating: nil).average(:salon_rating)
    user.update(rating: average_rating)
  end

  def self.update_salon_rating(salon)
    product_ids = salon.products.pluck(:id)
    average_rating = Rental.where(product_id: product_ids).where.not(user_rating: nil).average(:user_rating)
    salon.update(rating: average_rating)
  end
end
