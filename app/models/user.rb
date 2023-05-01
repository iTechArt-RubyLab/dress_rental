class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :rentals, dependent: :destroy
  has_many :products, through: :rentals
  has_many :comments
  has_one_attached :avatar

  enum role_type: { user: 1, admin: 2, owner: 3 }

  validates :email, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # def set_default_role
  #   self.role ||= Role.find_by_name('user')
  # end

  def avatar_url(style = :thumb)
    if avatar.attached?
      avatar.variant(resize_to_fill: [100, 100])
    else
      'default-avatar.png'
    end
  end
end
