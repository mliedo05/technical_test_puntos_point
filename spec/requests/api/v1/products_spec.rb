require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let!(:admin) { Admin.create(email: 'admin@example.com', password: 'password123', name: 'Admin') }
  let(:headers) { { 'Authorization' => Auth::JwtService.encode(user_id: admin.id) } }

  describe 'GET /api/v1/products' do
    before { Product.create(name: 'Shampoo', description: 'Suave', price: 10.0, stock: 5, admin_id: admin.id) }

    it 'returns all products' do
      get '/api/v1/products'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to be > 0
    end
  end

  describe 'GET /api/v1/products/:id' do
    let!(:product) { Product.create(name: 'Shampoo', description: 'Suave', price: 10.0, stock: 5, admin_id: admin.id) }

    it 'returns the product' do
      get "/api/v1/products/#{product.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq('Shampoo')
    end

    it 'returns 404 if not found' do
      get '/api/v1/products/999999'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/v1/products' do
    let!(:category) { Category.create(name: 'Capilar', description: 'Todo para el pelo', admin_id: admin.id) }

    it 'creates a product' do
      post '/api/v1/products',
           params: {
             product: {
               name: 'Acondicionador',
               description: 'Hidratante',
               price: 12.5,
               stock: 10,
               admin_id: admin.id,
               category_ids: [category.id]
             }
           },
           headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('Acondicionador')
    end
  end

  describe 'PUT /api/v1/products/:id' do
    let!(:product) do
      Product.create(name: 'Peine', description: 'Peina bien', price: 5.0, stock: 15, admin_id: admin.id)
    end

    it 'updates the product' do
      put "/api/v1/products/#{product.id}",
          params: {
            product: { name: 'Peine actualizado', price: 6.0 }
          },
          headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq('Peine actualizado')
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    let!(:product) { Product.create(name: 'Gel', description: 'Fijador', price: 8.0, stock: 7, admin_id: admin.id) }

    it 'deletes the product' do
      delete "/api/v1/products/#{product.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('product successfully deleted.')
    end
  end

  describe 'DELETE /api/v1/products/:id/remove_category' do
    let!(:category) { Category.create(name: 'Accesorios', description: 'Peines, etc.', admin_id: admin.id) }
    let!(:product) do
      p = Product.create(name: 'Cepillo', description: 'Redondo', price: 9.0, stock: 4, admin_id: admin.id)
      p.categories << category
      p
    end

    it 'removes a category from the product' do
      delete "/api/v1/products/#{product.id}/remove_category/#{category.id}",
             headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Category removed successfully.')
    end
  end
end
