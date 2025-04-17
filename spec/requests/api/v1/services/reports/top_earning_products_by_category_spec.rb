require 'rails_helper'

RSpec.describe Reports::TopEarningProductsByCategory do
  describe '.call' do
    it 'returns products with highest earnings by category' do
      admin = create(:admin)
      category = create(:category, admin: admin)
      product1 = create(:product, price: 100, categories: [category], admin: admin)
      product2 = create(:product, price: 50, categories: [category], admin: admin)
      client = create(:client)

      create(:purchase, product: product1, client: client, quantity: 2, total_price: 200)
      create(:purchase, product: product2, client: client, quantity: 1, total_price: 50)

      result = described_class.call

      expect(result).to be_an(Array)

      expect(result.first).to have_key(:top_earning_products)

      expect(result.first[:top_earning_products].first[:id]).to eq(product1.id)
    end
  end
end
