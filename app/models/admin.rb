class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable, :recoverable, :rememberable, :validatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  has_many :products
  has_many :categories

end
