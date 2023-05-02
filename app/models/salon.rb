class Salon < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  validate :salon_owner

  private

  def salon_owner
    errors.add(:owner_id, 'must be a salon owner') unless owner&.role_type.owner?
  end
end