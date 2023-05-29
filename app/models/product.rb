class Product < ApplicationRecord
  DEFAULT_PHOTO_URL = 'default-object-photo.png'.freeze
  has_many :product_categories
  has_many :categories, through: :product_categories
  belongs_to :salon
  has_many :rentals
  has_many :users, through: :rentals
  has_one_attached :photo

  validates :name, :price, :description, presence: true

  def photo_url(_size = :medium)
    if photo.attached?
      photo.variant(resize_to_fit: [800, 800]).processed.url
    else
      DEFAULT_PHOTO_URL
    end
  end
end
