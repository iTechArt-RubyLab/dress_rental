class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :product
  before_save :generate_confirmation_token

  validates :start_date, presence: true, comparison: { less_than_or_equal_to: :end_date }
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }
  validate :product_available

  enum status: { unconfirmed: 1, confirmed: 2, active: 3, archived: 4 }

  def total_price
    (end_date - start_date + 1).to_i * product.price
  end

  private

  def product_available
    if Rental.where(product_id: product.id)
              .where.not(id: id)
              .where("(start_date, end_date) OVERLAPS (?, ?)", start_date, end_date)
              .exists?
      errors.add(:base, "Product with code #{product.id} is already booked for this period")
    end
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
end
