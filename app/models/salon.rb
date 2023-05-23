class Salon < ApplicationRecord
  before_save :update_rating
  has_many :products, dependent: :destroy
  has_many :comments
  belongs_to :owner, class_name: 'User'

  private

  def update_rating
    RatingCalculator.update_salon_rating(self)
  end
end
