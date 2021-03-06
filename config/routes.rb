Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :customers do
        get '/find',                  to: 'search#show'
        get '/find_all',              to: 'search#index'
        get '/random',                to: 'random#show'
        get '/:id/invoices',          to: 'invoices#index'
        get '/:id/transactions',      to: 'transactions#index'
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get '/find',              to: 'search#show'
        get '/find_all',          to: 'search#index'
        get '/random',            to: 'random#show'
        get '/:id/transactions',  to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items',         to: 'items#index'
        get '/:id/customer',      to: 'customer#show'
        get '/:id/merchant',      to: 'merchant#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :invoice_items do
        get '/find',        to: 'search#show'
        get '/find_all',    to: 'search#index'
        get '/random',      to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item',    to: 'item#show'
      end
      resources :invoice_items, only: [:index, :show]

      namespace :items do
				get '/find',              to: 'search#show'
				get '/find_all',          to: 'search#index'
				get '/random',            to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant',      to: 'merchant#show'
        get '/:id/best_day',      to: 'best_day#show'
        get '/most_revenue',      to: 'most_revenue#index'
        get '/most_items',        to: 'most_items#index'
			end
      resources :items, only: [:index, :show]

      namespace :merchants do
        get '/find',                  to: 'search#show'
        get '/find_all',              to: 'search#index'
        get '/random',                to: 'random#show'
        get '/:id/items',             to: 'items#index'
        get '/:id/invoices',          to: 'invoices#index'
        get '/:id/revenue',           to: 'revenue#show'
        get '/most_items',            to: 'most_items#index'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/revenue',               to: 'total_revenue#show'
        get '/most_revenue',          to: 'most_revenue#index'
        get '/:id/customers_with_pending_invoices', to: 'pending_invoices#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get '/find',        to: 'search#show'
        get '/find_all',    to: 'search#index'
        get '/random',      to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
      end
      resources :transactions, only: [:index, :show]
    end
  end
end
