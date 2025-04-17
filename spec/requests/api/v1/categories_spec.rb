require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  let!(:admin) { Admin.create(email: 'admin@example.com', password: 'password123', name: 'Admin') }
  let(:headers) { { 'Authorization' => Auth::JwtService.encode(user_id: admin.id) } }

  describe 'GET /api/v1/categories' do
    before { Category.create(name: 'Test', description: 'Some desc', admin_id: admin.id) }

    it 'returns list of categories' do
      get '/api/v1/categories'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to be > 0
    end
  end

  describe 'POST /api/v1/categories' do
    it 'creates a category' do
      post '/api/v1/categories',
           params: {
             category: {
               name: 'Nueva categoría',
               description: 'Algo útil',
               admin_id: admin.id
             }
           },
           headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('Nueva categoría')
    end
  end

  describe 'PUT /api/v1/categories/:id' do
    let!(:category) { Category.create(name: 'Vieja', description: 'Desc', admin_id: admin.id) }

    it 'updates the category' do
      put "/api/v1/categories/#{category.id}",
          params: { category: { name: 'Nueva' } },
          headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq('Nueva')
    end
  end

  describe 'DELETE /api/v1/categories/:id' do
    let!(:category) { Category.create(name: 'Eliminar', description: 'Bye', admin_id: admin.id) }

    it 'deletes the category' do
      delete "/api/v1/categories/#{category.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('category successfully deleted.')
    end
  end
end
