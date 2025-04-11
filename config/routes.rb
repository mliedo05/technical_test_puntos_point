Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :clients, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      post 'auth/login', to: 'auth#login'
      post 'auth/register', to: 'auth#register'
    end
  end
end
