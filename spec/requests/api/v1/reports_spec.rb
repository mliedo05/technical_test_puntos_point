require 'rails_helper'

RSpec.describe 'Api::V1::Reports', type: :request do
  let!(:admin) { create(:admin) }
  let!(:token) { Auth::JwtService.encode(user_id: admin.id) }
  let!(:headers) { { 'Authorization': "Bearer #{token}", 'Content-Type': 'application/json' } }

  describe 'GET /api/v1/reports/top_products_by_category' do
    it 'returns success' do
      get '/api/v1/reports/top_products_by_category', headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/reports/top_earning_products_by_category' do
    it 'returns success' do
      get '/api/v1/reports/top_earning_products_by_category', headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/reports/filtered_purchases' do
    it 'returns success' do
      get '/api/v1/reports/filtered_purchases', headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/reports/purchases_by_granularity' do
    it 'returns success' do
      get '/api/v1/reports/purchases_by_granularity', headers: headers
      expect(response).to have_http_status(:ok)
    end
  end
end
