Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show, :create, :update, :destroy] do
        member do
          delete 'remove_category/:category_id', to: 'products#remove_category'
        end
      end
      resources :clients, only: [:index, :show, :create, :update, :destroy]
      resources :purchases, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      post 'auth/login', to: 'auth#login'
      post 'auth/register', to: 'auth#register'
    end
  end
end
