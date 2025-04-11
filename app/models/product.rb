class Product < ApplicationRecord
  include Normalizable
  belongs_to :admin
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many_attached :images

  normalize_name :name
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
