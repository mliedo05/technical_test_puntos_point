require 'rails_helper'

RSpec.describe 'Auth API', type: :request do
  describe 'POST /api/v1/auth/register' do
    it 'registers a new admin' do
      post '/api/v1/auth/register', params: {
        user_type: 'admin',
        user: {
          email: 'admin@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          name: 'Admin User'
        }
      }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['message']).to include('Admin')
    end

    it 'registers a new client' do
      post '/api/v1/auth/register', params: {
        user_type: 'client',
        user: {
          email: 'client@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          name: 'Client User'
        }
      }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['message']).to include('Client')
    end
  end

  describe 'POST /api/v1/auth/login' do
    let!(:admin) { Admin.create(email: 'admin@example.com', password: 'password123', name: 'Admin User') }
    let!(:client) { Client.create(email: 'client@example.com', password: 'password123', name: 'Client User') }

    it 'logs in as admin' do
      post '/api/v1/auth/login', params: {
        email: 'admin@example.com',
        password: 'password123'
      }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it 'logs in as client' do
      post '/api/v1/auth/login', params: {
        email: 'client@example.com',
        password: 'password123'
      }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it 'fails with wrong credentials' do
      post '/api/v1/auth/login', params: {
        email: 'client@example.com',
        password: 'wrongpassword'
      }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
    end
  end
end
