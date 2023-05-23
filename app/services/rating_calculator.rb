class RatingCalculator < Patterns::Service
  def self.update_user_rating(user)
    average_rating = user.rentals.average(:user_rating)
    user.update(rating: average_rating)
  end

  def self.update_salon_rating(salon)
    average_rating = salon.rentals.average(:salon_rating)
    salon.update(rating: average_rating)
  end
end
