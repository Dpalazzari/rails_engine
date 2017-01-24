Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :items do
				get '/find' => 'search#show'
				get '/find_all' => 'search#index'
				get '/random' => 'random#show'
			end

      namespace :invoices do
        get '/find' => 'search#show'
        get '/find_all' => 'search#index'
      end

      resources :invoices, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
    end
  end
end
