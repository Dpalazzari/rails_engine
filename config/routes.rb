Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get '/find' => 'search#show'
        get '/find_all' => 'search#index'
        get '/random' => 'random#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :invoice_items do
        get '/find' => 'search#show'
        get '/find_all' => 'search#index'
        get '/random' => 'random#show'
        get ':id/invoice', to: 'invoice_items_inv#show'
      end
      resources :invoice_items, only: [:index, :show]

      namespace :items do
				get '/find' => 'search#show'
				get '/find_all' => 'search#index'
				get '/random' => 'random#show'
			end
      resources :items, only: [:index, :show]

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get ':id/items', to: 'merchant_items#index'
        get '/:id/invoices', to: 'merchant_invoices#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show]
    end
  end
end
