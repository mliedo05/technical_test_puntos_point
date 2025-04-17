require 'rails_helper'

RSpec.describe Reports::FilteredPurchases do
  describe '.call' do
    it 'filters purchases by client' do
      client = create(:client)
      other_client = create(:client)
      product = create(:product)

      purchase1 = create(:purchase, client: client, product: product)
      purchase2 = create(:purchase, client: other_client, product: product)

      result = described_class.call({ client_id: client.id })

      expect(result).to be_an(Array)
      expect(result.map { |p| p[:id] }).to include(purchase1.id)
      expect(result.map { |p| p[:id] }).not_to include(purchase2.id)
    end
  end
end
