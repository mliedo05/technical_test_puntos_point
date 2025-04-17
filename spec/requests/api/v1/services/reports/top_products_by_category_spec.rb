require 'rails_helper'

RSpec.describe Reports::TopProductsByCategory do
  describe '.call' do
    it 'returns a list of top products by category' do
      admin = create(:admin)
      category = create(:category, admin: admin)
      product1 = create(:product, price: 100, categories: [category], admin: admin)
      product2 = create(:product, price: 50, categories: [category], admin: admin)
      client = create(:client)

      create(:purchase, product: product1, client: client, quantity: 2)
      create(:purchase, product: product2, client: client, quantity: 1)

      result = described_class.call

      expect(result).to be_an(Array)
      expect(result.first[:category_id]).to eq(category.id)
      expect(result.first[:top_products].first[:id]).to eq(product1.id)
    end
  end
end
