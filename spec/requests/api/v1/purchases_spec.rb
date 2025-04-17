require 'rails_helper'

RSpec.describe 'Purchases API', type: :request do
  let!(:admin) { Admin.create!(email: 'admin@example.com', password: 'password', name: 'Admin') }
  let!(:client) { Client.create!(email: 'client@example.com', password: 'password', name: 'Client') }
  let!(:product) { Product.create!(name: 'Crema', description: 'Hidratante', price: 15.0, stock: 10, admin: admin) }
  let(:headers) { { 'Authorization' => Auth::JwtService.encode(user_id: admin.id) } }

  describe 'GET /api/v1/purchases' do
    before do
      Purchase.create!(product: product, client: client, quantity: 2)
    end

    it 'returns all purchases' do
      get '/api/v1/purchases'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to be >= 1
    end
  end

  describe 'GET /api/v1/purchases/:id' do
    let!(:purchase) { Purchase.create!(product: product, client: client, quantity: 2) }

    it 'returns the purchase' do
      get "/api/v1/purchases/#{purchase.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['quantity']).to eq(2)
    end

    it 'returns 404 if not found' do
      get '/api/v1/purchases/999999'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/v1/purchases' do
    it 'creates a purchase' do
      post '/api/v1/purchases',
           params: {
             purchase: {
               product_id: product.id,
               client_id: client.id,
               quantity: 3
             }
           }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['quantity']).to eq(3)
    end
  end

  describe 'PUT /api/v1/purchases/:id' do
    let!(:purchase) { Purchase.create!(product: product, client: client, quantity: 1) }

    it 'updates the purchase quantity', :aggregate_failures do
      put "/api/v1/purchases/#{purchase.id}",
          params: { purchase: { quantity: 5 } },
          headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['quantity']).to eq(5)
    end
  end

  describe 'DELETE /api/v1/purchases/:id' do
    let!(:purchase) { Purchase.create!(product: product, client: client, quantity: 1) }

    it 'deletes the purchase' do
      delete "/api/v1/purchases/#{purchase.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('purchase successfully deleted.')
    end
  end
end
