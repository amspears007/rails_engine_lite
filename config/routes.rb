Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do

      # get "items/find", to: "items_search#search_by_price"
      get "items/find", to: "items_search#search"

      get "merchants/find_all", to: "merchants_search#search"
      
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], controller: 'items_merchant'
      end
    end
  end
end
