class Category < ApplicationRecord
  include Normalizable
  belongs_to :admin
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories

  normalize_name :name
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
