class Product < ApplicationRecord
  belongs_to :admin
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
end
