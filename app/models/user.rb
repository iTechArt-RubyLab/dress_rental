class User < ApplicationRecord
  DEFAULT_AVATAR_URL = 'default-avatar.png'.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum role_type: { user: 1, admin: 2, owner: 3 }

  has_many :rentals, dependent: :destroy
  has_many :products, through: :rentals
  has_many :comments
  has_one_attached :avatar
  has_many :salons, class_name: 'Salon', foreign_key: 'owner_id', dependent: :destroy

  validates :email, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def update_user_rating
    average_rating = rentals.where.not(salon_rating: nil).average(:salon_rating)
    update(rating: average_rating)
  end

  def avatar_url
    if avatar.attached?
      avatar
    else
      DEFAULT_AVATAR_URL
    end
  end
end
