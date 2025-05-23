class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :client

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_total_price

  private

  def calculate_total_price
    return unless product && quantity.present?

    self.total_price = product.price * quantity
  end
end
