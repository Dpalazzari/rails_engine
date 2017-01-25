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
        get ':id/items', to: 'merchant_items#index'
        get '/:id/invoices', to: 'merchant_invoices#index'
      end

      namespace :items do
				get '/find' => 'search#show'
				get '/find_all' => 'search#index'
				get '/random' => 'random#show'
			end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :invoices do
        get '/find' => 'search#show'
        get '/find_all' => 'search#index'
        get '/random' => 'random#show'
        get ':id/transactions', to: 'invoice_transactions#index'
        get ':id/invoice_items', to: 'inv_invoice_items#index'
      end

      namespace :invoice_items do
        get '/find' => 'search#show'
        get '/find_all' => 'search#index'
        get '/random' => 'random#show'
      end

      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
