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

  validates :email, :phone, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  validates :phone, format: { with: /\A\+\d{12}\z/, message: 'Number should look like this: +37529xxxxxxx' }
  validates :password, presence: true, length: { minimum: 8 },
                       format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/, message: 'must contain at least one uppercase letter, one lowercase letter, and one digit' }

  attr_accessor :username

  def username
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def update_user_rating
<<<<<<< HEAD
    average_rating = rentals.where.not(salon_rating: nil).average(:salon_rating)
=======
    average_rating = rentals.rated_by_owners_rentals.average(:salon_rating)
>>>>>>> add_rental_archiver
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
