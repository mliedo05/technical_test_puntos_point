class Product < ApplicationRecord
  belongs_to :admin
  has_many :product_categories
  has_many :categories, through: :product_categories
end
