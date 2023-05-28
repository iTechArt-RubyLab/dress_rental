class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :product
  before_validation :generate_confirmation_token
  before_validation :calculate_total_price

  validates :start_date, presence: true, comparison: { less_than_or_equal_to: :end_date }
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }
  validate :product_available

  enum status: { unconfirmed: 1, confirmed: 2, archived: 3 }

  scope :rated_by_users_rentals, ->(product_ids) { Rental.where(product_id: product_ids).where.not(user_rating: nil) }
  scope :rated_by_owners_rentals, -> { where.not(salon_rating: nil) }
  
  def expired?
    end_date < Time.zone.today
  end

  private

  def calculate_total_price
    self.total_price = RentalPriceCalculator.call(start_date:, end_date:,
                                                  product_price: product.price).result
  end

  def product_available
    if Rental.where(product_id: product.id)
             .where.not(id:)
             .where('(start_date, end_date) OVERLAPS (?, ?)', start_date, end_date)
             .exists?
      errors.add(:base, "Product with code #{product.id} is already booked for this period")
    end
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
end
