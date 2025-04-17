require 'rails_helper'

RSpec.describe Reports::PurchasesByGranularity do
  describe '.call' do
    it 'returns grouped purchases by day' do
      client = create(:client)
      product = create(:product)
      create(:purchase, client: client, product: product, created_at: 2.days.ago)
      create(:purchase, client: client, product: product, created_at: 2.days.ago)

      result = described_class.call({ granularity: 'day' })

      expect(result).to be_a(Hash)
      expect(result.keys.first).to be_a(String)
      expect(result.values.first).to be_a(Integer)
    end
  end
end
