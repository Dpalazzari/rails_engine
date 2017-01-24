Rails.application.routes.draw do
	namespace :api, defaults: {format: :json} do
		namespace :v1 do
			namespace :items do
				get '/find' => 'search#show'
				get '/find_all' => 'search#index'
			end
			resources :items, only: [:index, :show]
		end
	end
end
