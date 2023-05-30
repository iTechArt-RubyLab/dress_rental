class Product < ApplicationRecord
  require 'elasticsearch/model'
  include Elasticsearch::Model
  DEFAULT_PHOTO_URL = 'default-object-photo.png'.freeze
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  belongs_to :salon
  has_many :rentals, dependent: :destroy
  has_many :users, through: :rentals
  has_one_attached :photo

  validates :name, :price, :description, presence: true

  mapping do
    indexes :name, type: :text
    indexes :description, type: :text
  end

  def self.search(query)
    self.__elasticsearch__.search({
      query: {
        multi_match: {
          query: query,
          fields: [:name, :description]
        }
      }
    })
  end

  def photo_url(_size = :medium)
    if photo.attached?
      photo.variant(resize_to_fit: [800, 800]).processed.url
    else
      DEFAULT_PHOTO_URL
    end
  end
end
