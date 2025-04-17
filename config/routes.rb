Rails.application.routes.draw do
  devise_for :clients
  require 'sidekiq/web'
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
      
      get 'reports/top_products_by_category', to: 'reports#top_products_by_category'
      get 'reports/top_earning_products_by_category', to: 'reports#top_earning_products_by_category'
      get 'reports/filtered_purchases', to: 'reports#filtered_purchases'
      get 'reports/purchases_by_granularity', to: 'reports#purchases_by_granularity'
    end
  end
end
