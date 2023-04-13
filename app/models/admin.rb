class Admin < ApplicationRecord
  devise :database_authenticatable, :trackable, :timeoutable, :rememberable, :validatable
end

