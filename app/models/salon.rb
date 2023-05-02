class Salon < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments
end