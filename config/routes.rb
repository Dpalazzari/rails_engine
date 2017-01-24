Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/merchants/find', to: 'merchants_finder#show', as: 'merchant_finder'
      get '/merchants/find_all', to: 'merchants_finder#index', as: 'merchants_finder'
      get '/merchants/random', to: 'random_merchant#show', as: 'random_merchant'
      resources :merchants, only: [:index, :show]
    end
  end
end
