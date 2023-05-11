class Salon < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
end